create table public.organizations (
 id uuid primary key default gen_random_uuid(), type public.organization_type not null,
 name text not null check (char_length(btrim(name)) between 2 and 120),
 website_domain text check (website_domain ~ '^[a-z0-9][a-z0-9.-]*\.[a-z]{2,}$'),
 status public.record_status not null default 'active',
 created_by uuid not null references public.profiles(id),
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table public.organization_memberships (
 organization_id uuid not null references public.organizations(id) on delete cascade,
 user_id uuid not null references public.profiles(id) on delete cascade,
 membership_role public.membership_role not null default 'member',
 membership_status public.record_status not null default 'active',
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(),
 primary key (organization_id, user_id)
);
create index organization_memberships_user on public.organization_memberships(user_id, organization_id) where membership_status = 'active';
create index organizations_created_by on public.organizations(created_by);
create trigger organizations_updated before update on public.organizations for each row execute function private.touch_updated_at();
create trigger memberships_updated before update on public.organization_memberships for each row execute function private.touch_updated_at();
