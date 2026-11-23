-- Phase 6: Official Instagram & Meta Graph API Integration
-- 0019_phase06_instagram_integration.sql

-- 1. Create Enums for Instagram Connection Status & Media Types
do $$
begin
  if not exists (select 1 from pg_type where typname = 'instagram_connection_status') then
    create type public.instagram_connection_status as enum (
      'not_connected',
      'connected',
      'expired',
      'permission_revoked',
      'error'
    );
  end if;

  if not exists (select 1 from pg_type where typname = 'instagram_media_type') then
    create type public.instagram_media_type as enum (
      'image',
      'video',
      'carousel_album',
      'reel'
    );
  end if;
end $$;

-- 2. Creator Instagram Connections Table
-- Stores official Meta Graph API connection metadata for registered creators.
-- Strictly separate from public display profiles; access tokens are restricted.
create table if not exists public.creator_instagram_connections (
  creator_id uuid primary key references public.creator_profiles(user_id) on delete cascade,
  instagram_user_id text not null check (char_length(btrim(instagram_user_id)) >= 3),
  instagram_username text not null check (char_length(btrim(instagram_username)) >= 1),
  account_type text default 'BUSINESS',
  status public.instagram_connection_status not null default 'connected',
  authorized_scopes text[] not null default '{}',
  followers_count bigint,
  media_count integer default 0,
  profile_picture_url text,
  last_synced_at timestamptz not null default now(),
  token_expires_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint uq_instagram_user_id unique (instagram_user_id)
);

-- 3. Isolated Vault for Instagram Access Tokens (Server-Side Restricted)
-- Only service_role can access tokens for secure edge-function background refresh.
create table if not exists private.creator_instagram_tokens (
  creator_id uuid primary key references public.creator_profiles(user_id) on delete cascade,
  encrypted_access_token text not null,
  token_type text not null default 'Bearer',
  expires_in integer,
  updated_at timestamptz not null default now()
);

-- 4. Authorized Instagram Media Showcase (Portfolio Feed)
create table if not exists public.creator_instagram_media (
  id uuid primary key default gen_random_uuid(),
  creator_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  instagram_media_id text not null check (char_length(btrim(instagram_media_id)) >= 3),
  media_type public.instagram_media_type not null default 'image',
  media_url text,
  thumbnail_url text,
  permalink text,
  caption text,
  timestamp timestamptz,
  like_count integer default 0,
  comments_count integer default 0,
  created_at timestamptz not null default now(),
  constraint uq_creator_media unique (creator_id, instagram_media_id)
);

-- 5. Enable Row Level Security (RLS)
alter table public.creator_instagram_connections enable row level security;
alter table public.creator_instagram_media enable row level security;

-- Policies for Connections:
-- Creators can view and update their own Instagram connection status
create policy "instagram_connection_self_read"
  on public.creator_instagram_connections for select to authenticated
  using (creator_id = auth.uid());

create policy "instagram_connection_public_read"
  on public.creator_instagram_connections for select to authenticated
  using (status = 'connected');

create policy "instagram_connection_self_write"
  on public.creator_instagram_connections for all to authenticated
  using (creator_id = auth.uid())
  with check (creator_id = auth.uid());

-- Policies for Media:
-- Authenticated users can view permitted public media of connected creators
create policy "instagram_media_select"
  on public.creator_instagram_media for select to authenticated
  using (true);

create policy "instagram_media_self_write"
  on public.creator_instagram_media for all to authenticated
  using (creator_id = auth.uid())
  with check (creator_id = auth.uid());

-- 6. Indexes
create index if not exists idx_ig_conn_username on public.creator_instagram_connections(instagram_username);
create index if not exists idx_ig_conn_status on public.creator_instagram_connections(status);
create index if not exists idx_ig_media_creator on public.creator_instagram_media(creator_id, timestamp desc);

-- 7. Secure Disconnect RPC Function
create or replace function public.disconnect_instagram_account()
returns boolean
language plpgsql security definer set search_path = public as $$
declare
  v_user uuid := auth.uid();
begin
  if v_user is null then
    raise exception 'Authentication required to disconnect Instagram';
  end if;

  update public.creator_instagram_connections
  set status = 'not_connected', updated_at = now()
  where creator_id = v_user;

  delete from private.creator_instagram_tokens
  where creator_id = v_user;

  delete from public.creator_instagram_media
  where creator_id = v_user;

  return true;
end;
$$;

grant execute on function public.disconnect_instagram_account() to authenticated;
