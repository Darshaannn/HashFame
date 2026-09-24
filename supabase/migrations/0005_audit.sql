create table public.audit_events (
 id uuid primary key default gen_random_uuid(), actor_user_id uuid references public.profiles(id) on delete set null,
 action text not null check (action in ('onboarding_completed', 'deletion_requested')),
 entity_type text not null check (entity_type = 'profile'), entity_id uuid not null,
 metadata jsonb not null default '{}' check (metadata = '{}'::jsonb),
 created_at timestamptz not null default now()
);
create index audit_events_actor_created on public.audit_events(actor_user_id, created_at desc);
create unique index audit_events_deletion_once on public.audit_events(entity_id, action) where action = 'deletion_requested';
create function private.audit_immutable() returns trigger language plpgsql set search_path = '' as $$
begin
 -- Allow only the FK's anonymization when a profile is eventually deleted.
 if TG_OP = 'UPDATE' and old.actor_user_id is not null and new.actor_user_id is null
 and (to_jsonb(new) - 'actor_user_id') = (to_jsonb(old) - 'actor_user_id') then return new; end if;
 raise exception 'Audit events are append only' using errcode = '42501';
end;
$$;
create trigger audit_immutable before update or delete on public.audit_events for each row execute function private.audit_immutable();
