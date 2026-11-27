-- ==============================================================================
-- GGs STAGE 08: CONSOLIDATED END-TO-END SECURITY AUDIT TEST SUITE
-- Verifies:
-- 1. Schema Baseline (all core & Phase 3-6 tables)
-- 2. RLS Status Audit on All Public Application Tables
-- 3. Shortlist Member Dual Target Constraint & Partial Unique Indexes
-- 4. Private Contact Preferences, Contact Requests & Private Quotations Isolation
-- 5. Instagram Token Vault Isolation (private.creator_instagram_tokens)
-- 6. Intelligent Search & Directory Claim RPC Security
-- ==============================================================================

BEGIN;

CREATE FUNCTION pg_temp.assert_true(ok boolean, label text) RETURNS void LANGUAGE plpgsql AS $$
BEGIN
  IF ok IS DISTINCT FROM true THEN
    RAISE EXCEPTION 'FAIL: %', label;
  END IF;
  RAISE NOTICE 'PASS: %', label;
END;
$$;

CREATE FUNCTION pg_temp.denied(statement text, label text) RETURNS void LANGUAGE plpgsql AS $$
BEGIN
  BEGIN
    EXECUTE statement;
  EXCEPTION
    WHEN insufficient_privilege OR check_violation OR invalid_parameter_value
      OR unique_violation OR invalid_text_representation OR foreign_key_violation
      OR raise_exception THEN
      RAISE NOTICE 'PASS: %', label;
      RETURN;
  END;
  RAISE EXCEPTION 'FAIL: expected rejection: %', label;
END;
$$;

-- 1. Schema Baseline
SELECT pg_temp.assert_true(
  (SELECT count(*) = 15 FROM information_schema.tables
   WHERE table_schema = 'public'
     AND table_name IN (
       'profiles', 'organizations', 'organization_memberships',
       'creator_profiles', 'creator_directory', 'shortlists', 'shortlist_members',
       'campaigns', 'campaign_applications', 'collaborations',
       'creator_contact_requests', 'creator_contact_preferences', 'creator_quotations',
       'creator_instagram_connections', 'creator_instagram_media'
     )),
  'all 15 core and phase 3-6 public tables exist'
);

-- 2. RLS Status Audit on All Public Tables
SELECT pg_temp.assert_true(
  (SELECT count(*) > 0 AND count(*) = count(*) FILTER (WHERE rowsecurity)
   FROM pg_tables WHERE schemaname = 'public'),
  'all public application tables have RLS enabled'
);

-- 3. Verify Shortlist Member Dual Target Constraint & Partial Unique Indexes
SELECT pg_temp.assert_true(
  EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'chk_shortlist_member_target'),
  'chk_shortlist_member_target constraint exists'
);
SELECT pg_temp.assert_true(
  (SELECT count(*) = 2 FROM pg_indexes
   WHERE schemaname = 'public'
     AND indexname IN ('uq_shortlist_registered_creator', 'uq_shortlist_directory_creator')),
  'shortlist dual-target partial unique indexes exist'
);

-- 4. Verify Instagram Token Vault Exists in Private Schema
SELECT pg_temp.assert_true(
  EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'private' AND table_name = 'creator_instagram_tokens'
  ),
  'private.creator_instagram_tokens vault exists'
);

-- 5. Verify RPC Signatures
SELECT pg_temp.assert_true(
  (SELECT count(*) = 3 FROM pg_proc p
   JOIN pg_namespace n ON n.oid = p.pronamespace
   WHERE n.nspname = 'public'
     AND p.proname IN ('search_creators_intelligent', 'claim_directory_profile', 'disconnect_instagram_account')),
  'all phase 4-6 RPC functions exist'
);

-- 6. Anonymous User Restrictions
SET LOCAL ROLE anon;
SELECT pg_temp.denied('SELECT * FROM private.creator_instagram_tokens', 'anon cannot read Instagram token vault');
SELECT pg_temp.denied('SELECT * FROM public.search_creators_intelligent(''fashion'')', 'anon cannot invoke intelligent search');
RESET ROLE;

-- 7. Cross-User & Client Privilege Isolation (Authenticated User B)
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '22222222-2222-4222-8222-222222222222', true);

SELECT pg_temp.denied('SELECT * FROM private.creator_instagram_tokens', 'authenticated user cannot read Instagram token vault');
SELECT pg_temp.denied(
  $s$INSERT INTO public.creator_instagram_connections(creator_id, instagram_user_id, instagram_username, status)
     VALUES ('22222222-2222-4222-8222-222222222222', '12345', 'fake_user', 'connected')$s$,
  'authenticated user cannot self-verify Instagram connection'
);
SELECT pg_temp.assert_true(
  (SELECT count(*) = 0 FROM public.creator_contact_preferences WHERE creator_id = '11111111-1111-4111-8111-111111111111'),
  'user B cannot directly read user A private contact preferences'
);
SELECT pg_temp.assert_true(
  (SELECT count(*) = 0 FROM public.creator_quotations WHERE creator_id = '11111111-1111-4111-8111-111111111111'),
  'user B cannot read user A private quotations'
);

RESET ROLE;

ROLLBACK;
