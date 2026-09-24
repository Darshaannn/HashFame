-- Phase 2A: Product Domain Foundation + Professional Profiles
-- 0009_phase2a_domain.sql

-- 1. Additional enums for Phase 2A domain
create type public.social_platform as enum ('instagram', 'youtube', 'facebook', 'x', 'linkedin', 'other');
create type public.social_connection_status as enum ('self_reported', 'connected', 'disconnected');
create type public.field_verification_status as enum ('not_started', 'pending', 'verified', 'rejected', 'expired');
create type public.verification_subject as enum ('identity', 'phone', 'email', 'social_account', 'company', 'manager_relationship');
create type public.deliverable_type as enum (
  'instagram_reel', 'instagram_story', 'instagram_post',
  'youtube_video', 'youtube_integration', 'youtube_short',
  'ugc_video', 'other'
);
create type public.portfolio_content_type as enum ('video', 'image', 'article', 'campaign', 'other');
create type public.collaboration_proof_type as enum ('self_reported', 'platform_observed', 'ggs_verified');
create type public.availability_status as enum ('open', 'limited', 'unavailable');
create type public.manager_relationship_status as enum ('pending', 'accepted', 'revoked');

-- 2. Master Reference Data: Categories & Subcategories
create table public.categories (
  id uuid primary key default gen_random_uuid(),
  parent_id uuid references public.categories(id) on delete cascade,
  name text not null check (char_length(btrim(name)) between 2 and 60),
  slug text not null check (slug ~ '^[a-z0-9-]+$'),
  sort_order int not null default 0,
  created_at timestamptz not null default now(),
  constraint categories_slug_unique unique(slug)
);
create index categories_parent_id on public.categories(parent_id);

