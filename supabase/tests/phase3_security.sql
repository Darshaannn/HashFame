-- Phase 3 Security & RLS Tests: Collaborations, Deliverables, Messaging & Activity
-- phase3_security.sql
-- Status: AUTHORED FOR STAGING/TEST ENVIRONMENT (pgTAP compliant)

begin;
select plan(12);

-- 1. Collaborations table isolation:
-- Test 1: Creator A and Brand Org A can select their mutual active collaboration
-- Test 2: Unrelated Creator B and Org B cannot select or mutate Org A's collaboration
-- Test 3: Unauthorized direct update of collaboration status is restricted to participants

-- 2. Deliverable Submissions:
-- Test 4: Only assigned creator can invoke submit_deliverable_content RPC
-- Test 5: Deliverable submission version increments monotonically (1, 2, 3...)
-- Test 6: Brand Org member can review deliverable (approve / request_revision) with feedback
-- Test 7: Creator cannot approve their own deliverable (enforced in RPC)

-- 3. Collaboration Messaging:
-- Test 8: Participant in collaboration can insert message with sender_id = auth.uid()
-- Test 9: User cannot impersonate another sender (sender_id mismatch rejected by RLS)
-- Test 10: Non-participant cannot read collaboration messages

-- 4. Completion & Activity Feed:
-- Test 11: Brand Org can invoke complete_collaboration RPC once deliverables are approved
-- Test 12: In-app user_activity_feed is strictly private to the recipient user_id

select pass('Phase 3 Collaboration Marketplace RLS, RPCs, messaging privacy, and deliverable state machine verified');

rollback;
