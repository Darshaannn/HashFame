-- Phase 4: Staging Realtime Publication & Replica Identity
-- 0014_phase4_staging_realtime.sql

-- Enable full replica identity for Realtime subscription change payloads
alter table public.collaborations replica identity full;
alter table public.deliverable_submissions replica identity full;
alter table public.collaboration_messages replica identity full;
alter table public.user_activity_feed replica identity full;

-- Add collaboration tables to supabase_realtime publication if it exists
do $$
begin
  if exists (select 1 from pg_publication where pubname = 'supabase_realtime') then
    alter publication supabase_realtime add table public.collaborations, public.deliverable_submissions, public.collaboration_messages, public.user_activity_feed;
  end if;
end $$;
