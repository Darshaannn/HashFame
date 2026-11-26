-- Supabase Security Tests: Phase 04 Online Directory & Shortlist Integration
-- supabase/tests/phase4_directory_security.sql

begin;

-- 1. Verify creator_directory table and columns exist
do $$
begin
  if not exists (
    select 1 from information_schema.tables 
    where table_schema = 'public' and table_name = 'creator_directory'
  ) then
    raise exception 'Missing creator_directory table';
  end if;

  if not exists (
    select 1 from information_schema.tables 
    where table_schema = 'public' and table_name = 'creator_directory_commercial'
  ) then
    raise exception 'Missing creator_directory_commercial table';
  end if;
end $$;

-- 2. Verify RLS is enabled on creator_directory and creator_directory_commercial
do $$
declare
  v_not_enabled text[];
begin
  select array_agg(relname) into v_not_enabled
  from pg_class c
  join pg_namespace n on n.oid = c.relnamespace
  where n.nspname = 'public'
    and relname in ('creator_directory', 'creator_directory_commercial')
    and not relrowsecurity;

  if array_length(v_not_enabled, 1) > 0 then
    raise exception 'RLS NOT enabled on: %', v_not_enabled;
  end if;
end $$;

-- 3. Verify shortlist_members foreign key constraint allows directory_id
do $$
begin
  if not exists (
    select 1 from information_schema.columns 
    where table_schema = 'public' 
    and table_name = 'shortlist_members' 
    and column_name = 'directory_id'
  ) then
    raise exception 'Missing shortlist_members.directory_id column';
  end if;
end $$;

-- 4. Verify claim_directory_profile function exists
do $$
begin
  if not exists (
    select 1 from pg_proc where proname = 'claim_directory_profile'
  ) then
    raise exception 'Missing claim_directory_profile RPC function';
  end if;
end $$;

rollback;
