-- Phase 5 / Phase 03: Creator Contact, Private Quotations & Outreach System
-- 0016_phase5_creator_contact_outreach.sql

-- 1. Enums
create type public.contact_request_type as enum (
  'brand_collaboration',
  'paid_partnership',
  'barter_collaboration',
  'event_appearance',
  'ugc_requirement',
  'request_quotation',
  'other'
);

create type public.contact_request_status as enum (
  'pending',
  'accepted',
  'declined',
  'cancelled',
  'expired'
);

create type public.outreach_contact_method as enum (
  'in_app',
  'instagram',
  'whatsapp',
  'email',
  'phone'
);

create type public.external_outreach_stage as enum (
  'channel_opened',
  'contacted_manually',
  'response_received',
  'follow_up_required'
);

-- 2. Creator Contact Preferences Table
-- Allows registered creators to control private contact sharing
create table if not exists public.creator_contact_preferences (
  creator_id uuid primary key references public.creator_profiles(user_id) on delete cascade,
  allow_collaboration_requests boolean not null default true,
  allow_business_email boolean not null default false,
  business_email text check (business_email is null or char_length(btrim(business_email)) between 5 and 255),
  allow_phone boolean not null default false,
  phone_number text check (phone_number is null or char_length(btrim(phone_number)) between 7 and 20),
  allow_whatsapp boolean not null default false,
  whatsapp_number text check (whatsapp_number is null or char_length(btrim(whatsapp_number)) between 7 and 20),
  preferred_contact_method public.outreach_contact_method not null default 'in_app',
  response_time_hours integer default 48,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 3. Contact Requests Table
-- Manages private outreach & quotation requests between Brands/Agencies and Creators
create table if not exists public.creator_contact_requests (
  id uuid primary key default gen_random_uuid(),
  sender_user_id uuid not null references public.profiles(id) on delete cascade,
  sender_organization_id uuid references public.organizations(id) on delete cascade,
  sender_organization_name text not null check (char_length(btrim(sender_organization_name)) between 1 and 150),
  
  -- Recipient can be registered creator (UUID) or directory influencer (directory_id text)
  recipient_creator_id uuid references public.creator_profiles(user_id) on delete cascade,
  recipient_directory_id text references public.creator_directory(directory_id) on delete set null,
  recipient_display_name text not null check (char_length(btrim(recipient_display_name)) between 1 and 150),
  recipient_avatar_path text,
  is_registered_creator boolean not null default false,

  request_type public.contact_request_type not null default 'brand_collaboration',
  campaign_name text check (campaign_name is null or char_length(btrim(campaign_name)) <= 150),
  collaboration_requirement text not null check (char_length(btrim(collaboration_requirement)) between 5 and 3000),
  deliverables text[] not null default '{}',
  expected_timeline text check (expected_timeline is null or char_length(btrim(expected_timeline)) <= 150),
  personal_message text check (personal_message is null or char_length(btrim(personal_message)) <= 3000),

  status public.contact_request_status not null default 'pending',
  contact_method public.outreach_contact_method not null default 'in_app',
  external_stage public.external_outreach_stage default 'channel_opened',
  
  decline_reason text,
  cancellation_reason text,
  
  -- Associated conversation ID if accepted
  conversation_id uuid,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  -- Ensure either registered UUID or directory ID is populated
  constraint chk_contact_recipient check (
    (recipient_creator_id is not null) or (recipient_directory_id is not null)
  )
);

-- Prevent duplicate active pending requests between same sender & recipient
create unique index if not exists uq_pending_creator_request
  on public.creator_contact_requests(sender_user_id, recipient_creator_id)
  where status = 'pending' and recipient_creator_id is not null;

create unique index if not exists uq_pending_directory_request
  on public.creator_contact_requests(sender_user_id, recipient_directory_id)
  where status = 'pending' and recipient_directory_id is not null;

-- 4. Private Quotation Responses Table
-- Private commercial quotes provided by creators in response to quotation requests
create table if not exists public.creator_quotations (
  id uuid primary key default gen_random_uuid(),
  request_id uuid not null references public.creator_contact_requests(id) on delete cascade,
  creator_id uuid not null references public.creator_profiles(user_id) on delete cascade,
  proposed_amount numeric(12,2) not null check (proposed_amount >= 0),
  currency text not null default 'INR' check (char_length(btrim(currency)) between 2 and 5),
  deliverable_description text not null check (char_length(btrim(deliverable_description)) between 2 and 2000),
  usage_rights text check (usage_rights is null or char_length(btrim(usage_rights)) <= 500),
  timeline text check (timeline is null or char_length(btrim(timeline)) <= 200),
  notes text check (notes is null or char_length(btrim(notes)) <= 2000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 5. Outreach Conversations Table
-- Authorized pre-campaign message channels created upon contact request acceptance
create table if not exists public.outreach_conversations (
  id uuid primary key default gen_random_uuid(),
  request_id uuid not null references public.creator_contact_requests(id) on delete cascade,
  organization_id uuid references public.organizations(id) on delete cascade,
  brand_user_id uuid not null references public.profiles(id) on delete cascade,
  creator_user_id uuid not null references public.profiles(id) on delete cascade,
  subject text not null check (char_length(btrim(subject)) between 1 and 200),
  last_message_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

-- 6. Outreach Messages Table
create table if not exists public.outreach_messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.outreach_conversations(id) on delete cascade,
  sender_id uuid not null references public.profiles(id) on delete cascade,
  sender_name text not null check (char_length(btrim(sender_name)) between 1 and 150),
  content text not null check (char_length(btrim(content)) between 1 and 4000),
  read_at timestamptz,
  created_at timestamptz not null default now()
);

-- 7. User Blocks & Safety Reports
create table if not exists public.user_blocks (
  id uuid primary key default gen_random_uuid(),
  blocker_user_id uuid not null references public.profiles(id) on delete cascade,
  blocked_user_id uuid not null references public.profiles(id) on delete cascade,
  reason text check (reason is null or char_length(btrim(reason)) <= 500),
  created_at timestamptz not null default now(),
  constraint uq_user_block unique (blocker_user_id, blocked_user_id)
);

create table if not exists public.contact_safety_reports (
  id uuid primary key default gen_random_uuid(),
  reporter_user_id uuid not null references public.profiles(id) on delete cascade,
  reported_user_id uuid references public.profiles(id) on delete set null,
  reported_directory_id text references public.creator_directory(directory_id) on delete set null,
  request_id uuid references public.creator_contact_requests(id) on delete set null,
  reason text not null check (char_length(btrim(reason)) between 2 and 500),
  details text check (details is null or char_length(btrim(details)) <= 2000),
  created_at timestamptz not null default now()
);

-- 8. Enable Row Level Security (RLS)
alter table public.creator_contact_preferences enable row level security;
alter table public.creator_contact_requests enable row level security;
alter table public.creator_quotations enable row level security;
alter table public.outreach_conversations enable row level security;
alter table public.outreach_messages enable row level security;
alter table public.user_blocks enable row level security;
alter table public.contact_safety_reports enable row level security;

-- 9. RLS Policies
-- Preferences: Creator controls their own preferences; public reads only allowed fields
create policy "creator_contact_pref_select"
  on public.creator_contact_preferences for select to authenticated
  using (true);

create policy "creator_contact_pref_write"
  on public.creator_contact_preferences for all to authenticated
  using (creator_id = auth.uid())
  with check (creator_id = auth.uid());

-- Contact Requests: Senders or recipients can view
create policy "contact_requests_select"
  on public.creator_contact_requests for select to authenticated
  using (
    sender_user_id = auth.uid() or
    recipient_creator_id = auth.uid() or
    (sender_organization_id is not null and exists (
      select 1 from public.organization_members om
      where om.organization_id = creator_contact_requests.sender_organization_id
      and om.user_id = auth.uid()
    ))
  );

create policy "contact_requests_insert"
  on public.creator_contact_requests for insert to authenticated
  with check (sender_user_id = auth.uid());

create policy "contact_requests_update"
  on public.creator_contact_requests for update to authenticated
  using (
    sender_user_id = auth.uid() or
    recipient_creator_id = auth.uid()
  );

-- Quotations: Only authorized sender or recipient creator
create policy "quotations_select"
  on public.creator_quotations for select to authenticated
  using (
    creator_id = auth.uid() or
    exists (
      select 1 from public.creator_contact_requests r
      where r.id = creator_quotations.request_id
      and (r.sender_user_id = auth.uid() or (
        r.sender_organization_id is not null and exists (
          select 1 from public.organization_members om
          where om.organization_id = r.sender_organization_id
          and om.user_id = auth.uid()
        )
      ))
    )
  );

create policy "quotations_insert"
  on public.creator_quotations for insert to authenticated
  with check (creator_id = auth.uid());

-- Outreach Conversations: Only authorized participants
create policy "outreach_conversations_select"
  on public.outreach_conversations for select to authenticated
  using (
    brand_user_id = auth.uid() or
    creator_user_id = auth.uid() or
    (organization_id is not null and exists (
      select 1 from public.organization_members om
      where om.organization_id = outreach_conversations.organization_id
      and om.user_id = auth.uid()
    ))
  );

-- Outreach Messages: Participants of conversation
create policy "outreach_messages_select"
  on public.outreach_messages for select to authenticated
  using (
    exists (
      select 1 from public.outreach_conversations c
      where c.id = outreach_messages.conversation_id
      and (
        c.brand_user_id = auth.uid() or
        c.creator_user_id = auth.uid() or
        (c.organization_id is not null and exists (
          select 1 from public.organization_members om
          where om.organization_id = c.organization_id
          and om.user_id = auth.uid()
        ))
      )
    )
  );

create policy "outreach_messages_insert"
  on public.outreach_messages for insert to authenticated
  with check (
    sender_id = auth.uid() and
    exists (
      select 1 from public.outreach_conversations c
      where c.id = outreach_messages.conversation_id
      and (
        c.brand_user_id = auth.uid() or
        c.creator_user_id = auth.uid() or
        (c.organization_id is not null and exists (
          select 1 from public.organization_members om
          where om.organization_id = c.organization_id
          and om.user_id = auth.uid()
        ))
      )
    )
  );

create policy "outreach_messages_update"
  on public.outreach_messages for update to authenticated
  using (
    exists (
      select 1 from public.outreach_conversations c
      where c.id = outreach_messages.conversation_id
      and (c.brand_user_id = auth.uid() or c.creator_user_id = auth.uid())
    )
  );

-- Blocks
create policy "user_blocks_policy"
  on public.user_blocks for all to authenticated
  using (blocker_user_id = auth.uid())
  with check (blocker_user_id = auth.uid());

-- Reports
create policy "safety_reports_insert"
  on public.contact_safety_reports for insert to authenticated
  with check (reporter_user_id = auth.uid());

-- 10. Indexes for Fast Access
create index if not exists idx_contact_req_sender on public.creator_contact_requests(sender_user_id, status);
create index if not exists idx_contact_req_creator on public.creator_contact_requests(recipient_creator_id, status);
create index if not exists idx_contact_req_org on public.creator_contact_requests(sender_organization_id, status);
create index if not exists idx_outreach_conv_participants on public.outreach_conversations(brand_user_id, creator_user_id);
create index if not exists idx_outreach_msg_conv on public.outreach_messages(conversation_id, created_at asc);

-- 11. Realtime Publication
alter table public.creator_contact_requests replica identity full;
alter table public.outreach_conversations replica identity full;
alter table public.outreach_messages replica identity full;

do $$
begin
  if exists (select 1 from pg_publication where pubname = 'supabase_realtime') then
    alter publication supabase_realtime add table public.creator_contact_requests, public.outreach_conversations, public.outreach_messages;
  end if;
end $$;

-- 12. Permissions Grant
grant select, insert, update on public.creator_contact_preferences to authenticated;
grant select, insert, update on public.creator_contact_requests to authenticated;
grant select, insert, update on public.creator_quotations to authenticated;
grant select, insert, update on public.outreach_conversations to authenticated;
grant select, insert, update on public.outreach_messages to authenticated;
grant select, insert, delete on public.user_blocks to authenticated;
grant insert on public.contact_safety_reports to authenticated;
