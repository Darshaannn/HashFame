-- Phase 2B: Creator Discovery, Search, Shortlists and Comparison
-- 0011_phase2b_discovery_shortlists.sql

-- 1. Enum / Constraints for Shortlist Member Status
create type public.shortlist_member_status as enum (
  'potential',
  'reviewing',
  'backup',
  'negotiating',
  'confirmed',
  'rejected'
);

-- 2. Shortlists Table (Owned by organization)
create table public.shortlists (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations(id) on delete cascade,
  created_by uuid not null references public.profiles(id) on delete set null,
  name text not null check (char_length(btrim(name)) between 2 and 100),
  description text check (description is null or char_length(btrim(description)) <= 500),
  is_archived boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index shortlists_org on public.shortlists(organization_id) where not is_archived;
create trigger shortlists_updated before update on public.shortlists for each row execute function private.touch_updated_at();

-- 3. Shortlist Members Table
create table public.shortlist_members (
  id uuid primary key default gen_random_uuid(),
  shortlist_id uuid not null references public.shortlists(id) on delete cascade,
  creator_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  added_by uuid not null references public.profiles(id) on delete set null,
  status public.shortlist_member_status not null default 'potential',
  notes text check (notes is null or char_length(btrim(notes)) <= 1000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint shortlist_members_unique unique (shortlist_id, creator_id)
);
create index shortlist_members_shortlist on public.shortlist_members(shortlist_id);
create index shortlist_members_creator on public.shortlist_members(creator_id);
create trigger shortlist_members_updated before update on public.shortlist_members for each row execute function private.touch_updated_at();

-- 4. Discovery Indexes for Search & Filter Performance
create index if not exists creator_profiles_availability on public.creator_profiles(availability_status);
create index if not exists creator_profiles_location on public.creator_profiles(country, state, city);
create index if not exists creator_rate_items_pricing on public.creator_rate_items(user_id, price_amount) where is_active;
create index if not exists creator_social_accounts_platform on public.creator_social_accounts(platform, user_provided_follower_count);

-- 5. Row Level Security for Shortlists
alter table public.shortlists enable row level security;
alter table public.shortlist_members enable row level security;

-- Policy: Organization members can read shortlists of their organization
create policy shortlists_org_read on public.shortlists for select to authenticated
  using (private.is_member(organization_id) or private.is_admin());

-- Policy: Organization members can insert shortlists for their organization
create policy shortlists_org_insert on public.shortlists for insert to authenticated
  with check (private.is_member(organization_id) and created_by = (select auth.uid()) and private.is_active());

-- Policy: Organization members can update shortlists in their organization
create policy shortlists_org_update on public.shortlists for update to authenticated
  using (private.is_member(organization_id) or private.is_admin())
  with check (private.is_member(organization_id) or private.is_admin());

-- Policy: Organization members can delete shortlists in their organization
create policy shortlists_org_delete on public.shortlists for delete to authenticated
  using (private.is_member(organization_id) or private.is_admin());

-- Shortlist Members Policies
-- Policy: Organization members can read shortlist members for lists belonging to their organization
create policy shortlist_members_org_read on public.shortlist_members for select to authenticated
  using (
    exists (
      select 1 from public.shortlists s
      where s.id = shortlist_members.shortlist_id
        and (private.is_member(s.organization_id) or private.is_admin())
    )
  );

-- Policy: Organization members can add creators to their organization's shortlists
create policy shortlist_members_org_insert on public.shortlist_members for insert to authenticated
  with check (
    added_by = (select auth.uid())
    and private.is_active()
    and exists (
      select 1 from public.shortlists s
      where s.id = shortlist_members.shortlist_id
        and (private.is_member(s.organization_id) or private.is_admin())
    )
  );

-- Policy: Organization members can update members (e.g. status, notes) in their organization's shortlists
create policy shortlist_members_org_update on public.shortlist_members for update to authenticated
  using (
    exists (
      select 1 from public.shortlists s
      where s.id = shortlist_members.shortlist_id
        and (private.is_member(s.organization_id) or private.is_admin())
    )
  )
  with check (
    exists (
      select 1 from public.shortlists s
      where s.id = shortlist_members.shortlist_id
        and (private.is_member(s.organization_id) or private.is_admin())
    )
  );

-- Policy: Organization members can remove creators from their organization's shortlists
create policy shortlist_members_org_delete on public.shortlist_members for delete to authenticated
  using (
    exists (
      select 1 from public.shortlists s
      where s.id = shortlist_members.shortlist_id
        and (private.is_member(s.organization_id) or private.is_admin())
    )
  );

-- Grants
grant select, insert, update, delete on public.shortlists, public.shortlist_members to authenticated;
