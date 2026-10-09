-- Phase 3: Active Marketplace Collaborations, Messaging, Deliverables & Activity Feed
-- 0013_phase3_collaboration_marketplace.sql

-- 1. Enums
create type public.collaboration_status as enum (
  'active',
  'submitted',
  'revision_requested',
  'approved',
  'completed',
  'cancelled'
);

create type public.deliverable_submission_status as enum (
  'pending',
  'submitted',
  'revision_requested',
  'approved'
);

-- 2. Collaborations Table (Active Workspace)
create table public.collaborations (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations(id) on delete cascade,
  campaign_id uuid not null references public.campaigns(id) on delete cascade,
  application_id uuid not null unique references public.campaign_applications(id) on delete cascade,
  creator_id uuid not null references public.profiles(id) on delete cascade,
  status public.collaboration_status not null default 'active',
  compensation_amount numeric(12, 2) check (compensation_amount is null or compensation_amount >= 0),
  currency text not null default 'INR' check (char_length(currency) between 3 and 5),
  usage_rights jsonb not null default '{}'::jsonb,
  deliverable_requirements jsonb not null default '[]'::jsonb,
  due_date timestamptz,
  completed_at timestamptz,
  cancelled_at timestamptz,
  cancellation_reason text check (cancellation_reason is null or char_length(btrim(cancellation_reason)) <= 500),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index collaborations_org on public.collaborations(organization_id);
create index collaborations_creator on public.collaborations(creator_id);
create index collaborations_campaign on public.collaborations(campaign_id);
create index collaborations_status on public.collaborations(status);
create trigger collaborations_updated before update on public.collaborations for each row execute function private.touch_updated_at();

-- 3. Collaboration Status History (Audit Trail)
create table public.collaboration_status_history (
  id uuid primary key default gen_random_uuid(),
  collaboration_id uuid not null references public.collaborations(id) on delete cascade,
  from_status public.collaboration_status,
  to_status public.collaboration_status not null,
  changed_by uuid not null references public.profiles(id) on delete set null,
  reason text check (reason is null or char_length(btrim(reason)) <= 500),
  created_at timestamptz not null default now()
);

create index collab_status_history_collab on public.collaboration_status_history(collaboration_id, created_at desc);

-- 4. Deliverable Submissions Table
create table public.deliverable_submissions (
  id uuid primary key default gen_random_uuid(),
  collaboration_id uuid not null references public.collaborations(id) on delete cascade,
  deliverable_title text not null check (char_length(btrim(deliverable_title)) between 2 and 150),
  content_link text not null check (char_length(btrim(content_link)) between 5 and 1000),
  creator_notes text check (creator_notes is null or char_length(btrim(creator_notes)) <= 2000),
  status public.deliverable_submission_status not null default 'submitted',
  feedback text check (feedback is null or char_length(btrim(feedback)) <= 2000),
  submitted_at timestamptz not null default now(),
  reviewed_at timestamptz,
  reviewed_by uuid references public.profiles(id) on delete set null,
  version int not null default 1 check (version >= 1),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index deliverable_subs_collab on public.deliverable_submissions(collaboration_id);
create index deliverable_subs_status on public.deliverable_submissions(status);
create trigger deliverable_subs_updated before update on public.deliverable_submissions for each row execute function private.touch_updated_at();

-- 5. Collaboration Messages Table (Direct Brand <-> Creator messaging)
create table public.collaboration_messages (
  id uuid primary key default gen_random_uuid(),
  collaboration_id uuid not null references public.collaborations(id) on delete cascade,
  sender_id uuid not null references public.profiles(id) on delete cascade,
  content text not null check (char_length(btrim(content)) between 1 and 4000),
  read_at timestamptz,
  created_at timestamptz not null default now()
);

create index collab_messages_collab on public.collaboration_messages(collaboration_id, created_at asc);
create index collab_messages_unread on public.collaboration_messages(collaboration_id) where read_at is null;

-- 6. User In-App Activity Feed Table
create table public.user_activity_feed (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  collaboration_id uuid references public.collaborations(id) on delete cascade,
  title text not null check (char_length(btrim(title)) between 2 and 150),
  subtitle text not null check (char_length(btrim(subtitle)) between 2 and 500),
  activity_type text not null check (char_length(activity_type) between 2 and 50),
  route text check (route is null or char_length(btrim(route)) <= 200),
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

create index user_activity_user on public.user_activity_feed(user_id, created_at desc);

-- 7. Row Level Security Policies

alter table public.collaborations enable row level security;
alter table public.collaboration_status_history enable row level security;
alter table public.deliverable_submissions enable row level security;
alter table public.collaboration_messages enable row level security;
alter table public.user_activity_feed enable row level security;

-- Helper function: is actor an authorized collaboration participant?
create or replace function private.is_collaboration_participant(p_collab_id uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.collaborations c
    where c.id = p_collab_id
      and (
        c.creator_id = (select auth.uid())
        or private.is_member(c.organization_id)
        or private.is_admin()
      )
  );
$$;

-- Collaborations Policies
create policy collaborations_read on public.collaborations for select to authenticated
  using (
    creator_id = (select auth.uid())
    or private.is_member(organization_id)
    or private.is_admin()
  );

create policy collaborations_update on public.collaborations for update to authenticated
  using (
    creator_id = (select auth.uid())
    or private.is_member(organization_id)
    or private.is_admin()
  )
  with check (
    creator_id = (select auth.uid())
    or private.is_member(organization_id)
    or private.is_admin()
  );

-- Collaboration Status History Policies
create policy collab_history_read on public.collaboration_status_history for select to authenticated
  using (private.is_collaboration_participant(collaboration_id));

-- Deliverable Submissions Policies
create policy deliverable_subs_read on public.deliverable_submissions for select to authenticated
  using (private.is_collaboration_participant(collaboration_id));

create policy deliverable_subs_insert on public.deliverable_submissions for insert to authenticated
  with check (
    private.is_collaboration_participant(collaboration_id)
    and exists (
      select 1 from public.collaborations c
      where c.id = collaboration_id
        and c.creator_id = (select auth.uid())
    )
  );

create policy deliverable_subs_update on public.deliverable_submissions for update to authenticated
  using (private.is_collaboration_participant(collaboration_id))
  with check (private.is_collaboration_participant(collaboration_id));

-- Collaboration Messages Policies
create policy collab_messages_read on public.collaboration_messages for select to authenticated
  using (private.is_collaboration_participant(collaboration_id));

create policy collab_messages_insert on public.collaboration_messages for insert to authenticated
  with check (
    private.is_collaboration_participant(collaboration_id)
    and sender_id = (select auth.uid())
  );

create policy collab_messages_update on public.collaboration_messages for update to authenticated
  using (private.is_collaboration_participant(collaboration_id))
  with check (private.is_collaboration_participant(collaboration_id));

-- Activity Feed Policies
create policy activity_feed_read on public.user_activity_feed for select to authenticated
  using (user_id = (select auth.uid()) or private.is_admin());

create policy activity_feed_update on public.user_activity_feed for update to authenticated
  using (user_id = (select auth.uid()) or private.is_admin())
  with check (user_id = (select auth.uid()) or private.is_admin());

-- 8. Enhanced RPC State Transitions & Collaboration Creation

-- Fix transition_campaign_application_status to automatically create Collaboration when application is selected
create or replace function public.transition_campaign_application_status(
  p_application_id uuid,
  p_new_status public.campaign_application_status,
  p_reason text default null
)
returns public.campaign_applications
language plpgsql security definer set search_path = '' as $$
declare
  v_app public.campaign_applications;
  v_campaign public.campaigns;
  v_actor uuid := auth.uid();
  v_current_selected_count int;
  v_collab_id uuid;
  v_from_status public.campaign_application_status;
begin
  if v_actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
  
  select * into v_app from public.campaign_applications where id = p_application_id for update;
  if not found then raise exception 'Application not found' using errcode = 'P0002'; end if;
  
  select * into v_campaign from public.campaigns where id = v_app.campaign_id;
  if not (private.is_member(v_campaign.organization_id) or private.is_admin()) then
    raise exception 'Unauthorized' using errcode = '42501';
  end if;
  
  v_from_status := v_app.status;
  
  -- Prevent selecting beyond creator slots capacity
  if p_new_status = 'selected' and v_from_status <> 'selected' then
    select count(*) into v_current_selected_count
    from public.campaign_applications
    where campaign_id = v_campaign.id and status = 'selected';
    
    if v_current_selected_count >= v_campaign.creator_slots then
      raise exception 'Campaign creator slot capacity (% slots) reached', v_campaign.creator_slots using errcode = '22023';
    end if;
  end if;
  
  -- Update application
  update public.campaign_applications
  set status = p_new_status,
      reviewed_at = case when p_new_status in ('under_review', 'shortlisted', 'selected', 'rejected') and reviewed_at is null then now() else reviewed_at end,
      updated_at = now()
  where id = p_application_id
  returning * into v_app;
  
  -- Record status history audit
  insert into public.campaign_application_status_history(application_id, from_status, to_status, changed_by, reason)
  values (p_application_id, v_from_status, p_new_status, v_actor, p_reason);
  
  -- Idempotently create collaboration if selected
  if p_new_status = 'selected' then
    insert into public.collaborations (
      organization_id,
      campaign_id,
      application_id,
      creator_id,
      status,
      compensation_amount,
      currency,
      due_date
    )
    values (
      v_campaign.organization_id,
      v_campaign.id,
      p_application_id,
      v_app.creator_id,
      'active',
      coalesce(v_app.proposed_rate, v_campaign.budget_min),
      v_app.currency,
      v_campaign.content_deadline
    )
    on conflict (application_id) do nothing
    returning id into v_collab_id;
    
    if v_collab_id is not null then
      insert into public.collaboration_status_history (
        collaboration_id,
        from_status,
        to_status,
        changed_by,
        reason
      )
      values (
        v_collab_id,
        null,
        'active',
        v_actor,
        'Collaboration initiated upon campaign selection'
      );
      
      -- Send in-app activity notification to creator
      insert into public.user_activity_feed (
        user_id,
        collaboration_id,
        title,
        subtitle,
        activity_type,
        route
      )
      values (
        v_app.creator_id,
        v_collab_id,
        'Application Selected 🎉',
        format('You were selected for "%s"! Tap to open your active collaboration.', v_campaign.title),
        'application_selected',
        format('/collaborations/%s', v_collab_id)
      );
    end if;
  end if;
  
  return v_app;
end;
$$;

-- Submit Deliverable RPC
create or replace function public.submit_deliverable_content(
  p_collaboration_id uuid,
  p_deliverable_title text,
  p_content_link text,
  p_creator_notes text default null
)
returns public.deliverable_submissions
language plpgsql security definer set search_path = '' as $$
declare
  v_collab public.collaborations;
  v_campaign public.campaigns;
  v_actor uuid := auth.uid();
  v_version int := 1;
  v_submission public.deliverable_submissions;
begin
  if v_actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
  
  select * into v_collab from public.collaborations where id = p_collaboration_id for update;
  if not found then raise exception 'Collaboration not found' using errcode = 'P0002'; end if;
  
  if v_collab.creator_id <> v_actor then
    raise exception 'Only the assigned creator can submit deliverables' using errcode = '42501';
  end if;
  
  if v_collab.status in ('completed', 'cancelled') then
    raise exception 'Cannot submit deliverable for completed or cancelled collaboration' using errcode = '22023';
  end if;
  
  select coalesce(max(version), 0) + 1 into v_version
  from public.deliverable_submissions
  where collaboration_id = p_collaboration_id and deliverable_title = p_deliverable_title;
  
  insert into public.deliverable_submissions (
    collaboration_id,
    deliverable_title,
    content_link,
    creator_notes,
    status,
    version,
    submitted_at
  )
  values (
    p_collaboration_id,
    p_deliverable_title,
    p_content_link,
    p_creator_notes,
    'submitted',
    v_version,
    now()
  )
  returning * into v_submission;
  
  -- Update collaboration status to submitted
  update public.collaborations
  set status = 'submitted', updated_at = now()
  where id = p_collaboration_id;
  
  insert into public.collaboration_status_history (
    collaboration_id,
    from_status,
    to_status,
    changed_by,
    reason
  )
  values (
    p_collaboration_id,
    v_collab.status,
    'submitted',
    v_actor,
    format('Deliverable "%s" v%s submitted', p_deliverable_title, v_version)
  );
  
  return v_submission;
end;
$$;

-- Review Deliverable RPC (Brand / Agency Organization Workflow)
create or replace function public.review_deliverable_submission(
  p_submission_id uuid,
  p_action text, -- 'approve' or 'request_revision'
  p_feedback text default null
)
returns public.deliverable_submissions
language plpgsql security definer set search_path = '' as $$
declare
  v_submission public.deliverable_submissions;
  v_collab public.collaborations;
  v_campaign public.campaigns;
  v_actor uuid := auth.uid();
  v_new_sub_status public.deliverable_submission_status;
  v_new_collab_status public.collaboration_status;
begin
  if v_actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
  
  select * into v_submission from public.deliverable_submissions where id = p_submission_id for update;
  if not found then raise exception 'Deliverable submission not found' using errcode = 'P0002'; end if;
  
  select * into v_collab from public.collaborations where id = v_submission.collaboration_id for update;
  if not found then raise exception 'Collaboration not found' using errcode = 'P0002'; end if;
  
  if not (private.is_member(v_collab.organization_id) or private.is_admin()) then
    raise exception 'Unauthorized to review deliverable' using errcode = '42501';
  end if;
  
  if p_action = 'approve' then
    v_new_sub_status := 'approved';
    v_new_collab_status := 'approved';
  elsif p_action = 'request_revision' then
    v_new_sub_status := 'revision_requested';
    v_new_collab_status := 'revision_requested';
  else
    raise exception 'Invalid review action: %', p_action using errcode = '22023';
  end if;
  
  update public.deliverable_submissions
  set status = v_new_sub_status,
      feedback = p_feedback,
      reviewed_at = now(),
      reviewed_by = v_actor,
      updated_at = now()
  where id = p_submission_id
  returning * into v_submission;
  
  update public.collaborations
  set status = v_new_collab_status,
      updated_at = now()
  where id = v_collab.id;
  
  insert into public.collaboration_status_history (
    collaboration_id,
    from_status,
    to_status,
    changed_by,
    reason
  )
  values (
    v_collab.id,
    v_collab.status,
    v_new_collab_status,
    v_actor,
    coalesce(p_feedback, format('Deliverable marked as %s', v_new_sub_status))
  );
  
  -- Notify creator in activity feed
  insert into public.user_activity_feed (
    user_id,
    collaboration_id,
    title,
    subtitle,
    activity_type,
    route
  )
  values (
    v_collab.creator_id,
    v_collab.id,
    case when p_action = 'approve' then 'Deliverable Approved ✨' else 'Revision Requested ✍️' end,
    case when p_action = 'approve' then 'Your submitted deliverable was approved!' else format('Feedback: %s', coalesce(p_feedback, 'Please check revisions.')) end,
    case when p_action = 'approve' then 'deliverable_approved' else 'revision_requested' end,
    format('/collaborations/%s', v_collab.id)
  );
  
  return v_submission;
end;
$$;

-- Complete Collaboration RPC
create or replace function public.complete_collaboration(
  p_collaboration_id uuid,
  p_notes text default null
)
returns public.collaborations
language plpgsql security definer set search_path = '' as $$
declare
  v_collab public.collaborations;
  v_actor uuid := auth.uid();
begin
  if v_actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
  
  select * into v_collab from public.collaborations where id = p_collaboration_id for update;
  if not found then raise exception 'Collaboration not found' using errcode = 'P0002'; end if;
  
  if not (private.is_member(v_collab.organization_id) or private.is_admin()) then
    raise exception 'Unauthorized to complete collaboration' using errcode = '42501';
  end if;
  
  update public.collaborations
  set status = 'completed',
      completed_at = now(),
      updated_at = now()
  where id = p_collaboration_id
  returning * into v_collab;
  
  insert into public.collaboration_status_history (
    collaboration_id,
    from_status,
    to_status,
    changed_by,
    reason
  )
  values (
    p_collaboration_id,
    v_collab.status,
    'completed',
    v_actor,
    coalesce(p_notes, 'Collaboration successfully completed')
  );
  
  insert into public.user_activity_feed (
    user_id,
    collaboration_id,
    title,
    subtitle,
    activity_type,
    route
  )
  values (
    v_collab.creator_id,
    v_collab.id,
    'Collaboration Completed 🏆',
    'All deliverables approved and collaboration marked completed. Excellent work!',
    'collaboration_completed',
    format('/collaborations/%s', v_collab.id)
  );
  
  return v_collab;
end;
$$;

-- Grants
grant select, update on public.collaborations to authenticated;
grant select on public.collaboration_status_history to authenticated;
grant select, insert, update on public.deliverable_submissions to authenticated;
grant select, insert, update on public.collaboration_messages to authenticated;
grant select, update on public.user_activity_feed to authenticated;
grant execute on function public.submit_deliverable_content(uuid, text, text, text), public.review_deliverable_submission(uuid, text, text), public.complete_collaboration(uuid, text) to authenticated;
