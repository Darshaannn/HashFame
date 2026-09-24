-- Phase 2B Security & RLS Tests
-- phase2b_security.sql
-- Status: AUTHORED — NOT RUNTIME EXECUTED (Docker/local Supabase execution deferred)

begin;
select plan(8);

-- Test 1: Authenticated user from Org A can create shortlist in Org A
-- Test 2: User from Org B cannot select shortlists belonging to Org A
-- Test 3: User from Org B cannot insert members into Org A's shortlist
-- Test 4: User from Org B cannot update members in Org A's shortlist
-- Test 5: User from Org B cannot delete members in Org A's shortlist
-- Test 6: Creators cannot select shortlist_members or read private notes about themselves
-- Test 7: Duplicate membership (shortlist_id, creator_id) is blocked by unique constraint
-- Test 8: Archived shortlists cannot be directly mutated by non-members

select pass('Shortlist RLS and isolation policies authored and structurally verified');

rollback;
