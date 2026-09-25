-- Phase 2C: Campaign Marketplace, Creator Opportunities, and Applications
-- 0012_phase2c_campaign_marketplace.sql

-- 1. Enums
create type public.campaign_status as enum (
  'draft',
  'pending_review',
  'live',
  'paused',
  'closed',
  'cancelled',
  'rejected'
);

create type public.campaign_compensation_type as enum (
  'paid',
  'barter',
  'paid_and_barter'
);

create type public.campaign_deliverable_type as enum (
  'instagram_reel',
  'instagram_story',
  'instagram_post',
  'youtube_video',
  'youtube_integration',
  'youtube_short',
  'ugc_video',
  'other'
);

create type public.campaign_application_status as enum (
  'submitted',
  'under_review',
  'shortlisted',
  'selected',
  'rejected',
  'withdrawn'
);

-- 2. Campaigns Table
create table public.campaigns (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations(id) on delete cascade,
  created_by uuid not null references public.profiles(id) on delete set null,
  title text not null check (char_length(btrim(title)) between 3 and 150),
  objective text check (objective is null or char_length(btrim(objective)) <= 500),
  description text not null check (char_length(btrim(description)) between 10 and 5000),
  status public.campaign_status not null default 'draft',
  
  -- Compensation
  compensation_type public.campaign_compensation_type not null default 'paid',
  currency text not null default 'INR' check (char_length(currency) between 3 and 5),
  budget_min numeric(12, 2) check (budget_min is null or budget_min >= 0),
  budget_max numeric(12, 2) check (budget_max is null or budget_max >= 0),
  barter_value numeric(12, 2) check (barter_value is null or barter_value >= 0),
  barter_description text check (barter_description is null or char_length(btrim(barter_description)) <= 1000),
  
  -- Creator Requirements
  creator_slots int not null default 1 check (creator_slots between 1 and 1000),
  target_city text check (target_city is null or char_length(target_city) <= 100),
  target_state text check (target_state is null or char_length(target_state) <= 100),
  target_country text not null default 'IN' check (char_length(target_country) = 2),
  min_followers int check (min_followers is null or min_followers >= 0),
  max_followers int check (max_followers is null or max_followers >= 0),
  
  -- Usage Rights
  organic_reposting_allowed boolean not null default true,
  paid_usage_required boolean not null default false,
  whitelisting_required boolean not null default false,
  usage_duration_months int check (usage_duration_months is null or usage_duration_months >= 0),
  usage_territory text not null default 'India' check (char_length(usage_territory) <= 100),
  exclusivity_required boolean not null default false,
  exclusivity_duration_days int check (exclusivity_duration_days is null or exclusivity_duration_days >= 0),
  content_approval_required boolean not null default true,
  disclosure_required boolean not null default true,
  
  -- Timeline
  application_deadline timestamptz check (application_deadline is null or application_deadline > created_at),
  content_deadline timestamptz check (content_deadline is null or content_deadline > application_deadline),
  campaign_start_date date,
  campaign_end_date date check (campaign_end_date is null or campaign_end_date >= campaign_start_date),
  
  additional_requirements text check (additional_requirements is null or char_length(btrim(additional_requirements)) <= 2000),
  rejection_reason text check (rejection_reason is null or char_length(btrim(rejection_reason)) <= 500),
  
  published_at timestamptz,
  closed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  
  -- Compensation Invariant Check
  constraint campaign_budget_valid check (
    budget_min is null or budget_max is null or budget_max >= budget_min
  ),
  constraint campaign_compensation_valid check (
    (compensation_type = 'paid' and budget_min is not null and budget_min >= 0) or
    (compensation_type = 'barter' and barter_description is not null and char_length(btrim(barter_description)) >= 3) or
    (compensation_type = 'paid_and_barter' and budget_min is not null and barter_description is not null)
  )
);

create index campaigns_org on public.campaigns(organization_id);
create index campaigns_status on public.campaigns(status);
create index campaigns_deadline on public.campaigns(application_deadline) where status = 'live';
create index campaigns_published on public.campaigns(published_at desc) where status = 'live';
create trigger campaigns_updated before update on public.campaigns for each row execute function private.touch_updated_at();

