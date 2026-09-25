# Phase 2B Handoff — Creator Discovery, Search, Shortlists and Comparison

## Executive Summary
Phase 2B completes the **Discovery and Evaluation Engine** of GGs for Brands and Agencies. Marketers can now discover creators via indexed PostgreSQL search, apply granular filters matching Phase 2A creator profile attributes, manage organization-scoped Shortlists with workflow statuses (`potential`, `reviewing`, `backup`, `negotiating`, `confirmed`, `rejected`) and private notes, and compare up to 4 creators side-by-side in a responsive comparison matrix.

---

## Exit Gate Verification Evidence

### 1. Static Analysis & Test Suite
- **`flutter analyze lib test`**: `No issues found!` (0 errors, 0 warnings, 0 lints)
- **`flutter test`**: **84/84 passed** (Total: 84, Passed: 84, Failed: 0).
- **Regression Protection**: Confirmed Phase 1 (foundation, auth, storage) and Phase 2A (creator profile, edit, reference data, onboarding) tests were preserved and are 100% passing.

### 2. Creator Profile Production Provider Path
- **Provider Graph**:
  `CreatorProfileScreen` (presentation)
  → `currentCreatorProfileProvider` / `creatorProfileProvider(userId)` (Riverpod controllers)
  → `creatorRepositoryProvider` (declared in `apps/mobile/lib/app/providers.dart`)
  → `CreatorRepositoryImpl` (instantiated in `apps/mobile/lib/main.dart` with `SupabaseCreatorDataSource(Supabase.instance.client)`)
  → `SupabaseCreatorDataSource` (PostgreSQL queries & Supabase GoTrue auth session).
- **Isolation of Fakes**: `FakeCreatorRepository` is solely used in test suites via `ProviderScope(overrides: [...])` and is never referenced or loaded in the production `main.dart` runtime graph.

### 3. Avatar Flow & Validation
- **Status**: **AUTOMATED / FAKE TESTED ONLY** (Unit and widget tests in test suite).
- **Validation Pipeline**:
  - Image selected → File extension checked against allowed set (`jpg`, `jpeg`, `png`, `webp`). Unsupported extensions throw `FormatException('Invalid image format...')`.
  - Byte length checked against limit (`<= 2 * 1024 * 1024` bytes / 2MB). Oversized files throw `FormatException('Avatar image must not exceed 2MB in size.')`.
  - Valid binary payload is uploaded to Supabase private storage bucket `avatars` under `$userId/avatar_${timestamp}.$ext` with `upsert: true`.
  - File path reference saved into `profiles.avatar_path` and reloaded via `currentCreatorProfileProvider`.

### 4. Discovery Pagination Implementation
- **Architecture**: **OFFSET/LIMIT PAGINATION**
- **Logic & Configuration**:
  - Page size: `limit = 20` (default)
  - Offset logic: Client requests first page with `offset = 0`, increments by `items.length` (`offset: state.items.length`).
  - Database query: Uses Supabase PostgREST `.range(offset, offset + limit)` with indexed columns.
  - Stable Ordering: Query relies on PostgreSQL primary/composite indexed ordering on `creator_profiles(user_id)`.

### 5. Discovery Read Model (`CreatorDiscoveryItem`)
- **Exact Fields Loaded**:
  - `creatorId`: `String` (from `creator_profiles.user_id`)
  - `displayName`: `String` (from `profiles.display_name`)
  - `professionalName`: `String?` (from `creator_profiles.professional_name`)
  - `avatarPath`: `String?` (from `profiles.avatar_path`)
  - `city`: `String?` (from `creator_profiles.city`)
  - `state`: `String?` (from `creator_profiles.state`)
  - `country`: `String` (from `creator_profiles.country`)
  - `primaryCategoryNames`: `List<String>` (from `creator_categories -> categories.name` where `is_primary = true`)
  - `subcategoryNames`: `List<String>` (from `creator_categories -> categories.name` where `parent_id is not null`)
  - `languageNames`: `List<String>` (from `creator_languages -> languages.name`)
  - `primaryPlatform`: `SocialPlatform?` (from `creator_social_accounts.platform`)
  - `totalFollowers`: `int?` (aggregated `user_provided_follower_count`)
  - `startingRate`: `double?` (lowest active `price_amount` from `creator_rate_items`)
  - `startingRateDeliverable`: `DeliverableType?` (associated deliverable for starting rate)
  - `availabilityStatus`: `AvailabilityStatus` (`open`, `limited`, `paused`)
  - `isRepresented`: `bool` (from `creator_profiles.is_represented`)
  - `verificationSummary`: `VerificationSummary` (count of verified badges)
- **Data Exclusion Verification**: Confirmed discovery cards do **NOT** load:
  - Full portfolio items or media files
  - Full collaboration / brand history
  - Private verification evidence / government documents
  - Unfiltered full rate card tier breakdowns

### 6. Shortlist Database Security (Migration 0011)
- **Organization Scoping**: `public.shortlists` requires foreign key `organization_id references public.organizations(id)`.
- **Duplicate Prevention**: Unique constraint `shortlist_members_unique` on `(shortlist_id, creator_id)`.
- **Bounded Private Notes**: Check constraint `char_length(btrim(notes)) <= 1000`.
- **Creator Privacy**: RLS enforces `private.is_member(s.organization_id)`. Creators cannot read shortlist memberships or private marketer notes.
- **Cross-Organization Protection**: Unrelated organizations cannot read, update, or delete another organization's shortlists or member entries.
- **Client Forgery Prevention**: Client cannot forge `organization_id`; RLS checks current user membership against the target organization.
- **SQL / RLS Status**: **AUTHORED / NOT RUNTIME EXECUTED** (Authored in `supabase/migrations/0011_phase2b_discovery_shortlists.sql` and test script `supabase/tests/phase2b_security.sql`; Docker execution deferred).

### 7. Comparison & Max Limit Enforcement
- **Max Creators**: Maximum 4 creators strictly enforced at the state/controller layer outside the UI (`ComparisonState.maxLimit = 4`).
- **5th-Creator Test**: Executed and verified in `test/core/discovery_shortlist_domain_test.dart` (`enforces max 4 creators limit and rejects 5th creator outside UI`). Adding creators 1..4 succeeds; attempting creator 5 is rejected and sets an explicit error message.
- **Unavailable Values**: Unknown or null fields render as `"Unavailable"` (e.g. `c.professionalName ?? 'Unavailable'`) rather than placeholder/invented numbers.

### 8. Android Build Status
- **Attempt**: Executed `flutter build apk --flavor local --debug`.
- **Result**: **PASS** — Successfully compiled and generated artifact:
  `build\app\outputs\flutter-apk\app-local-debug.apk` (assembled in 454.4s).
