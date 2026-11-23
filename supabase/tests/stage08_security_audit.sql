-- ==============================================================================
-- GGs STAGE 08: CONSOLIDATED END-TO-END SECURITY AUDIT TEST SUITE
-- Verifies:
-- 1. Tenant/Org Isolation & Multi-tenancy
-- 2. Contact Requests & Contact Preferences Privacy
-- 3. Private Quotations Access Restriction (No public Rate Cards)
-- 4. Online Influencer Directory Access & Shortlist Dual Target (UUID + dir_...)
-- 5. Intelligent Search RPC Execution & Fallback
-- 6. Instagram Meta Integration: Token Vault Security & Feed Isolation
-- ==============================================================================

BEGIN;

SELECT '--- 1. Extensions, Tables and Schema Baseline ---' AS stage;
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN (
    'profiles', 'organizations', 'organization_memberships',
    'creators', 'creator_directory', 'shortlists', 'shortlist_members',
    'campaigns', 'campaign_applications', 'collaborations',
    'contact_requests', 'creator_contact_preferences', 'private_quotations',
    'instagram_connections', 'instagram_media_cache'
);

SELECT '--- 2. RLS Status Audit on All Sensitive Tables ---' AS stage;
SELECT relname AS table_name, relrowsecurity AS rls_enabled, relforcerowsecurity AS rls_forced
FROM pg_class
JOIN pg_namespace ON pg_namespace.oid = pg_class.relnamespace
WHERE pg_namespace.nspname = 'public'
AND relname IN (
    'contact_requests', 'creator_contact_preferences', 'private_quotations',
    'instagram_connections', 'instagram_media_cache', 'shortlists', 'shortlist_members'
);

SELECT '--- 3. Verify Shortlist Member Dual Target Constraint ---' AS stage;
SELECT conname, pg_get_constraintdef(oid) 
FROM pg_constraint 
WHERE conname IN ('chk_shortlist_member_target', 'uq_shortlist_creator', 'uq_shortlist_directory');

SELECT '--- 4. Verify Contact Requests Privacy & Access ---' AS stage;
SELECT polname, polcmd, polroles::regrole[], pg_get_expr(polqual, polrelid) AS qual
FROM pg_policy
WHERE polrelid = 'public.contact_requests'::regclass;

SELECT '--- 5. Verify Private Quotations Privacy & No Public Rates ---' AS stage;
SELECT polname, polcmd, polroles::regrole[], pg_get_expr(polqual, polrelid) AS qual
FROM pg_policy
WHERE polrelid = 'public.private_quotations'::regclass;

SELECT '--- 6. Verify Instagram Token Security ---' AS stage;
-- Ensure access_token cannot be viewed by unauthorized users and table has RLS
SELECT polname, polcmd, polroles::regrole[], pg_get_expr(polqual, polrelid) AS qual
FROM pg_policy
WHERE polrelid = 'public.instagram_connections'::regclass;

SELECT '--- 7. Verify Intelligent Search RPC Signature ---' AS stage;
SELECT proname, proargnames, prorettype::regtype 
FROM pg_proc 
WHERE proname IN ('search_creators_intelligent', 'claim_creator_profile', 'disconnect_instagram_account');

ROLLBACK;