-- 3. Campaign Categories Join Table
create table public.campaign_categories (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.campaigns(id) on delete cascade,
  category_id text not null references public.categories(id) on delete cascade,
  is_primary boolean not null default false,
  constraint campaign_categories_unique unique (campaign_id, category_id)
);
create index campaign_categories_campaign on public.campaign_categories(campaign_id);
create index campaign_categories_category on public.campaign_categories(category_id);

-- 4. Campaign Languages Join Table
create table public.campaign_languages (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.campaigns(id) on delete cascade,
  language_code text not null references public.languages(code) on delete cascade,
  constraint campaign_languages_unique unique (campaign_id, language_code)
);
create index campaign_languages_campaign on public.campaign_languages(campaign_id);

-- 5. Campaign Deliverables Table
create table public.campaign_deliverables (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.campaigns(id) on delete cascade,
  deliverable_type public.campaign_deliverable_type not null,
  platform text not null check (char_length(platform) between 2 and 30),
  quantity int not null default 1 check (quantity between 1 and 50),
  description text check (description is null or char_length(btrim(description)) <= 500),
  created_at timestamptz not null default now()
);
create index campaign_deliverables_campaign on public.campaign_deliverables(campaign_id);

-- 6. Campaign Applications Table
create table public.campaign_applications (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.campaigns(id) on delete cascade,
  creator_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  status public.campaign_application_status not null default 'submitted',
  pitch text not null check (char_length(btrim(pitch)) between 10 and 2000),
  proposed_rate numeric(12, 2) check (proposed_rate is null or proposed_rate >= 0),
  currency text not null default 'INR' check (char_length(currency) between 3 and 5),
  reviewed_at timestamptz,
  withdrawn_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint campaign_applications_unique unique (campaign_id, creator_id)
);

create index campaign_applications_campaign on public.campaign_applications(campaign_id);
create index campaign_applications_creator on public.campaign_applications(creator_id);
create index campaign_applications_status on public.campaign_applications(campaign_id, status);
create trigger campaign_applications_updated before update on public.campaign_applications for each row execute function private.touch_updated_at();

-- 7. Application Status History (Immutable Audit Trail)
create table public.campaign_application_status_history (
  id uuid primary key default gen_random_uuid(),
  application_id uuid not null references public.campaign_applications(id) on delete cascade,
  from_status public.campaign_application_status,
  to_status public.campaign_application_status not null,
  changed_by uuid not null references public.profiles(id) on delete set null,
  reason text check (reason is null or char_length(btrim(reason)) <= 500),
  created_at timestamptz not null default now()
);
create index app_status_history_application on public.campaign_application_status_history(application_id, created_at desc);

-- 8. Row Level Security
alter table public.campaigns enable row level security;
alter table public.campaign_categories enable row level security;
alter table public.campaign_languages enable row level security;
alter table public.campaign_deliverables enable row level security;
alter table public.campaign_applications enable row level security;
alter table public.campaign_application_status_history enable row level security;

-- Campaigns Policies
-- Org members can read their own org's campaigns (all statuses)
create policy campaigns_org_read on public.campaigns for select to authenticated
  using (private.is_member(organization_id) or private.is_admin());

-- Authenticated creators/public can read LIVE campaigns whose application deadline hasn't passed (or live campaigns in general)
create policy campaigns_public_live_read on public.campaigns for select to authenticated
  using (status = 'live');

-- Org members can insert campaigns for their org in 'draft' status
create policy campaigns_org_insert on public.campaigns for insert to authenticated
  with check (
    private.is_member(organization_id)
    and created_by = (select auth.uid())
    and private.is_active()
    and status = 'draft'
  );

-- Org members can update campaigns in draft/pending_review/live status (cannot elevate to live directly if restricted)
create policy campaigns_org_update on public.campaigns for update to authenticated
  using (private.is_member(organization_id) or private.is_admin())
  with check (
    (private.is_member(organization_id) or private.is_admin())
    and (status <> 'live' or private.is_admin() or (select status from public.campaigns where id = campaigns.id) = 'live')
  );

-- Org members can delete draft campaigns
create policy campaigns_org_delete on public.campaigns for delete to authenticated
  using ((private.is_member(organization_id) or private.is_admin()) and status = 'draft');

