begin;
create function pg_temp.assert_true(ok boolean, label text) returns void language plpgsql as $$
begin if ok is distinct from true then raise exception 'FAIL: %', label; end if; raise notice 'PASS: %', label; end;
$$;
create function pg_temp.denied(statement text, label text) returns void language plpgsql as $$
begin
 begin execute statement;
 exception when insufficient_privilege or check_violation or invalid_parameter_value or unique_violation or invalid_text_representation or foreign_key_violation then
 raise notice 'PASS: %', label; return;
 end;
 raise exception 'FAIL: expected rejection: %', label;
end;
$$;

select pg_temp.assert_true((select count(*) = 6 from pg_tables where schemaname = 'public' and rowsecurity), 'all six tables have RLS');
select pg_temp.assert_true((select count(*) = 2 from storage.buckets where not public and id in ('avatars','verification')), 'private storage buckets');
select pg_temp.denied($s$insert into public.professional_roles(user_id, role_type) values ('11111111-1111-4111-8111-111111111111','creator')$s$, 'duplicate active role rejected');
select pg_temp.denied($s$insert into public.professional_roles(user_id, role_type, is_primary) values ('11111111-1111-4111-8111-111111111111','agency',true)$s$, 'duplicate primary rejected');
select pg_temp.denied($s$insert into public.professional_roles(user_id, role_type) values ('99999999-9999-4999-8999-999999999999','creator')$s$, 'orphan role rejected');
insert into public.organizations(id, type, name, created_by) values ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','brand','Test Brand','11111111-1111-4111-8111-111111111111');
insert into public.organization_memberships(organization_id, user_id) values ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','11111111-1111-4111-8111-111111111111');

set local role anon;
select pg_temp.denied('select * from public.profiles', 'anonymous cannot read private profiles');
select pg_temp.denied('select public.request_account_deletion()', 'anonymous cannot invoke deletion');
reset role;
set local role authenticated;
select set_config('request.jwt.claim.sub','11111111-1111-4111-8111-111111111111',true);
select pg_temp.assert_true((select count(*) = 1 from public.profiles), 'user reads only own profile');
select pg_temp.assert_true((select count(*) = 1 from public.user_settings), 'user reads only own settings');
select pg_temp.assert_true((select count(*) = 1 from public.professional_roles), 'user reads only own roles');
select pg_temp.assert_true((select count(*) = 1 from public.organizations), 'member reads organization');
select pg_temp.assert_true((select count(*) = 1 from public.organization_memberships), 'member reads memberships');
update public.profiles set display_name = 'Updated A' where id = '11111111-1111-4111-8111-111111111111';
select pg_temp.assert_true((select display_name = 'Updated A' from public.profiles), 'own permitted profile edit succeeds');
with changed as (update public.profiles set display_name = 'Hacked' where id = '22222222-2222-4222-8222-222222222222' returning id)
 select pg_temp.assert_true((select count(*) = 0 from changed), 'A cannot update B');
with changed as (update public.user_settings set locale = 'fr' where user_id = '22222222-2222-4222-8222-222222222222' returning user_id)
 select pg_temp.assert_true((select count(*) = 0 from changed), 'A cannot change B settings');
