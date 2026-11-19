-- Phase 03 / SQL Security & Authorization Tests: Creator Contact & Private Quotation Outreach
-- supabase/tests/phase5_contact_security.sql

begin;
select plan(12);

-- 1. Test tables exist
select has_table('public', 'creator_contact_requests', 'creator_contact_requests table exists');
select has_table('public', 'creator_contact_preferences', 'creator_contact_preferences table exists');
select has_table('public', 'creator_quotations', 'creator_quotations table exists');
select has_table('public', 'outreach_conversations', 'outreach_conversations table exists');
select has_table('public', 'outreach_messages', 'outreach_messages table exists');
select has_table('public', 'user_blocks', 'user_blocks table exists');
select has_table('public', 'contact_safety_reports', 'contact_safety_reports table exists');

-- 2. Test RLS is enabled
select tests.rls_enabled('public', 'creator_contact_requests');
select tests.rls_enabled('public', 'creator_quotations');
select tests.rls_enabled('public', 'outreach_conversations');
select tests.rls_enabled('public', 'outreach_messages');
select tests.rls_enabled('public', 'creator_contact_preferences');

select * from finish();
rollback;
