alter table public.profiles enable row level security;
alter table public.professional_roles enable row level security;
alter table public.user_settings enable row level security;
alter table public.organizations enable row level security;
alter table public.organization_memberships enable row level security;
alter table public.audit_events enable row level security;

create function private.is_active() returns boolean language sql stable security definer set search_path = '' as $$
 select exists(select 1 from public.profiles where id = auth.uid() and account_state = 'active')
$$;
create function private.is_admin() returns boolean language sql stable security definer set search_path = '' as $$
 select private.is_active() and exists(select 1 from public.professional_roles where user_id = auth.uid() and role_type = 'admin' and status = 'active')
$$;
create function private.is_member(org uuid) returns boolean language sql stable security definer set search_path = '' as $$
 select private.is_active() and exists(select 1 from public.organization_memberships where organization_id = org and user_id = auth.uid() and membership_status = 'active')
$$;
grant usage on schema private to authenticated;
grant execute on function private.is_active(), private.is_admin(), private.is_member(uuid), private.valid_notification_preferences(jsonb) to authenticated;

revoke all on all tables in schema public from anon, authenticated;
grant select on public.profiles, public.professional_roles, public.user_settings, public.organizations, public.organization_memberships, public.audit_events to authenticated;
grant update(display_name, avatar_path) on public.profiles to authenticated;
grant update(notification_preferences, locale, theme_preference) on public.user_settings to authenticated;
create policy profiles_own_read on public.profiles for select to authenticated using (id = (select auth.uid()));
create policy profiles_own_update on public.profiles for update to authenticated using (id = (select auth.uid()) and private.is_active()) with check (id = (select auth.uid()) and private.is_active());
create policy roles_own_read on public.professional_roles for select to authenticated using (user_id = (select auth.uid()) and private.is_active());
create policy settings_own_read on public.user_settings for select to authenticated using (user_id = (select auth.uid()) and private.is_active());
create policy settings_own_update on public.user_settings for update to authenticated using (user_id = (select auth.uid()) and private.is_active()) with check (user_id = (select auth.uid()) and private.is_active());
create policy organizations_member_read on public.organizations for select to authenticated using (private.is_member(id) or private.is_admin());
create policy memberships_member_read on public.organization_memberships for select to authenticated using (private.is_member(organization_id) or private.is_admin());
create policy audit_admin_read on public.audit_events for select to authenticated using (private.is_admin());

create function public.complete_onboarding(chosen_role public.professional_role, name text) returns public.profiles
language plpgsql security definer set search_path = '' as $$
declare account public.profiles; actor uuid := auth.uid();
begin
 if actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
 if chosen_role is null or chosen_role = 'admin' then raise exception 'Role not permitted' using errcode = '42501'; end if;
 if name is null or char_length(btrim(name)) not between 2 and 80 then raise exception 'Invalid name' using errcode = '22023'; end if;
 select * into account from public.profiles where id = actor for update;
 if not found then raise exception 'Profile missing' using errcode = 'P0002'; end if;
 if account.account_state = 'active' and account.primary_role_label = chosen_role then return account; end if;
 if account.account_state <> 'onboarding' then raise exception 'Account state does not permit onboarding' using errcode = '42501'; end if;
 insert into public.professional_roles(user_id, role_type, is_primary) values(actor, chosen_role, true);
 update public.profiles set display_name = btrim(name), primary_role_label = chosen_role, account_state = 'active' where id = actor returning * into account;
 insert into public.audit_events(actor_user_id, action, entity_type, entity_id) values(actor, 'onboarding_completed', 'profile', actor);
 return account;
end;
$$;

-- Controlled deletion request only. No claim that data has been deleted.
create function public.request_account_deletion() returns uuid
language plpgsql security definer set search_path = '' as $$
declare actor uuid := auth.uid(); receipt uuid; state public.account_state;
begin
 if actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
 select account_state into state from public.profiles where id = actor for update;
 if state is null or state not in ('active', 'deletion_requested') then raise exception 'Account unavailable' using errcode = '42501'; end if;
 insert into public.audit_events(actor_user_id, action, entity_type, entity_id)
 values(actor, 'deletion_requested', 'profile', actor) on conflict do nothing;
 select id into receipt from public.audit_events where entity_id = actor and action = 'deletion_requested';
 update public.profiles set account_state = 'deletion_requested' where id = actor;
 return receipt;
end;
$$;
revoke execute on all functions in schema public from public, anon;
revoke execute on all functions in schema private from public, anon;
grant execute on function public.complete_onboarding(public.professional_role, text), public.request_account_deletion() to authenticated;