select pg_temp.denied($s$update public.profiles set account_state = 'blocked'$s$, 'client cannot mutate account state');
select pg_temp.denied($s$update public.profiles set primary_role_label = 'admin'$s$, 'client cannot change primary role label');
select pg_temp.denied($s$update public.profiles set verification_status = 'verified'$s$, 'client cannot self-verify');
select pg_temp.denied($s$insert into public.professional_roles(user_id,role_type) values ('11111111-1111-4111-8111-111111111111','admin')$s$, 'client cannot insert admin');
select pg_temp.denied($s$select public.complete_onboarding('admin','Attacker')$s$, 'RPC rejects self-admin');
select pg_temp.denied($s$insert into public.audit_events(action,entity_type,entity_id) values ('deletion_requested','profile','11111111-1111-4111-8111-111111111111')$s$, 'client cannot forge audit');
select pg_temp.denied($s$insert into public.organization_memberships(organization_id,user_id,membership_role) values ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','22222222-2222-4222-8222-222222222222','owner')$s$, 'client cannot grant membership');
select pg_temp.denied($s$update public.user_settings set notification_preferences = '{"unknown":true}'$s$, 'unknown preference keys rejected');
select pg_temp.denied($s$update public.user_settings set notification_preferences = '{"product_updates":"yes"}'$s$, 'nonboolean preference rejected');
select pg_temp.denied($s$update public.user_settings set notification_preferences = '[]'$s$, 'array preferences rejected');
select pg_temp.denied($s$update public.profiles set display_name = 'x'$s$, 'invalid profile name rejected');
select pg_temp.denied($s$update public.profiles set avatar_path = '22222222-2222-4222-8222-222222222222/a.png'$s$, 'foreign avatar path rejected');
update public.user_settings set locale = 'fr', notification_preferences = '{"product_updates":true}';
select pg_temp.assert_true((select locale = 'fr' from public.user_settings), 'valid settings accepted');
insert into storage.objects(bucket_id,name) values('avatars','11111111-1111-4111-8111-111111111111/a.png');
select pg_temp.assert_true((select count(*) = 1 from storage.objects), 'owner avatar accessible');
select pg_temp.denied($s$insert into storage.objects(bucket_id,name) values('avatars','22222222-2222-4222-8222-222222222222/a.png')$s$, 'foreign avatar upload denied');
select pg_temp.denied($s$insert into storage.objects(bucket_id,name) values('verification','11111111-1111-4111-8111-111111111111/a.pdf')$s$, 'verification upload default denied');
select set_config('request.jwt.claim.sub','22222222-2222-4222-8222-222222222222',true);
select pg_temp.assert_true((select count(*) = 0 from public.organizations), 'nonmember cannot read organization');
select pg_temp.assert_true((select count(*) = 0 from public.organization_memberships), 'nonmember cannot read memberships');
select pg_temp.assert_true((select count(*) = 0 from storage.objects), 'B cannot read A avatar');
with changed as (update storage.objects set name = '22222222-2222-4222-8222-222222222222/stolen.png' returning id)
 select pg_temp.assert_true((select count(*) = 0 from changed), 'B cannot update A avatar');
with changed as (delete from storage.objects returning id)
 select pg_temp.assert_true((select count(*) = 0 from changed), 'B cannot delete A avatar');
reset role;

insert into auth.users(id, raw_user_meta_data) values('44444444-4444-4444-8444-444444444444','{"role":"admin"}');
select pg_temp.assert_true((select account_state = 'onboarding' and primary_role_label is null from public.profiles where id = '44444444-4444-4444-8444-444444444444'), 'untrusted auth metadata ignored');
select pg_temp.assert_true((select count(*) = 1 from public.user_settings where user_id = '44444444-4444-4444-8444-444444444444'), 'first login settings transaction');
set local role authenticated;
select set_config('request.jwt.claim.sub','44444444-4444-4444-8444-444444444444',true);
select pg_temp.denied($s$select public.complete_onboarding('creator',' ')$s$, 'onboarding invalid input rejected');
select public.complete_onboarding('creator','Fresh Creator');
select public.complete_onboarding('creator','Fresh Creator');
select pg_temp.assert_true((select count(*) = 1 from public.professional_roles), 'duplicate onboarding idempotent');
select pg_temp.denied($s$select public.complete_onboarding('agency','Fresh Creator')$s$, 'onboarding cannot change existing role');
select pg_temp.assert_true(public.request_account_deletion() = public.request_account_deletion(), 'deletion request idempotent');
select pg_temp.assert_true((select account_state = 'deletion_requested' from public.profiles), 'deletion request state visible');
with changed as (update public.profiles set display_name = 'Changed' returning id)
 select pg_temp.assert_true((select count(*) = 0 from changed), 'restricted account cannot edit');
select pg_temp.assert_true((select count(*) = 0 from public.audit_events), 'ordinary user cannot read audit');
select set_config('request.jwt.claim.sub','33333333-3333-4333-8333-333333333333',true);
select pg_temp.assert_true((select count(*) = 2 from public.audit_events), 'assigned admin reads controlled audit');
select pg_temp.denied($s$delete from public.audit_events$s$, 'admin client cannot delete audit');
reset role;
select pg_temp.denied($s$update public.audit_events set action = 'onboarding_completed'$s$, 'audit immutable even through server SQL');
rollback;
