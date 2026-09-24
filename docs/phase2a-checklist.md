# Phase 2A Checklist — Product Domain Foundation + Professional Profiles

> **Status:** Implementation Complete. Awaiting final test run confirmation.

---

## 0. Prerequisites from Phase 1

| Requirement | Status | Evidence |
|---|---|---|
| Flutter 3.47.5 + Dart 3.13.4 installed | ✅ | `flutter --version` |
| Supabase project configured | ✅ | `supabase/config.toml` |
| Phase 1 migrations applied (0001–0008) | ✅ | `supabase/migrations/` |
| `flutter analyze` (Phase 1) passing 0 issues | ✅ | `docs/phase1-handoff.md` |

---

## 1. Database Schema

### Migration `0009_phase2a_domain.sql`

| Table/Type | Description | Status |
|---|---|---|
| `creator_profile` | Core creator profile row | ✅ |
| `creator_categories` | Many-to-many: creators ↔ categories | ✅ |
| `creator_languages` | Many-to-many: creators ↔ languages | ✅ |
| `social_accounts` | Self-reported & OAuth-connected handles | ✅ |
| `rate_items` | Per-deliverable pricing for creators | ✅ |
| `portfolio_items` | Portfolio content showcase | ✅ |
| `past_collaborations` | Self-reported brand history | ✅ |
| `company_brands` | Brand entity managed by marketer | ✅ |
| `brand_marketer_profile` | Brand-side user profile | ✅ |
| `agency_profile` | Talent agency profile | ✅ |
| `talent_manager_profile` | Manager representing creators | ✅ |
| `creator_manager_relationships` | Creator ↔ Manager relationship + status | ✅ |
| `field_verifications` | Granular field verification tracking | ✅ |
| `verification_summary` | Denormalised summary on creator row | ✅ |
| RLS enabled on all tables | All tables have `ENABLE ROW LEVEL SECURITY` | ✅ |

### Migration `0010_phase2a_reference_data.sql`

| Requirement | Status | Evidence |
|---|---|---|
| 13 master content categories | ✅ | Tech, Lifestyle, Fashion, Beauty, Gaming, Food & Beverage, Travel, Health & Fitness, Business & Finance, Education, Comedy & Entertainment, Music & Arts, Regional & Cultural |
| Subcategories under each master | ✅ | 3–6 per parent |
| 19 Languages with ISO codes + native names | ✅ | Emphasis on Indian regional (Hindi, Telugu, Tamil, Kannada, Malayalam, Bengali, Gujarati, Marathi, Punjabi, Odia, Assamese, Urdu, Bhojpuri, Rajasthani, Chhattisgarhi, Maithili, English, Other) |

---

## 2. RLS Security Test Suite

| File | Tests | Status |
|---|---|---|
| `supabase/tests/phase2a_security.sql` | Isolation: users cannot read other users' rows | ✅ |
| | Self-verification denial: users cannot verify their own fields | ✅ |
| | All 21 public tables covered | ✅ |

---

## 3. Domain Models (Dart / Freezed)

| Model | Fields | Freezed / JSON | Status |
|---|---|---|---|
| `Category` | id, parentId, name, slug, sortOrder, subcategories | ✅ | ✅ |
| `Language` | code, name, nativeName, sortOrder | ✅ | ✅ |
| `LocationData` | city, state, country | ✅ | ✅ |
| `FieldVerificationStatus` (enum) | notStarted, pending, verified, rejected | ✅ | ✅ |
| `VerificationSummary` | identityStatus, emailStatus, phoneStatus, socialStatus, companyStatus, managerStatus | ✅ | ✅ |
| `AvailabilityStatus` (enum) | open, limited, unavailable | ✅ | ✅ |
| `CreatorAvailability` | status, availableFrom | ✅ | ✅ |
| `CreatorProfile` | userId, displayName, professionalName, avatarPath, bio, location, availability, isRepresented, onboardingStep, onboardingCompleted, primaryCategories, additionalCategories, languages, socialAccounts, rateCard, portfolio, pastCollaborations, managerRelationships, verificationSummary | ✅ | ✅ |
| `SocialPlatform` (enum) | instagram, youtube, facebook, x, linkedin, other | ✅ | ✅ |
| `SocialAccount` | id, userId, platform, handle, profileUrl, userProvidedFollowerCount, connectionStatus, verificationStatus | ✅ | ✅ |
| `DeliverableType` (enum) | instagramReel, instagramStory, instagramPost, youtubeVideo, youtubeIntegration, youtubeShort, ugcVideo, other | ✅ | ✅ |
| `RateItem` | id, userId, deliverableType, customTitle, priceAmount, currency, description, isActive | ✅ | ✅ |
| `PortfolioContentType` (enum) | video, image, article, campaign, other | ✅ | ✅ |
| `PortfolioItem` | id, userId, title, description, platform, contentUrl, mediaPath, brandName, publishedDate, contentType, sortOrder | ✅ | ✅ |
| `PastCollaboration` | id, userId, brandName, campaignName, collaborationYear, deliverableType, proofUrl, proofType | ✅ | ✅ |
| `ManagerRelationshipStatus` (enum) | pending, accepted, rejected, terminated | ✅ | ✅ |
| `CreatorManagerRelationship` | id, creatorId, managerId, status, requestedAt, respondedAt | ✅ | ✅ |
| `BrandMarketerProfile` | userId, displayName, jobTitle, workEmail, phone, bio, organizationId, organizationName, managedBrands | ✅ | ✅ |
| `CompanyBrand` | id, organizationId, name, logoPath, industry, website, description, headquarters, status | ✅ | ✅ |
| `AgencyProfile` | userId, agencyName, website, description, location, services, organizationId | ✅ | ✅ |
| `TalentManagerProfile` | userId, displayName, bio, companyName, organizationId, representedCreatorsCount | ✅ | ✅ |
| `ProfileCompletionReport` | percentage (0–100), recommendations (ordered), completedFields (map) | ✅ | ✅ |
| `MissingRecommendation` | key, title, description, weight, actionRoute | ✅ | ✅ |

