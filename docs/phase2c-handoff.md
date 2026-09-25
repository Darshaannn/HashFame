# Phase 2C Handoff: Campaign Marketplace, Creator Opportunities & Applications

## 1. Executive Summary
Phase 2C delivers the two-sided GGs campaign marketplace connecting Brands/Agencies and Creators. Brands create structured campaign briefs with granular compensation, deliverable requirements, usage rights, and timeline milestones. Creators discover live opportunities with typed filters, inspect comprehensive requirements transparently, apply with rates/pitches, and track application lifecycle statuses in real-time.

---

## 2. Architecture & Data Model

### A. Database Migrations
- **Migration**: `supabase/migrations/0012_phase2c_campaign_marketplace.sql`
- **Tables**:
  - `campaigns`: Core campaign record with organization ownership, status, budget, barter details, slots, location, follower constraints, usage rights, and deadlines.
  - `campaign_categories`: Junction table linking campaigns to category reference IDs.
  - `campaign_languages`: Junction table linking campaigns to language codes.
  - `campaign_deliverables`: Structured deliverable requirements (`deliverable_type`, `platform`, `quantity`, `description`).
  - `campaign_applications`: Creator applications (`creator_id`, `pitch`, `proposed_rate`, `currency`, `status`).
  - `campaign_application_status_history`: Immutable append-only audit trail of application state changes.
- **RPC Functions**:
  - `submit_campaign_for_review(p_campaign_id UUID)`
  - `moderate_campaign(p_campaign_id UUID, p_action TEXT, p_rejection_reason TEXT)`
  - `submit_campaign_application(p_campaign_id UUID, p_pitch TEXT, p_proposed_rate NUMERIC, p_currency TEXT)`
  - `transition_campaign_application_status(p_application_id UUID, p_new_status campaign_application_status, p_reason TEXT)`
  - `withdraw_campaign_application(p_application_id UUID)`

### B. Campaign Lifecycle State Machine
```
draft -> pending_review -> live -> paused -> live -> closed
draft -> cancelled
pending_review -> rejected (Changes Requested)
live -> cancelled
```

### C. Application Lifecycle State Machine
```
submitted -> under_review -> shortlisted -> selected
submitted -> rejected
submitted -> withdrawn (by creator)
under_review -> rejected
under_review -> withdrawn (by creator)
shortlisted -> rejected
shortlisted -> withdrawn (by creator)
```

### D. Compensation & Usage Rights
- **Compensation Types**: `paid`, `barter`, `paid_and_barter`
- **Deliverables**: `instagram_reel`, `instagram_story`, `instagram_post`, `youtube_video`, `youtube_integration`, `youtube_short`, `ugc_video`, `other`
- **Usage Rights**: `organic_reposting_allowed`, `paid_usage_required`, `whitelisting_required`, `usage_duration_months`, `usage_territory`, `exclusivity_required`, `exclusivity_duration_days`, `content_approval_required`, `disclosure_required`

---

## 3. Security & Isolation Model (RLS)
1. **Organization Isolation**: Only members of the owning organization can read/edit private drafts or view campaign applicants.
2. **Public Discovery Restriction**: Ordinary creators can only view campaigns where `status = 'live'`.
3. **Application Privacy**: Creators can only read and mutate their own applications. Cross-creator application leakage is blocked.
4. **Moderation Boundary**: Transitioning `pending_review` to `live` is protected and cannot be forged by mobile clients.
5. **Duplicate Prevention**: Database unique index prevents multiple active applications by the same creator for the same campaign.
6. **Deadline Enforcement**: Late applications are rejected at the server boundary.

---

## 4. Repositories & Riverpod Controllers
- `CampaignRepository` / `CampaignRepositoryImpl` / `FakeCampaignRepository`
- `opportunitySearchControllerProvider` & `campaignFiltersProvider`: Live discovery feed & typed filtering.
- `campaignActionControllerProvider`: Draft creation, brief updates, submission, pausing, closing, application submission, status transitions, withdrawal.
- `organizationCampaignsProvider`, `campaignDetailProvider`, `campaignApplicantsProvider`, `creatorApplicationsProvider`, `applicationDetailProvider`.

---

## 5. Screen Inventory
- `/opportunities`: Creator discovery feed (`CreatorOpportunitiesScreen`).
- `/opportunities/:campaignId`: Transparent brief detail & application modal (`CampaignDetailScreen`).
- `/applications`: Creator application list (`CreatorApplicationsScreen`).
- `/applications/:applicationId`: Application detail & withdrawal (`CreatorApplicationDetailScreen`).
- `/campaigns`: Brand campaign management (`BrandCampaignsScreen`).
- `/campaigns/new`, `/campaigns/:campaignId/edit`: Multi-step structured brief creation (`CampaignCreationScreen`).
- `/campaigns/:campaignId/applicants`: Brand applicant review & slot tracking (`CampaignApplicantDashboardScreen`).

---

## 6. Testing & Quality Summary
- **Flutter Analyzer**: 0 issues (`No issues found!`)
- **Flutter Tests**: 102 total, 102 passed, 0 failed
- **Android Debug APK**: Built successfully via `flutter build apk --flavor local --debug`
- **SQL / RLS Security Tests**: Authored in `supabase/tests/phase2c_security.sql` (`AUTHORED / NOT RUNTIME EXECUTED` as Docker/local PostgreSQL testing remains deferred).
