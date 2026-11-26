-- Phase 4: Online Creator Directory & Shortlist Integration
-- 0017_phase04_online_directory_integration.sql

-- 1. Upgrade shortlist_members to cleanly support both Registered Creators (UUID)
-- and Imported Directory Creators (text directory_id) with strict data integrity.
do $$
begin
  -- Make creator_id nullable if not already nullable
  alter table public.shortlist_members alter column creator_id drop not null;

  -- Add directory_id column if not exists
  if not exists (
    select 1 from information_schema.columns 
    where table_schema = 'public' 
    and table_name = 'shortlist_members' 
    and column_name = 'directory_id'
  ) then
    alter table public.shortlist_members 
      add column directory_id text references public.creator_directory(directory_id) on delete cascade;
  end if;
end $$;

-- Drop legacy unique constraint on (shortlist_id, creator_id) if exists
alter table public.shortlist_members drop constraint if exists shortlist_members_unique;

-- Ensure either creator_id (registered UUID) or directory_id (imported directory) is populated
do $$
begin
  if not exists (
    select 1 from pg_constraint 
    where conname = 'chk_shortlist_member_target'
  ) then
    alter table public.shortlist_members 
      add constraint chk_shortlist_member_target 
      check (
        (creator_id is not null and directory_id is null) or
        (creator_id is null and directory_id is not null)
      );
  end if;
end $$;

-- Create partial unique indexes to prevent duplicate entries in a shortlist
create unique index if not exists uq_shortlist_registered_creator
  on public.shortlist_members(shortlist_id, creator_id)
  where creator_id is not null;

create unique index if not exists uq_shortlist_directory_creator
  on public.shortlist_members(shortlist_id, directory_id)
  where directory_id is not null;

create index if not exists idx_shortlist_members_dir on public.shortlist_members(directory_id);

-- 2. Refine creator_directory Search Capabilities & Security
-- Ensure authenticated users have fast, indexed text search across name, handle, categories and city
create index if not exists idx_creator_dir_search_name 
  on public.creator_directory using gin(to_tsvector('english', display_name));

-- Enable pg_trgm trigram index if extension exists for fuzzy name and handle search
do $$
begin
  if exists (select 1 from pg_extension where extname = 'pg_trgm') then
    execute 'create index if not exists idx_creator_dir_name_trgm on public.creator_directory using gin(display_name gin_trgm_ops);';
    execute 'create index if not exists idx_creator_dir_handle_trgm on public.creator_directory using gin(instagram_handle gin_trgm_ops);';
  end if;
end $$;

-- 3. Add directory account-claim security verification check
-- Prevents ordinary users from mutating linked_creator_user_id without administrative or verification trust.
create or replace function public.claim_directory_profile(p_directory_id text)
returns boolean
language plpgsql security definer set search_path = public as $$
declare
  v_current_user uuid := auth.uid();
  v_existing_link uuid;
  v_dir_handle text;
  v_is_verified_owner boolean := false;
begin
  if v_current_user is null then
    raise exception 'Authentication required to claim directory profile';
  end if;

  select linked_creator_user_id, instagram_handle
  into v_existing_link, v_dir_handle
  from public.creator_directory
  where directory_id = p_directory_id
  for update;

  if not found then
    raise exception 'Directory profile not found: %', p_directory_id;
  end if;

  if v_existing_link is not null then
    if v_existing_link = v_current_user then
      return true; -- already claimed by caller
    else
      raise exception 'This directory profile has already been claimed by another creator';
    end if;
  end if;

  -- Require either an authorized admin or a connected Instagram account matching the directory handle
  if private.is_admin() then
    v_is_verified_owner := true;
  elsif v_dir_handle is not null then
    select exists (
      select 1 from public.creator_instagram_connections c
      where c.creator_id = v_current_user
        and c.status = 'connected'
        and lower(ltrim(c.instagram_username, '@')) = lower(ltrim(v_dir_handle, '@'))
    ) into v_is_verified_owner;
  end if;

  if not v_is_verified_owner then
    raise exception 'Ownership verification required: connect the matching Instagram account or contact an administrator';
  end if;

  update public.creator_directory
  set
    linked_creator_user_id = v_current_user,
    verification_status = 'claimed',
    updated_at = now()
  where directory_id = p_directory_id;

  return true;
end;
$$;

grant execute on function public.claim_directory_profile(text) to authenticated;
