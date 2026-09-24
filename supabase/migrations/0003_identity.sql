create table public.profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 display_name text not null default '' check (char_length(display_name) <= 80),
 avatar_path text check (avatar_path is null or (avatar_path like id::text || '/%' and avatar_path !~ '\.\.')),
 primary_role_label public.professional_role,
 account_state public.account_state not null default 'onboarding',
 verification_status public.verification_status not null default 'unverified',
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(),
 constraint active_profile_name check (account_state <> 'active' or char_length(btrim(display_name)) between 2 and 80)
);
create table public.professional_roles (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references public.profiles(id) on delete cascade,
 role_type public.professional_role not null,
 status public.record_status not null default 'active',
 is_primary boolean not null default false,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create unique index professional_roles_active_pair on public.professional_roles(user_id, role_type) where status = 'active';
create unique index professional_roles_one_primary on public.professional_roles(user_id) where is_primary and status = 'active';

create function private.valid_notification_preferences(value jsonb) returns boolean
language sql immutable set search_path = '' as $$
 select jsonb_typeof(value) = 'object'
 and not exists (select 1 from jsonb_each(case when jsonb_typeof(value) = 'object' then value else '{}'::jsonb end) e
 where e.key not in ('product_updates', 'security_alerts') or jsonb_typeof(e.value) <> 'boolean')
$$;
create table public.user_settings (
 user_id uuid primary key references public.profiles(id) on delete cascade,
 notification_preferences jsonb not null default '{"product_updates":false,"security_alerts":true}'
 check (private.valid_notification_preferences(notification_preferences)),
 locale text not null default 'en' check (locale ~ '^[a-z]{2}(-[A-Z]{2})?$'),
 theme_preference public.theme_preference not null default 'system',
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create trigger profiles_updated before update on public.profiles for each row execute function private.touch_updated_at();
create trigger roles_updated before update on public.professional_roles for each row execute function private.touch_updated_at();
create trigger settings_updated before update on public.user_settings for each row execute function private.touch_updated_at();

-- Auth metadata is deliberately ignored: it is controlled by the client.
create function private.bootstrap_identity() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
 insert into public.profiles(id) values (new.id);
 insert into public.user_settings(user_id) values (new.id);
 return new;
end;
$$;
create trigger auth_user_created after insert on auth.users for each row execute function private.bootstrap_identity();