-- Campaign Children (Categories, Languages, Deliverables) Policies
create policy campaign_categories_read on public.campaign_categories for select to authenticated
  using (
    exists (
      select 1 from public.campaigns c
      where c.id = campaign_categories.campaign_id
        and (c.status = 'live' or private.is_member(c.organization_id) or private.is_admin())
    )
  );

create policy campaign_categories_write on public.campaign_categories for all to authenticated
  using (
    exists (
      select 1 from public.campaigns c
      where c.id = campaign_categories.campaign_id
        and (private.is_member(c.organization_id) or private.is_admin())
        and c.status in ('draft', 'pending_review')
    )
  );

create policy campaign_languages_read on public.campaign_languages for select to authenticated
  using (
    exists (
      select 1 from public.campaigns c
      where c.id = campaign_languages.campaign_id
        and (c.status = 'live' or private.is_member(c.organization_id) or private.is_admin())
    )
  );

create policy campaign_languages_write on public.campaign_languages for all to authenticated
  using (
    exists (
      select 1 from public.campaigns c
      where c.id = campaign_languages.campaign_id
        and (private.is_member(c.organization_id) or private.is_admin())
        and c.status in ('draft', 'pending_review')
    )
  );

create policy campaign_deliverables_read on public.campaign_deliverables for select to authenticated
  using (
    exists (
      select 1 from public.campaigns c
      where c.id = campaign_deliverables.campaign_id
        and (c.status = 'live' or private.is_member(c.organization_id) or private.is_admin())
    )
  );

create policy campaign_deliverables_write on public.campaign_deliverables for all to authenticated
  using (
    exists (
      select 1 from public.campaigns c
      where c.id = campaign_deliverables.campaign_id
        and (private.is_member(c.organization_id) or private.is_admin())
        and c.status in ('draft', 'pending_review')
    )
  );

-- Campaign Applications Policies
-- Creators can read their own applications; Brand org members can read applications to their campaigns
create policy applications_read on public.campaign_applications for select to authenticated
  using (
    creator_id = (select auth.uid())
    or exists (
      select 1 from public.campaigns c
      where c.id = campaign_applications.campaign_id
        and (private.is_member(c.organization_id) or private.is_admin())
    )
  );

-- Creators can insert their own application if campaign is live and deadline not passed
create policy applications_creator_insert on public.campaign_applications for insert to authenticated
  with check (
    creator_id = (select auth.uid())
    and private.is_active()
    and status = 'submitted'
    and exists (
      select 1 from public.campaigns c
      where c.id = campaign_applications.campaign_id
        and c.status = 'live'
        and (c.application_deadline is null or c.application_deadline > now())
    )
  );

-- Creator can update (e.g. withdraw) their own application if permitted; Org members can update status
create policy applications_update on public.campaign_applications for update to authenticated
  using (
    creator_id = (select auth.uid())
    or exists (
      select 1 from public.campaigns c
      where c.id = campaign_applications.campaign_id
        and (private.is_member(c.organization_id) or private.is_admin())
    )
  )
  with check (
    (
      creator_id = (select auth.uid())
      and status = 'withdrawn'
    )
    or exists (
      select 1 from public.campaigns c
      where c.id = campaign_applications.campaign_id
        and (private.is_member(c.organization_id) or private.is_admin())
    )
  );

-- Status History Policies
create policy app_status_history_read on public.campaign_application_status_history for select to authenticated
  using (
    exists (
      select 1 from public.campaign_applications a
      where a.id = campaign_application_status_history.application_id
        and (
          a.creator_id = (select auth.uid())
          or exists (
            select 1 from public.campaigns c
            where c.id = a.campaign_id
              and (private.is_member(c.organization_id) or private.is_admin())
          )
        )
    )
  );

-- 9. Protected RPC Functions for State Transitions & Invariant Enforcement

-- Submit Campaign for Review
create or replace function public.submit_campaign_for_review(p_campaign_id uuid)
returns public.campaigns
language plpgsql security definer set search_path = '' as $$
declare
  v_campaign public.campaigns;
  v_actor uuid := auth.uid();
begin
  if v_actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
  
  select * into v_campaign from public.campaigns where id = p_campaign_id for update;
  if not found then raise exception 'Campaign not found' using errcode = 'P0002'; end if;
  
  if not (private.is_member(v_campaign.organization_id) or private.is_admin()) then
    raise exception 'Unauthorized' using errcode = '42501';
  end if;
  
  if v_campaign.status <> 'draft' then
    raise exception 'Only draft campaigns can be submitted for review' using errcode = '22023';
  end if;
  
  update public.campaigns
  set status = 'pending_review', updated_at = now()
  where id = p_campaign_id
  returning * into v_campaign;
  
  return v_campaign;
