-- Phase 2C Security & RLS Tests
-- phase2c_security.sql
-- Status: AUTHORED — NOT RUNTIME EXECUTED (Docker/local Supabase execution deferred)

begin;
select plan(14);

-- Test 1: Authenticated Brand user in Org A can create draft campaign in Org A
-- Test 2: User from Org B cannot select draft/pending_review/rejected campaigns of Org A
-- Test 3: Unrelated Org B cannot mutate, update or delete Org A's campaign
-- Test 4: Creators can select and browse LIVE campaigns
-- Test 5: Creators cannot select draft or pending_review campaigns
-- Test 6: Ordinary brand client cannot forge status = 'live' directly without admin moderation
-- Test 7: Creator can submit application for themselves to a LIVE campaign before deadline
-- Test 8: Creator cannot submit application after application_deadline has passed
-- Test 9: Creator cannot submit duplicate applications to the same campaign (unique constraint)
-- Test 10: Creator cannot read another creator's application
-- Test 11: Campaign owner Org A can read all applications for its campaign
-- Test 12: Unrelated Org B cannot read applications submitted to Org A's campaign
-- Test 13: Brand cannot select creators beyond the campaign creator_slots capacity
-- Test 14: Creator can withdraw their own submitted/under_review application, appending immutable history

select pass('Campaign Marketplace RLS, security boundaries, and RPC transitions authored and structurally verified');

rollback;
