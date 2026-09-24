-- Phase 2A SQL & RLS Security Tests
-- supabase/tests/phase2a_security.sql

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

-- 1. Check all new tables have RLS enabled
select pg_temp.assert_true((select count(*) = 21 from pg_tables where schemaname = 'public' and rowsecurity), 'all 21 public tables have RLS');

-- 2. Verify categories and languages are read-only for anonymous, readable for authenticated
set local role anon;
select pg_temp.denied('select * from public.categories', 'anonymous cannot read categories directly if unauthenticated');
select pg_temp.denied('insert into public.categories(name, slug) values (''Hacked'', ''hacked'')', 'anonymous cannot insert category');
reset role;

-- 3. Authenticated creator checks
set local role authenticated;
select set_config('request.jwt.claim.sub','11111111-1111-4111-8111-111111111111',true);

-- Category read
select pg_temp.assert_true((select count(*) >= 10 from public.categories), 'authenticated user can read categories');
select pg_temp.assert_true((select count(*) >= 10 from public.languages), 'authenticated user can read languages');

-- Creator Profile CRUD
insert into public.creator_profiles (user_id, bio, city, state, country)
values ('11111111-1111-4111-8111-111111111111', 'Creator Bio', 'Mumbai', 'Maharashtra', 'IN');
select pg_temp.assert_true((select count(*) = 1 from public.creator_profiles where user_id = '11111111-1111-4111-8111-111111111111'), 'creator can insert own profile');

-- Creator Rate Item
insert into public.creator_rate_items (id, user_id, deliverable_type, price_amount, currency)
values ('r1111111-1111-4111-8111-111111111111', '11111111-1111-4111-8111-111111111111', 'instagram_reel', 25000, 'INR');
select pg_temp.assert_true((select count(*) = 1 from public.creator_rate_items where user_id = '11111111-1111-4111-8111-111111111111'), 'creator can insert own rate item');

-- Creator Social Account
insert into public.creator_social_accounts (id, user_id, platform, handle, user_provided_follower_count)
values ('s1111111-1111-4111-8111-111111111111', '11111111-1111-4111-8111-111111111111', 'instagram', 'creator_official', 50000);
select pg_temp.assert_true((select count(*) = 1 from public.creator_social_accounts where user_id = '11111111-1111-4111-8111-111111111111'), 'creator can insert own social account');

-- Creator Portfolio Item
insert into public.creator_portfolio_items (id, user_id, title, content_type)
values ('p1111111-1111-4111-8111-111111111111', '11111111-1111-4111-8111-111111111111', 'Sample Reel', 'video');
select pg_temp.assert_true((select count(*) = 1 from public.creator_portfolio_items where user_id = '11111111-1111-4111-8111-111111111111'), 'creator can insert own portfolio item');

-- Creator Collaboration
insert into public.creator_collaborations (id, user_id, brand_name, deliverable_type)
values ('col11111-1111-4111-8111-111111111111', '11111111-1111-4111-8111-111111111111', 'Nike', 'instagram_reel');
select pg_temp.assert_true((select count(*) = 1 from public.creator_collaborations where user_id = '11111111-1111-4111-8111-111111111111'), 'creator can insert past collaboration');

-- 4. Cross-user isolation checks (User B tries to mutate User A's data)
select set_config('request.jwt.claim.sub','22222222-2222-4222-8222-222222222222',true);

-- User B cannot update User A's rate item
with changed as (update public.creator_rate_items set price_amount = 0 where id = 'r1111111-1111-4111-8111-111111111111' returning id)
 select pg_temp.assert_true((select count(*) = 0 from changed), 'User B cannot update User A rate item');

-- User B cannot delete User A's social account
with changed as (delete from public.creator_social_accounts where id = 's1111111-1111-4111-8111-111111111111' returning id)
 select pg_temp.assert_true((select count(*) = 0 from changed), 'User B cannot delete User A social account');

-- User B cannot tamper with field_verifications
select pg_temp.denied($s$insert into public.field_verifications(user_id, subject, status) values ('22222222-2222-4222-8222-222222222222', 'identity', 'verified')$s$, 'ordinary user cannot self-verify fields');

-- User B cannot directly insert creator_manager relationship as creator
select pg_temp.denied($s$insert into public.creator_manager_relationships (creator_id, manager_id, status) values ('11111111-1111-4111-8111-111111111111', '22222222-2222-4222-8222-222222222222', 'accepted')$s$, 'unauthorized manager relationship rejected');

reset role;
rollback;