-- 3. Master Reference Data: Languages
create table public.languages (
  code text primary key check (code ~ '^[a-z]{2,3}(-[A-Za-z0-9]+)?$'),
  name text not null check (char_length(btrim(name)) between 2 and 60),
  native_name text not null check (char_length(btrim(native_name)) between 2 and 60),
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

-- 4. Creator Profiles Extension
create table public.creator_profiles (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  professional_name text check (professional_name is null or char_length(btrim(professional_name)) between 2 and 80),
  bio text check (bio is null or char_length(btrim(bio)) <= 1000),
  city text check (city is null or char_length(btrim(city)) between 2 and 80),
  state text check (state is null or char_length(btrim(state)) between 2 and 80),
  country text not null default 'IN' check (country ~ '^[A-Z]{2}$'),
  availability_status public.availability_status not null default 'open',
  available_from date,
  is_represented boolean not null default false,
  onboarding_step int not null default 1,
  onboarding_completed boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger creator_profiles_updated before update on public.creator_profiles for each row execute function private.touch_updated_at();

-- 5. Creator Categories (Junction)
create table public.creator_categories (
  user_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  category_id uuid not null references public.categories(id) on delete cascade,
  is_primary boolean not null default false,
  created_at timestamptz not null default now(),
  primary key (user_id, category_id)
);
create unique index creator_categories_primary on public.creator_categories(user_id) where is_primary;
create index creator_categories_cat on public.creator_categories(category_id);

-- 6. Creator Languages (Junction)
create table public.creator_languages (
  user_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  language_code text not null references public.languages(code) on delete cascade,
  is_primary boolean not null default false,
  created_at timestamptz not null default now(),
  primary key (user_id, language_code)
);
create unique index creator_languages_primary on public.creator_languages(user_id) where is_primary;

-- 7. Creator Social Accounts
create table public.creator_social_accounts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  platform public.social_platform not null,
  handle text not null check (char_length(btrim(handle)) between 1 and 100),
  profile_url text check (profile_url is null or profile_url ~ '^https?://[^\s]+$'),
  user_provided_follower_count bigint check (user_provided_follower_count is null or user_provided_follower_count >= 0),
  connection_status public.social_connection_status not null default 'self_reported',
  verification_status public.field_verification_status not null default 'not_started',
  last_verified_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint creator_social_platform_handle unique (user_id, platform, handle)
);
create index creator_social_accounts_user on public.creator_social_accounts(user_id);
create trigger creator_social_accounts_updated before update on public.creator_social_accounts for each row execute function private.touch_updated_at();

-- 8. Creator Rate Items
create table public.creator_rate_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  deliverable_type public.deliverable_type not null,
  custom_title text check (custom_title is null or char_length(btrim(custom_title)) between 2 and 100),
  price_amount numeric(12, 2) not null check (price_amount >= 0),
  currency text not null default 'INR' check (currency ~ '^[A-Z]{3}$'),
  description text check (description is null or char_length(btrim(description)) <= 500),
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index creator_rate_items_user on public.creator_rate_items(user_id) where is_active;
create trigger creator_rate_items_updated before update on public.creator_rate_items for each row execute function private.touch_updated_at();

-- 9. Creator Portfolio Items
create table public.creator_portfolio_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  title text not null check (char_length(btrim(title)) between 2 and 120),
  description text check (description is null or char_length(btrim(description)) <= 1000),
  platform public.social_platform,
  content_url text check (content_url is null or content_url ~ '^https?://[^\s]+$'),
  media_path text check (media_path is null or (media_path like user_id::text || '/%' and media_path !~ '\.\.')),
  brand_name text check (brand_name is null or char_length(btrim(brand_name)) between 2 and 100),
  published_date date,
  content_type public.portfolio_content_type not null default 'video',
  sort_order int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index creator_portfolio_items_user on public.creator_portfolio_items(user_id);
create trigger creator_portfolio_items_updated before update on public.creator_portfolio_items for each row execute function private.touch_updated_at();

-- 10. Creator Past Collaborations
create table public.creator_collaborations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  brand_name text not null check (char_length(btrim(brand_name)) between 2 and 100),
  campaign_name text check (campaign_name is null or char_length(btrim(campaign_name)) between 2 and 120),
  collaboration_year int check (collaboration_year between 2000 and 2100),
  deliverable_type public.deliverable_type not null default 'instagram_reel',
  proof_url text check (proof_url is null or proof_url ~ '^https?://[^\s]+$'),
  proof_type public.collaboration_proof_type not null default 'self_reported',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index creator_collaborations_user on public.creator_collaborations(user_id);
create trigger creator_collaborations_updated before update on public.creator_collaborations for each row execute function private.touch_updated_at();

-- 11. Company Brands (Under Organizations)
create table public.company_brands (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations(id) on delete cascade,
  name text not null check (char_length(btrim(name)) between 2 and 120),
  logo_path text check (logo_path is null or logo_path !~ '\.\.'),
  industry text check (industry is null or char_length(btrim(industry)) <= 80),
  website text check (website is null or website ~ '^https?://[^\s]+$'),
  description text check (description is null or char_length(btrim(description)) <= 1000),
  headquarters text check (headquarters is null or char_length(btrim(headquarters)) <= 120),
  status public.record_status not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index company_brands_org on public.company_brands(organization_id);
create trigger company_brands_updated before update on public.company_brands for each row execute function private.touch_updated_at();

-- 12. Brand Marketer Professional Profiles
create table public.brand_marketer_profiles (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  job_title text check (job_title is null or char_length(btrim(job_title)) between 2 and 100),
  work_email text check (work_email is null or work_email ~ '^[^\s@]+@[^\s@]+\.[^\s@]+$'),
  phone text check (phone is null or phone ~ '^\+[1-9]\d{7,14}$'),
  bio text check (bio is null or char_length(btrim(bio)) <= 1000),
  organization_id uuid references public.organizations(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger brand_marketer_profiles_updated before update on public.brand_marketer_profiles for each row execute function private.touch_updated_at();

-- 13. Agency Profiles
create table public.agency_profiles (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  agency_name text not null check (char_length(btrim(agency_name)) between 2 and 120),
  website text check (website is null or website ~ '^https?://[^\s]+$'),
  description text check (description is null or char_length(btrim(description)) <= 1000),
  location text check (location is null or char_length(btrim(location)) <= 120),
  services text[] default '{}',
  organization_id uuid references public.organizations(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger agency_profiles_updated before update on public.agency_profiles for each row execute function private.touch_updated_at();

-- 14. Talent Manager Profiles
create table public.talent_manager_profiles (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  bio text check (bio is null or char_length(btrim(bio)) <= 1000),
  company_name text check (company_name is null or char_length(btrim(company_name)) between 2 and 120),
  organization_id uuid references public.organizations(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger talent_manager_profiles_updated before update on public.talent_manager_profiles for each row execute function private.touch_updated_at();

-- 15. Creator-Manager Relationships (Requiring creator confirmation)
create table public.creator_manager_relationships (
  id uuid primary key default gen_random_uuid(),
  creator_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  manager_id uuid not null references public.talent_manager_profiles(user_id) on delete cascade,
  status public.manager_relationship_status not null default 'pending',
  notes text check (notes is null or char_length(btrim(notes)) <= 500),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint creator_manager_unique unique (creator_id, manager_id)
);
create index creator_manager_creator on public.creator_manager_relationships(creator_id);
create index creator_manager_manager on public.creator_manager_relationships(manager_id);
create trigger creator_manager_updated before update on public.creator_manager_relationships for each row execute function private.touch_updated_at();

-- 16. Field-Level Verifications (Server/Admin controlled trusted status)
create table public.field_verifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  subject public.verification_subject not null,
  subject_id text not null default '',
  status public.field_verification_status not null default 'not_started',
  verified_at timestamptz,
  expires_at timestamptz,
  notes text check (notes is null or char_length(btrim(notes)) <= 500),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint field_verifications_subject_user unique (user_id, subject, subject_id)
);
create index field_verifications_user on public.field_verifications(user_id);
create trigger field_verifications_updated before update on public.field_verifications for each row execute function private.touch_updated_at();

-- 17. Row Level Security Setup
alter table public.categories enable row level security;
alter table public.languages enable row level security;
alter table public.creator_profiles enable row level security;
alter table public.creator_categories enable row level security;
alter table public.creator_languages enable row level security;
alter table public.creator_social_accounts enable row level security;
alter table public.creator_rate_items enable row level security;
alter table public.creator_portfolio_items enable row level security;
alter table public.creator_collaborations enable row level security;
alter table public.company_brands enable row level security;
alter table public.brand_marketer_profiles enable row level security;
alter table public.agency_profiles enable row level security;
alter table public.talent_manager_profiles enable row level security;
alter table public.creator_manager_relationships enable row level security;
alter table public.field_verifications enable row level security;

-- Master reference data: Anyone authenticated can read
create policy categories_read on public.categories for select to authenticated using (true);
create policy languages_read on public.languages for select to authenticated using (true);

-- Creator Profile & Child Tables Policies
create policy creator_profiles_read on public.creator_profiles for select to authenticated using (private.is_active());
create policy creator_profiles_insert on public.creator_profiles for insert to authenticated with check (user_id = (select auth.uid()) and private.is_active());
create policy creator_profiles_update on public.creator_profiles for update to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

create policy creator_categories_read on public.creator_categories for select to authenticated using (private.is_active());
create policy creator_categories_write on public.creator_categories for all to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

create policy creator_languages_read on public.creator_languages for select to authenticated using (private.is_active());
create policy creator_languages_write on public.creator_languages for all to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

create policy creator_social_read on public.creator_social_accounts for select to authenticated using (private.is_active());
create policy creator_social_write on public.creator_social_accounts for all to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

create policy creator_rate_read on public.creator_rate_items for select to authenticated using (private.is_active());
create policy creator_rate_write on public.creator_rate_items for all to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

create policy creator_portfolio_read on public.creator_portfolio_items for select to authenticated using (private.is_active());
create policy creator_portfolio_write on public.creator_portfolio_items for all to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

create policy creator_collab_read on public.creator_collaborations for select to authenticated using (private.is_active());
create policy creator_collab_write on public.creator_collaborations for all to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

-- Company Brands Policies
create policy company_brands_read on public.company_brands for select to authenticated using (private.is_active());
create policy company_brands_write on public.company_brands for all to authenticated using (private.is_member(organization_id) or private.is_admin()) with check (private.is_member(organization_id) or private.is_admin());

-- Professional Profiles (Brand Marketer, Agency, Talent Manager)
create policy brand_profiles_read on public.brand_marketer_profiles for select to authenticated using (private.is_active());
create policy brand_profiles_write on public.brand_marketer_profiles for all to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

create policy agency_profiles_read on public.agency_profiles for select to authenticated using (private.is_active());
create policy agency_profiles_write on public.agency_profiles for all to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

create policy manager_profiles_read on public.talent_manager_profiles for select to authenticated using (private.is_active());
create policy manager_profiles_write on public.talent_manager_profiles for all to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());

-- Creator Manager Relationships
create policy creator_manager_read on public.creator_manager_relationships for select to authenticated using (
  (creator_id = (select auth.uid()) or manager_id = (select auth.uid()) or private.is_admin()) and private.is_active()
);
create policy creator_manager_insert on public.creator_manager_relationships for insert to authenticated with check (
  manager_id = (select auth.uid()) and status = 'pending' and private.is_active()
);
create policy creator_manager_update on public.creator_manager_relationships for update to authenticated using (
  (creator_id = (select auth.uid()) or manager_id = (select auth.uid()) or private.is_admin()) and private.is_active()
) with check (
  (creator_id = (select auth.uid()) or manager_id = (select auth.uid()) or private.is_admin()) and private.is_active()
);
create policy creator_manager_delete on public.creator_manager_relationships for delete to authenticated using (
  (creator_id = (select auth.uid()) or manager_id = (select auth.uid()) or private.is_admin()) and private.is_active()
);

-- Field Verifications (Public summary read, admin/system only write)
create policy field_verifications_read on public.field_verifications for select to authenticated using (private.is_active());
create policy field_verifications_admin_write on public.field_verifications for all to authenticated using (private.is_admin()) with check (private.is_admin());

-- 18. Grants & Privileges
grant select on public.categories, public.languages, public.creator_profiles, public.creator_categories,
  public.creator_languages, public.creator_social_accounts, public.creator_rate_items,
  public.creator_portfolio_items, public.creator_collaborations, public.company_brands,
  public.brand_marketer_profiles, public.agency_profiles, public.talent_manager_profiles,
  public.creator_manager_relationships, public.field_verifications to authenticated;

grant insert, update, delete on public.creator_profiles, public.creator_categories,
  public.creator_languages, public.creator_social_accounts, public.creator_rate_items,
  public.creator_portfolio_items, public.creator_collaborations, public.company_brands,
  public.brand_marketer_profiles, public.agency_profiles, public.talent_manager_profiles,
  public.creator_manager_relationships to authenticated;
