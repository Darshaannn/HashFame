-- Supabase Security Tests: Phase 03 Creator Contact & Outreach RLS & Privacy
-- supabase/tests/phase5_contact_security.sql

begin;

-- Verify all Phase 03 tables exist
do $$
declare
  v_missing text[];
begin
  select array_agg(tbl) into v_missing
  from (
    select unnest(array[
      'creator_contact_preferences',
      'creator_contact_requests',
      'creator_quotations',
      'outreach_conversations',
      'outreach_messages',
      'user_blocks',
      'contact_safety_reports'
    ]) as tbl
  ) required
  where not exists (
    select 1 from information_schema.tables 
    where table_schema = 'public' and table_name = tbl
  );

  if array_length(v_missing, 1) > 0 then
    raise exception 'Missing Phase 3 tables: %', v_missing;
  end if;
end $$;

-- Verify RLS is enabled on all 7 tables
do $$
declare
  v_not_enabled text[];
begin
  select array_agg(relname) into v_not_enabled
  from pg_class c
  join pg_namespace n on n.oid = c.relnamespace
  where n.nspname = 'public'
    and relname in (
      'creator_contact_preferences',
      'creator_contact_requests',
      'creator_quotations',
      'outreach_conversations',
      'outreach_messages',
      'user_blocks',
      'contact_safety_reports'
    )
    and not relrowsecurity;

  if array_length(v_not_enabled, 1) > 0 then
    raise exception 'RLS NOT enabled on: %', v_not_enabled;
  end if;
end $$;

-- Verify secure RPC functions exist
do $$
begin
  if not exists (
    select 1 from pg_proc where proname = 'accept_contact_request'
  ) then
    raise exception 'Missing RPC accept_contact_request';
  end if;

  if not exists (
    select 1 from pg_proc where proname = 'decline_contact_request'
  ) then
    raise exception 'Missing RPC decline_contact_request';
  end if;

  if not exists (
    select 1 from pg_proc where proname = 'cancel_contact_request'
  ) then
    raise exception 'Missing RPC cancel_contact_request';
  end if;

  if not exists (
    select 1 from pg_proc where proname = 'get_creator_contact_options'
  ) then
    raise exception 'Missing RPC get_creator_contact_options';
  end if;
end $$;

-- Verify unique constraints on requests and quotations
do $$
begin
  if not exists (
    select 1 from pg_indexes 
    where tablename = 'creator_contact_requests' 
    and indexname = 'uq_pending_creator_request'
  ) then
    raise exception 'Missing unique index uq_pending_creator_request';
  end if;

  if not exists (
    select 1 from pg_constraint
    where conrelid = 'public.creator_quotations'::regclass
    and conname = 'uq_request_quotation'
  ) then
    raise exception 'Missing unique constraint on creator_quotations(request_id)';
  end if;
end $$;

rollback;
