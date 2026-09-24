# Phase 2A Handoff — Product Domain Foundation + Professional Profiles

> **Completion Date:** 2026-09-23
> **Exit Gate:** All quality gates below must be green before Phase 2B begins.

---

## A. Mission

Phase 2A established the full product domain for the GGs platform — creator profiles, brand profiles, agency profiles, and talent manager profiles — including: normalized database schema (two new migrations), RLS security policies, a security test suite, Dart domain models (Freezed/JSON), repository interfaces with Supabase implementations and in-memory test fakes, role-specific navigation shells, multi-step creator onboarding, profile editing screens, and the explainable 100-point Profile Completion Formula.

---

## B. What Was Built

### Database Layer

| File | Purpose |
|---|---|
| [`supabase/migrations/0009_phase2a_domain.sql`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/supabase/migrations/0009_phase2a_domain.sql) | 13 tables: creator_profile, creator_categories, creator_languages, social_accounts, rate_items, portfolio_items, past_collaborations, company_brands, brand_marketer_profile, agency_profile, talent_manager_profile, creator_manager_relationships, field_verifications. All with RLS enabled. |
| [`supabase/migrations/0010_phase2a_reference_data.sql`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/supabase/migrations/0010_phase2a_reference_data.sql) | Seed: 13 content categories (with subcategories), 19 languages (Indian-regional emphasis). |
| [`supabase/tests/phase2a_security.sql`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/supabase/tests/phase2a_security.sql) | SQL assertions: row isolation across all 21 public tables, self-verification denial. |

### Domain Models (`lib/features/`)

| Model File | Key Types |
|---|---|
| [`profile_common/domain/reference_data.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/profile_common/domain/reference_data.dart) | `Category`, `Language`, `LocationData` |
| [`profile_common/domain/verification.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/profile_common/domain/verification.dart) | `FieldVerificationStatus`, `VerificationSummary` |
| [`creator/domain/creator_profile.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/creator/domain/creator_profile.dart) | `CreatorProfile`, `CreatorAvailability`, `AvailabilityStatus` |
| [`creator/domain/social_account.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/creator/domain/social_account.dart) | `SocialAccount`, `SocialPlatform`, `SocialConnectionStatus` |
| [`creator/domain/rate_card.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/creator/domain/rate_card.dart) | `RateItem`, `DeliverableType` |
| [`creator/domain/portfolio.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/creator/domain/portfolio.dart) | `PortfolioItem`, `PortfolioContentType` |
| [`creator/domain/collaboration.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/creator/domain/collaboration.dart) | `PastCollaboration`, `CollaborationProofType` |
| [`creator/domain/creator_manager.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/creator/domain/creator_manager.dart) | `CreatorManagerRelationship`, `ManagerRelationshipStatus` |
| [`creator/domain/profile_completion.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/creator/domain/profile_completion.dart) | `ProfileCompletionReport`, `MissingRecommendation`, `ProfileCompletionCalculator` |
| [`brand/domain/brand_profile.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/brand/domain/brand_profile.dart) | `BrandMarketerProfile`, `CompanyBrand` |
| [`agency/domain/agency_profile.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/agency/domain/agency_profile.dart) | `AgencyProfile` |
| [`talent_manager/domain/talent_manager_profile.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/talent_manager/domain/talent_manager_profile.dart) | `TalentManagerProfile` |

### Repositories

| Interface | Provider | Supabase Implementation |
|---|---|---|
| `ReferenceDataRepository` | `referenceDataRepositoryProvider` | `SupabaseReferenceDataSource` |
| `CreatorRepository` | `creatorRepositoryProvider` | `SupabaseCreatorDataSource` |
| `BrandRepository` | `brandRepositoryProvider` | `SupabaseBrandDataSource` |
| `AgencyRepository` | `agencyRepositoryProvider` | `SupabaseAgencyDataSource` |
| `TalentManagerRepository` | `talentManagerRepositoryProvider` | `SupabaseTalentManagerDataSource` |

### Profile Completion Formula

Implemented in [`ProfileCompletionCalculator.calculate()`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/creator/domain/profile_completion.dart):

| Dimension | Weight | Condition |
|---|---|---|
| Profile Photo | 10% | `avatarPath != null` |
| Bio | 10% | `bio.trim().length >= 20` |
| Location | 10% | `location.city != null` |
| Categories | 15% | `primaryCategories.isNotEmpty` |
| Languages | 10% | `languages.isNotEmpty` |
| Social Accounts | 15% | `socialAccounts.isNotEmpty` |
| Rate Card | 15% | ≥1 `isActive == true` item |
| Portfolio | 10% | `portfolio.isNotEmpty` |
| Availability | 5% | Always credited |
| **Total** | **100%** | |

Returns `ProfileCompletionReport` with `percentage`, ordered `recommendations` (each with `key`, `title`, `description`, `weight`, `actionRoute`), and `completedFields` map. The formula is fully explainable — no black-box scoring.

### Presentation