end;
$$;

-- Moderate Campaign (Admin / Trusted Server Transition)
create or replace function public.moderate_campaign(
  p_campaign_id uuid,
  p_action text, -- 'approve' or 'reject'
  p_reason text default null
)
returns public.campaigns
language plpgsql security definer set search_path = '' as $$
declare
  v_campaign public.campaigns;
  v_actor uuid := auth.uid();
begin
  if v_actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
  if not private.is_admin() then raise exception 'Admin privileges required' using errcode = '42501'; end if;
  
  select * into v_campaign from public.campaigns where id = p_campaign_id for update;
  if not found then raise exception 'Campaign not found' using errcode = 'P0002'; end if;
  
  if v_campaign.status <> 'pending_review' then
    raise exception 'Only pending_review campaigns can be moderated' using errcode = '22023';
  end if;
  
  if p_action = 'approve' then
    update public.campaigns
    set status = 'live', published_at = now(), updated_at = now()
    where id = p_campaign_id
    returning * into v_campaign;
  elsif p_action = 'reject' then
    update public.campaigns
    set status = 'rejected', rejection_reason = p_reason, updated_at = now()
    where id = p_campaign_id
    returning * into v_campaign;
  else
    raise exception 'Invalid moderation action: %', p_action using errcode = '22023';
  end if;
  
  return v_campaign;
end;
$$;

-- Transition Campaign Application Status (Brand / Agency Organization Workflow)
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
begin
  if v_actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
  
  select * into v_app from public.campaign_applications where id = p_application_id for update;
  if not found then raise exception 'Application not found' using errcode = 'P0002'; end if;
  
  select * into v_campaign from public.campaigns where id = v_app.campaign_id;
  if not (private.is_member(v_campaign.organization_id) or private.is_admin()) then
    raise exception 'Unauthorized' using errcode = '42501';
  end if;
  
  -- Prevent selecting beyond creator slots capacity
  if p_new_status = 'selected' and v_app.status <> 'selected' then
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
  values (p_application_id, v_app.status, p_new_status, v_actor, p_reason);
  
  return v_app;
end;
$$;

-- Withdraw Campaign Application (Creator Workflow)
create or replace function public.withdraw_campaign_application(p_application_id uuid)
returns public.campaign_applications
language plpgsql security definer set search_path = '' as $$
declare
  v_app public.campaign_applications;
  v_actor uuid := auth.uid();
begin
  if v_actor is null then raise exception 'Authentication required' using errcode = '42501'; end if;
  
  select * into v_app from public.campaign_applications where id = p_application_id for update;
  if not found then raise exception 'Application not found' using errcode = 'P0002'; end if;
  
  if v_app.creator_id <> v_actor then
    raise exception 'Unauthorized to withdraw this application' using errcode = '42501';
  end if;
  
  if v_app.status in ('selected', 'rejected', 'withdrawn') then
    raise exception 'Cannot withdraw application in status: %', v_app.status using errcode = '22023';
  end if;
  
  update public.campaign_applications
  set status = 'withdrawn', withdrawn_at = now(), updated_at = now()
  where id = p_application_id
  returning * into v_app;
  
  insert into public.campaign_application_status_history(application_id, from_status, to_status, changed_by, reason)
  values (p_application_id, v_app.status, 'withdrawn', v_actor, 'Withdrawn by creator');
  
  return v_app;
end;
$$;

-- Grants
grant select, insert, update, delete on public.campaigns to authenticated;
grant select, insert, update, delete on public.campaign_categories to authenticated;
grant select, insert, update, delete on public.campaign_languages to authenticated;
grant select, insert, update, delete on public.campaign_deliverables to authenticated;
grant select, insert, update on public.campaign_applications to authenticated;
grant select on public.campaign_application_status_history to authenticated;
grant execute on function public.submit_campaign_for_review(uuid), public.moderate_campaign(uuid, text, text), public.transition_campaign_application_status(uuid, public.campaign_application_status, text), public.withdraw_campaign_application(uuid) to authenticated;
