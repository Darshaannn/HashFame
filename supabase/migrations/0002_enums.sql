create type public.account_state as enum ('onboarding', 'active', 'blocked', 'deletion_requested');
create type public.professional_role as enum ('creator', 'brand_marketer', 'agency', 'talent_manager', 'admin');
create type public.verification_status as enum ('unverified', 'pending', 'verified', 'rejected');
create type public.organization_type as enum ('brand', 'agency');
create type public.record_status as enum ('active', 'inactive');
create type public.membership_role as enum ('owner', 'member');
create type public.theme_preference as enum ('system', 'light', 'dark');