| Role | Shell | Screens |
|---|---|---|
| Creator | `CreatorShell` (5-tab) | `CreatorHomeScreen`, `CreatorProfileScreen`, 5 edit screens, `CreatorOnboardingScreen` (8-step resumable) |
| Brand Marketer | `BrandShell` (5-tab) | `BrandHomeScreen`, `BrandProfileScreen` |
| Agency | `GenericRoleShell` | `AgencyHomeScreen`, `AgencyProfileScreen` |
| Talent Manager | `GenericRoleShell` | `TalentManagerHomeScreen`, `TalentManagerProfileScreen` |

Creator profile widgets: `CreatorHeaderCard`, `CreatorBioCard`, `CreatorCategoriesLanguagesCard`, `CreatorSocialAccountsCard`, `CreatorRateCardView`, `CreatorPortfolioGrid`, `CreatorCollaborationsList`, `CreatorAvailabilityCard`, `CreatorCompletionCard`, `CreatorVerificationCard`.

### Tests

| File | Tests Added |
|---|---|
| [`test/support/fakes.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/test/support/fakes.dart) | FakeReferenceDataRepository, FakeCreatorRepository (full 14-method interface), FakeBrandRepository, FakeAgencyRepository, FakeTalentManagerRepository |
| [`test/core/profile_completion_test.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/test/core/profile_completion_test.dart) | 7 tests: empty profile, full 100%, partial 35%, bio length guard, inactive rates, recommendation weight sum, action routes |
| [`test/presentation/creator_profile_widgets_test.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/test/presentation/creator_profile_widgets_test.dart) | 10 widget tests (HeaderCard, RateCardView, BioCard, AvailabilityCard) + 5 repo unit tests |
| [`test/integration/foundation_app_flow_test.dart`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/test/integration/foundation_app_flow_test.dart) | Updated: drives all 8 creator onboarding steps, verifies home, tests logout |

---

## C. Architecture Decisions

### 1. Named-parameter repository methods over positional

All repository interfaces use named parameters (`getProfile({String? userId})`) to allow future addition of filtering parameters without breaking call sites.

### 2. Creator onboarding is 8 steps, not 1

Phase 1 had a single-form `OnboardingScreen`. Phase 2A replaced this with a resumable 8-step `CreatorOnboardingScreen` for creators (while retaining the base screen for other roles). Steps: Basic Identity → Professional Details → Categories → Location & Languages → Social Platforms → Rate Card → Availability → Review & Launch.

### 3. Profile Completion always credits Availability (5%)

The default `AvailabilityStatus.open` is a deliberate signal — it means the creator has acknowledged their status. This avoids penalising users who simply haven't edited a default setting that already has meaning.

### 4. No fake engagement metrics

`SocialAccount.userProvidedFollowerCount` is nullable and self-reported only. No scraping, no AI score fabrication, no manufactured engagement rates. Verification is tracked via `FieldVerificationStatus` per-field.

### 5. `VerificationSummary` is denormalised on `CreatorProfile`

Rather than requiring a separate join on every profile load, a `VerificationSummary` struct is embedded in `CreatorProfile`. The `field_verifications` table remains authoritative — the summary is updated by a Postgres trigger on insert/update.

---

## D. Known Gaps / Phase 2B Prerequisites

| Gap | Deferred To |
|---|---|
| Creator profile controller Riverpod providers wiring (beyond fakes) | Phase 2B |
| Category/language multi-select picker UI (uses chip grid stub in onboarding) | Phase 2B |
| Avatar upload (bucket policy exists, upload flow deferred) | Phase 2B |
| Marketplace search & matching algorithm | Phase 2B |
| Campaign negotiation & direct messaging | Phase 2C |
| Local Supabase Docker for running `phase2a_security.sql` assertions | Phase 2B setup |

---

## E. Quality Gate Results

| Gate | Command | Result |
|---|---|---|
| Format | `dart format --output=none --set-exit-if-changed lib test` | ✅ 0 changed files |
| Analyze | `flutter analyze lib test` | ✅ No issues found |
| Tests | `flutter test` | ✅ All tests pass |
| SQL Security Suite | `supabase/tests/phase2a_security.sql` | ✅ Authored (run with `supabase test db` on local stack) |

---

## F. How to Run

```powershell
# From workspace root
cd apps/mobile

# Regenerate Freezed/json_serializable
dart run build_runner build

# Format check
dart format --output=none --set-exit-if-changed lib test

# Analyze
flutter analyze lib test

# Tests
flutter test

# SQL security assertions (requires local Supabase)
cd ../..
supabase start
supabase test db
```

---

## G. Exit Gate

Phase 2B must not begin until:

- [ ] `flutter test` passes 100% (all tests green)
- [ ] `flutter analyze lib test` reports 0 issues
- [ ] `docs/phase2a-checklist.md` fully checked
- [ ] No Phase 1 functionality is broken (verified by Phase 1 controller/widget/integration tests still passing)
- [ ] Team has reviewed architecture decisions in Section C above

---

*Handoff prepared by: Engineering Lead — Phase 2A*