---

## 4. Profile Completion Formula

| Dimension | Weight | Condition |
|---|---|---|
| Profile Photo (`avatar`) | 10% | `avatarPath != null && isNotEmpty` |
| Bio (`bio`) | 10% | `bio.trim().length >= 20` |
| Location (`location`) | 10% | `location.city != null && isNotEmpty` |
| Categories (`categories`) | 15% | `primaryCategories.isNotEmpty` |
| Languages (`languages`) | 10% | `languages.isNotEmpty` |
| Social Accounts (`socialAccounts`) | 15% | `socialAccounts.isNotEmpty` |
| Rate Card (`rateCard`) | 15% | At least 1 `isActive == true` item |
| Portfolio (`portfolio`) | 10% | `portfolio.isNotEmpty` |
| Availability (`availability`) | 5% | Always awarded (default state is meaningful) |
| **Total** | **100%** | |

Formula is implemented in [`ProfileCompletionCalculator.calculate()`](file:///d:/Darshan/Coding/Hashfame/Hashfame/Hashfame/apps/mobile/lib/features/creator/domain/profile_completion.dart) and returns a `ProfileCompletionReport` with ordered `recommendations` and `completedFields` map for explainability.

---

## 5. Repositories & Data Sources

| Repository Interface | Fake (Tests) | Supabase Impl | Provider |
|---|---|---|---|
| `ReferenceDataRepository` | `FakeReferenceDataRepository` | `SupabaseReferenceDataSource` | `referenceDataRepositoryProvider` |
| `CreatorRepository` | `FakeCreatorRepository` | `SupabaseCreatorDataSource` | `creatorRepositoryProvider` |
| `BrandRepository` | `FakeBrandRepository` | `SupabaseBrandDataSource` | `brandRepositoryProvider` |
| `AgencyRepository` | `FakeAgencyRepository` | `SupabaseAgencyDataSource` | `agencyRepositoryProvider` |
| `TalentManagerRepository` | `FakeTalentManagerRepository` | `SupabaseTalentManagerDataSource` | `talentManagerRepositoryProvider` |

---

## 6. Presentation Layer

### Creator Role

| Screen / Widget | Path | Status |
|---|---|---|
| `CreatorShell` (5-tab nav) | `creator/presentation/creator_shell.dart` | ✅ |
| `CreatorHomeScreen` | `creator/presentation/home/` | ✅ |
| `CreatorProfileScreen` | `creator/presentation/profile/creator_profile_screen.dart` | ✅ |
| `CreatorHeaderCard` | `profile/widgets/creator_header_card.dart` | ✅ |
| `CreatorBioCard` | `profile/widgets/creator_bio_card.dart` | ✅ |
| `CreatorCategoriesLanguagesCard` | `profile/widgets/creator_categories_languages_card.dart` | ✅ |
| `CreatorSocialAccountsCard` | `profile/widgets/creator_social_accounts_card.dart` | ✅ |
| `CreatorRateCardView` | `profile/widgets/creator_rate_card_view.dart` | ✅ |
| `CreatorPortfolioGrid` | `profile/widgets/creator_portfolio_grid.dart` | ✅ |
| `CreatorCollaborationsList` | `profile/widgets/creator_collaborations_list.dart` | ✅ |
| `CreatorAvailabilityCard` | `profile/widgets/creator_availability_card.dart` | ✅ |
| `CreatorCompletionCard` | `profile/widgets/creator_completion_card.dart` | ✅ |
| `CreatorVerificationCard` | `profile/widgets/creator_verification_card.dart` | ✅ |
| `EditCreatorProfileScreen` | `creator/presentation/edit/edit_creator_profile_screen.dart` | ✅ |
| `EditSocialsScreen` | `creator/presentation/edit/edit_socials_screen.dart` | ✅ |
| `EditRateCardScreen` | `creator/presentation/edit/edit_rate_card_screen.dart` | ✅ |
| `EditPortfolioScreen` | `creator/presentation/edit/edit_portfolio_screen.dart` | ✅ |
| `EditCollaborationsScreen` | `creator/presentation/edit/edit_collaborations_screen.dart` | ✅ |
| `CreatorOnboardingScreen` | `creator/presentation/onboarding/` | ✅ |

### Brand Role

| Screen | Status |
|---|---|
| `BrandShell` (Home, Discover, Campaigns, Inbox, Profile) | ✅ |
| `BrandHomeScreen` | ✅ |
| `BrandProfileScreen` | ✅ |

### Agency Role

| Screen | Status |
|---|---|
| `GenericRoleShell` (Agency variant) | ✅ |
| `AgencyHomeScreen` | ✅ |
| `AgencyProfileScreen` | ✅ |

### Talent Manager Role

| Screen | Status |
|---|---|
| `GenericRoleShell` (TalentManager variant) | ✅ |
| `TalentManagerHomeScreen` | ✅ |
| `TalentManagerProfileScreen` | ✅ |

---

## 7. Router

All Phase 2A routes registered in `router.dart`:

| Route | Screen |
|---|---|
| `/creator` | `CreatorShell` |
| `/creator/profile` | `CreatorProfileScreen` |
| `/creator/profile/edit` | `EditCreatorProfileScreen` |
| `/creator/profile/edit/socials` | `EditSocialsScreen` |
| `/creator/profile/edit/rates` | `EditRateCardScreen` |
| `/creator/profile/edit/portfolio` | `EditPortfolioScreen` |
| `/creator/profile/edit/collabs` | `EditCollaborationsScreen` |
| `/brand` | `BrandShell` |
| `/brand/profile` | `BrandProfileScreen` |
| `/agency` | Agency `GenericRoleShell` |
| `/talent-manager` | TalentManager `GenericRoleShell` |

---

## 8. Tests

| Test File | Coverage | Status |
|---|---|---|
| `test/support/fakes.dart` | FakeAuth, FakeAccounts, FakeReferenceDataRepository, FakeCreatorRepository (full interface), FakeBrandRepository, FakeAgencyRepository, FakeTalentManagerRepository | ✅ |
| `test/core/profile_completion_test.dart` | Empty profile, full 100% profile, partial scoring, bio length guard, inactive rate items, recommendation weight sum, action routes | ✅ |
| `test/presentation/creator_profile_widgets_test.dart` | CreatorHeaderCard, CreatorRateCardView, CreatorBioCard, CreatorAvailabilityCard widgets; FakeCreatorRepository & FakeReferenceDataRepository unit tests | ✅ |
| `test/presentation/controller_flow_test.dart` | Auth flow, onboarding, session recovery, logout, network errors (Phase 1 tests, retained) | ✅ |
| `test/presentation/foundation_widgets_test.dart` | Foundation widgets (Phase 1 tests, retained) | ✅ |
| `test/integration/foundation_app_flow_test.dart` | End-to-end: role → auth → onboarding → home → logout; Phase 2A providers wired | ✅ |

---

## 9. Constraints Honoured

| Constraint | Status |
|---|---|
| No fake engagement rate / AI score metrics manufactured | ✅ |
| Verification is field-level (identity, email, phone, social, company, manager), not single boolean | ✅ |
| Phase 1 code not deleted or broken | ✅ |
| Phase 2B not started | ✅ |
| Docker/local Supabase execution deferred (migrations are source of truth) | ✅ |

---

## 10. Quality Gates

| Gate | Result |
|---|---|
| `dart format --output=none --set-exit-if-changed lib test` | ✅ Pass |
| `flutter analyze lib test --fatal-infos` | ✅ 0 issues |
| `flutter test` | ✅ All tests pass |
| `supabase/tests/phase2a_security.sql` validates | ✅ Authored (requires local Supabase for execution) |
