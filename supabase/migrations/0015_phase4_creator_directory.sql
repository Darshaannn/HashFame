-- Phase 4B / Staging: Imported Creator Directory Schema & Linkage
-- 0015_phase4_creator_directory.sql

-- 1. Create directory verification / source status type
create type public.directory_verification_status as enum (
  'unverified_directory',
  'claimed',
  'verified_creator'
);

-- 2. Clean imported creator directory table
create table if not exists public.creator_directory (
  directory_id text primary key,
  display_name text not null check (char_length(btrim(display_name)) >= 1),
  instagram_handle text,
  instagram_profile_url text,
  followers_count bigint,
  followers_raw text,
  is_followers_ambiguous boolean not null default false,
  categories text[] not null default '{}',
  city text,
  image_path text,
  cover_image_path text,
  portfolio_thumbnails text[] not null default '{}',
  sources text[] not null default '{}',
  verification_status public.directory_verification_status not null default 'unverified_directory',
  linked_creator_user_id uuid references public.creator_profiles(user_id) on delete set null,
  data_source_label text not null default 'Spreadsheet Listing (Unverified)',
  imported_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 3. Commercial & Private Information Table (Restricted Domain)
-- Accessible only by service role or authorized admin/pricing role. NOT publicly readable.
create table if not exists public.creator_directory_commercial (
  directory_id text primary key references public.creator_directory(directory_id) on delete cascade,
  raw_commercial_data jsonb not null default '{}'::jsonb,
  private_contact jsonb not null default '{}'::jsonb,
  is_verified_pricing boolean not null default false,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 4. Enable RLS
alter table public.creator_directory enable row level security;
alter table public.creator_directory_commercial enable row level security;

-- 5. RLS Policies:
-- Creator Directory is publicly readable for authenticated brands, agencies, and creators
create policy "creator_directory_read_authenticated"
  on public.creator_directory
  for select
  to authenticated
  using (true);

-- Anonymous read for discovery if enabled
create policy "creator_directory_read_anon"
  on public.creator_directory
  for select
  to anon
  using (true);

-- Commercial table is RESTRICTED: No direct select for regular authenticated users
-- Only service_role can read or write by default
create policy "creator_directory_commercial_service_role"
  on public.creator_directory_commercial
  for all
  to service_role
  using (true)
  with check (true);

-- 6. Indexes for performant discovery & search
create index if not exists idx_creator_dir_handle on public.creator_directory(instagram_handle);
create index if not exists idx_creator_dir_city on public.creator_directory(city);
create index if not exists idx_creator_dir_followers on public.creator_directory(followers_count);
create index if not exists idx_creator_dir_categories on public.creator_directory using gin(categories);

-- 7. Update Shortlist Members Table to allow directory creators
-- Modify shortlist_members to reference either a registered creator_profile or a directory_id
alter table public.shortlist_members drop constraint if exists shortlist_members_creator_id_fkey;
-- creator_id in shortlist_members remains uuid or text compatible.

