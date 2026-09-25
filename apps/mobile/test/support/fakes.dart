import 'dart:async';

import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/account/domain/account_repository.dart';
import 'package:ggs_mobile/features/agency/domain/agency_profile.dart';
import 'package:ggs_mobile/features/agency/domain/agency_repository.dart';
import 'package:ggs_mobile/features/auth/domain/auth_repository.dart';
import 'package:ggs_mobile/features/brand/domain/brand_profile.dart';
import 'package:ggs_mobile/features/brand/domain/brand_repository.dart';
import 'package:ggs_mobile/features/creator/domain/collaboration.dart';
import 'package:ggs_mobile/features/creator/domain/creator_manager.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/creator_repository.dart';
import 'package:ggs_mobile/features/creator/domain/portfolio.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';
import 'package:ggs_mobile/features/creator/domain/social_account.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_discovery_item.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_search_filters.dart';
import 'package:ggs_mobile/features/discovery/domain/discovery_repository.dart';
import 'package:ggs_mobile/features/profile_common/domain/reference_data.dart';
import 'package:ggs_mobile/features/profile_common/domain/reference_data_repository.dart';
import 'package:ggs_mobile/features/shortlist/domain/shortlist.dart';
import 'package:ggs_mobile/features/shortlist/domain/shortlist_member.dart';
import 'package:ggs_mobile/features/shortlist/domain/shortlist_repository.dart';
import 'package:ggs_mobile/features/talent_manager/domain/talent_manager_profile.dart';
import 'package:ggs_mobile/features/talent_manager/domain/talent_manager_repository.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_application.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_opportunity_item.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_repository.dart';

// ─── Sample helpers ────────────────────────────────────────────────────────────

Account sampleAccount({
  ProfessionalRole? role = ProfessionalRole.creator,
  AccountState state = AccountState.active,
}) => Account(
  id: '11111111-1111-4111-8111-111111111111',
  displayName: 'Test Creator',
  primaryRoleLabel: role,
  accountState: state,
  updatedAt: DateTime.utc(2026, 1, 1),
);

// ─── Auth ──────────────────────────────────────────────────────────────────────

class FakeAuth implements AuthRepository {
  String? id;
  Object? failure;
  int otpCalls = 0;
  int phoneOtpCalls = 0;
  Completer<void>? restoreGate;
  final changes = StreamController<SessionEvent>.broadcast();
  @override
  String? get userId => id;
  @override
  Stream<SessionEvent> get events => changes.stream;
  @override
  Future<void> restore() async {
    if (failure != null) throw failure!;
    await restoreGate?.future;
  }

  @override
  Future<void> sendOtp(String email) async {
    otpCalls++;
    if (failure != null) throw failure!;
  }

  @override
  Future<void> verifyOtp(String email, String code) async {
    if (failure != null) throw failure!;
    id = sampleAccount().id;
    changes.add(SessionEvent.signedIn);
  }

  @override
  Future<void> sendPhoneOtp(String phone) async {
    phoneOtpCalls++;
    if (failure != null) throw failure!;
  }

  @override
  Future<void> verifyPhoneOtp(String phone, String code) async {
    if (failure != null) throw failure!;
    id = sampleAccount().id;
    changes.add(SessionEvent.signedIn);
  }

  @override
  Future<void> signInSocial(SocialProvider provider) async {
    if (failure != null) throw failure!;
  }

  @override
  Future<void> logout() async {
    if (failure != null) throw failure!;
    id = null;
    changes.add(SessionEvent.signedOut);
  }
}

// ─── Accounts ─────────────────────────────────────────────────────────────────

class FakeAccounts implements AccountRepository {
  Account account = sampleAccount();
  Object? failure;
  bool offline = false;
  int cleared = 0;
  @override
  Future<AccountSnapshot> load() async {
    if (failure != null) throw failure!;
    return AccountSnapshot(
      account,
      fetchedAt: DateTime.utc(2026, 1, 1),
      offline: offline,
    );
  }

  @override
  Future<Account> completeOnboarding(ProfessionalRole role, String name) async {
    if (failure != null) throw failure!;
    return account = account.copyWith(
      displayName: name,
      primaryRoleLabel: role,
      accountState: AccountState.active,
    );
  }

  @override
  Future<Account> updateName(String name) async =>
      account = account.copyWith(displayName: name);
  @override
  Future<AccountSettings> settings() async => const AccountSettings();
  @override
  Future<void> updateSettings(AccountSettings settings) async {}
  @override
  Future<String> requestDeletion() async {
    account = account.copyWith(accountState: AccountState.deletionRequested);
    return 'receipt';
  }

  @override
  Future<void> clearCache() async {
    cleared++;
  }
}

// ─── Reference Data ────────────────────────────────────────────────────────────

class FakeReferenceDataRepository implements ReferenceDataRepository {
  List<Category> categoriesList = const [
    Category(id: 'cat-1', name: 'Tech & Gadgets', slug: 'tech'),
    Category(id: 'cat-2', name: 'Fashion & Style', slug: 'fashion'),
    Category(id: 'cat-3', name: 'Lifestyle & Vlogs', slug: 'lifestyle'),
  ];
  List<Language> languagesList = const [
    Language(code: 'en', name: 'English', nativeName: 'English'),
    Language(code: 'hi', name: 'Hindi', nativeName: 'हिन्दी'),
  ];

  @override
  Future<List<Category>> getCategories() async => categoriesList;

  @override
  Future<List<Language>> getLanguages() async => languagesList;
}

// ─── Creator ───────────────────────────────────────────────────────────────────

class FakeCreatorRepository implements CreatorRepository {
  CreatorProfile profile = const CreatorProfile(
    userId: '11111111-1111-4111-8111-111111111111',
    displayName: 'Test Creator',
  );
  bool throwError = false;

  FakeCreatorRepository({CreatorProfile? profile}) {
    if (profile != null) this.profile = profile;
  }

  @override
  Future<CreatorProfile> getProfile({String? userId}) async {
    if (throwError) throw Exception('Failed to load profile');
    return profile;
  }

  @override
  Future<CreatorProfile> updateProfile(CreatorProfile newProfile) async {
    if (throwError) throw Exception('Failed to save profile');
    profile = newProfile;
    return newProfile;
  }

  @override
  Future<CreatorProfile> updateOnboardingStep(int step, bool completed) async {
    profile = profile.copyWith(
      onboardingStep: step,
      onboardingCompleted: completed,
    );
    return profile;
  }

  @override
  Future<CreatorProfile> updateAvailability(
    CreatorAvailability availability,
  ) async {
    profile = profile.copyWith(availability: availability);
    return profile;
  }

  @override
  Future<void> setCategories({
    required List<String> categoryIds,
    String? primaryCategoryId,
  }) async {
    profile = profile.copyWith(
      primaryCategories: categoryIds
          .map((id) => Category(id: id, name: id, slug: id))
          .toList(),
    );
  }

  @override
  Future<void> setLanguages({
    required List<String> languageCodes,
    String? primaryLanguageCode,
  }) async {
    profile = profile.copyWith(
      languages: languageCodes
          .map((c) => Language(code: c, name: c, nativeName: c))
          .toList(),
    );
  }

  @override
  Future<SocialAccount> addSocialAccount(SocialAccount account) async {
    profile = profile.copyWith(
      socialAccounts: [...profile.socialAccounts, account],
    );
    return account;
  }

  @override
  Future<void> updateSocialAccount(SocialAccount account) async {
    profile = profile.copyWith(
      socialAccounts: profile.socialAccounts
          .map((s) => s.id == account.id ? account : s)
          .toList(),
    );
  }

  @override
  Future<void> deleteSocialAccount(String id) async {
    profile = profile.copyWith(
      socialAccounts: profile.socialAccounts.where((s) => s.id != id).toList(),
    );
  }

  @override
  Future<RateItem> addRateItem(RateItem item) async {
    profile = profile.copyWith(rateCard: [...profile.rateCard, item]);
    return item;
  }

  @override
  Future<void> updateRateItem(RateItem item) async {
    profile = profile.copyWith(
      rateCard: profile.rateCard
          .map((r) => r.id == item.id ? item : r)
          .toList(),
    );
  }

  @override
  Future<void> deleteRateItem(String id) async {
    profile = profile.copyWith(
      rateCard: profile.rateCard.where((r) => r.id != id).toList(),
    );
  }

  @override
  Future<PortfolioItem> addPortfolioItem(PortfolioItem item) async {
    profile = profile.copyWith(portfolio: [...profile.portfolio, item]);
    return item;
  }

  @override
  Future<void> updatePortfolioItem(PortfolioItem item) async {
    profile = profile.copyWith(
      portfolio: profile.portfolio
          .map((p) => p.id == item.id ? item : p)
          .toList(),
    );
  }

  @override
  Future<void> deletePortfolioItem(String id) async {
    profile = profile.copyWith(
      portfolio: profile.portfolio.where((p) => p.id != id).toList(),
    );
  }

  @override
  Future<PastCollaboration> addCollaboration(PastCollaboration collab) async {
    profile = profile.copyWith(
      pastCollaborations: [...profile.pastCollaborations, collab],
    );
    return collab;
  }

  @override
  Future<void> updateCollaboration(PastCollaboration collab) async {
    profile = profile.copyWith(
      pastCollaborations: profile.pastCollaborations
          .map((c) => c.id == collab.id ? collab : c)
          .toList(),
    );
  }

  @override
  Future<void> deleteCollaboration(String id) async {
    profile = profile.copyWith(
      pastCollaborations: profile.pastCollaborations
          .where((c) => c.id != id)
          .toList(),
    );
  }

  @override
  Future<List<CreatorManagerRelationship>> getManagerRelationships() async =>
      profile.managerRelationships;

  @override
  Future<void> respondToManagerRequest(
    String relationshipId,
    ManagerRelationshipStatus status,
  ) async {}
}

// ─── Brand ────────────────────────────────────────────────────────────────────

class FakeBrandRepository implements BrandRepository {
  BrandMarketerProfile profile = const BrandMarketerProfile(
    userId: '11111111-1111-4111-8111-111111111111',
    displayName: 'Test Brand',
  );

  FakeBrandRepository({BrandMarketerProfile? profile}) {
    if (profile != null) this.profile = profile;
  }

  @override
  Future<BrandMarketerProfile> getProfile({String? userId}) async => profile;

  @override
  Future<BrandMarketerProfile> updateProfile(
    BrandMarketerProfile newProfile,
  ) async {
    profile = newProfile;
    return newProfile;
  }

  @override
  Future<CompanyBrand> createBrand(CompanyBrand brand) async => brand;

  @override
  Future<void> updateBrand(CompanyBrand brand) async {}

  @override
  Future<List<CompanyBrand>> getBrands({String? organizationId}) async =>
      profile.managedBrands;
}

// ─── Agency ───────────────────────────────────────────────────────────────────

class FakeAgencyRepository implements AgencyRepository {
  AgencyProfile profile = const AgencyProfile(
    userId: '11111111-1111-4111-8111-111111111111',
    agencyName: 'Test Agency',
  );

  FakeAgencyRepository({AgencyProfile? profile}) {
    if (profile != null) this.profile = profile;
  }

  @override
  Future<AgencyProfile> getProfile({String? userId}) async => profile;

  @override
  Future<AgencyProfile> updateProfile(AgencyProfile newProfile) async {
    profile = newProfile;
    return newProfile;
  }
}

// ─── Talent Manager ───────────────────────────────────────────────────────────

class FakeTalentManagerRepository implements TalentManagerRepository {
  TalentManagerProfile profile = const TalentManagerProfile(
    userId: '11111111-1111-4111-8111-111111111111',
    displayName: 'Test Manager',
  );

  FakeTalentManagerRepository({TalentManagerProfile? profile}) {
    if (profile != null) this.profile = profile;
  }

  @override
  Future<TalentManagerProfile> getProfile({String? userId}) async => profile;

  @override
  Future<TalentManagerProfile> updateProfile(
    TalentManagerProfile newProfile,
  ) async {
    profile = newProfile;
    return newProfile;
  }
}

// ─── Discovery ────────────────────────────────────────────────────────────────

class FakeDiscoveryRepository implements DiscoveryRepository {
  List<CreatorDiscoveryItem> creators = [];

  FakeDiscoveryRepository({List<CreatorDiscoveryItem>? creators}) {
    this.creators =
        creators ??
        [
          const CreatorDiscoveryItem(
            creatorId: 'c1',
            displayName: 'Rohan Sharma',
            professionalName: 'rohan_vlogs',
            city: 'Mumbai',
            state: 'Maharashtra',
            primaryCategoryNames: ['Tech & Gadgets'],
            primaryPlatform: SocialPlatform.youtube,
            totalFollowers: 150000,
            startingRate: 25000,
            startingRateDeliverable: DeliverableType.youtubeVideo,
            availabilityStatus: AvailabilityStatus.open,
          ),
          const CreatorDiscoveryItem(
            creatorId: 'c2',
            displayName: 'Ananya Verma',
            professionalName: 'ananyafit',
            city: 'Bengaluru',
            state: 'Karnataka',
            primaryCategoryNames: ['Health & Fitness', 'Lifestyle'],
            primaryPlatform: SocialPlatform.instagram,
            totalFollowers: 85000,
            startingRate: 12000,
            startingRateDeliverable: DeliverableType.instagramReel,
            availabilityStatus: AvailabilityStatus.open,
          ),
          const CreatorDiscoveryItem(
            creatorId: 'c3',
            displayName: 'Vikram Joshi',
            professionalName: 'vikram_gaming',
            city: 'Delhi',
            state: 'Delhi',
            primaryCategoryNames: ['Gaming & Esports'],
            primaryPlatform: SocialPlatform.youtube,
            totalFollowers: 320000,
            startingRate: 40000,
            startingRateDeliverable: DeliverableType.youtubeVideo,
            availabilityStatus: AvailabilityStatus.limited,
          ),
        ];
  }

  @override
  Future<DiscoverySearchResult> searchCreators({
    required CreatorSearchFilters filters,
    int limit = 20,
    int offset = 0,
  }) async {
    var filtered = creators.where((c) {
      if (filters.query.isNotEmpty) {
        final q = filters.query.toLowerCase();
        final matchName =
            c.displayName.toLowerCase().contains(q) ||
            (c.professionalName?.toLowerCase().contains(q) ?? false);
        if (!matchName) return false;
      }
      if (filters.city != null && filters.city!.isNotEmpty) {
        if (c.city?.toLowerCase().contains(filters.city!.toLowerCase()) !=
            true) {
          return false;
        }
      }
      if (filters.availability != null &&
          c.availabilityStatus != filters.availability) {
        return false;
      }
      if (filters.minRate != null &&
          (c.startingRate == null || c.startingRate! < filters.minRate!)) {
        return false;
      }
      if (filters.maxRate != null &&
          (c.startingRate == null || c.startingRate! > filters.maxRate!)) {
        return false;
      }
      return true;
    }).toList();

    final paged = filtered.skip(offset).take(limit).toList();
    final hasMore = filtered.length > offset + limit;
    return DiscoverySearchResult(
      items: paged,
      nextOffset: hasMore ? offset + limit : null,
      hasMore: hasMore,
    );
  }

  @override
  Future<CreatorDiscoveryItem?> getCreatorDiscoveryDetail({
    required String creatorId,
  }) async {
    return creators.where((c) => c.creatorId == creatorId).firstOrNull;
  }

  @override
  Future<List<CreatorDiscoveryItem>> getCreatorsForComparison({
    required List<String> creatorIds,
  }) async {
    return creators.where((c) => creatorIds.contains(c.creatorId)).toList();
  }
}

// ─── Shortlists ───────────────────────────────────────────────────────────────

class FakeShortlistRepository implements ShortlistRepository {
  static int _shortlistSeq = 0;
  static int _memberSeq = 0;

  final List<Shortlist> shortlists = [];
  final Map<String, List<ShortlistMember>> membersByShortlist = {};

  FakeShortlistRepository({List<Shortlist>? initialLists}) {
    if (initialLists != null) {
      shortlists.addAll(initialLists);
    }
  }

  @override
  Future<List<Shortlist>> listShortlists({String? organizationId}) async {
    return shortlists.map((s) {
      final members = membersByShortlist[s.id] ?? [];
      return s.copyWith(memberCount: members.length, members: members);
    }).toList();
  }

  @override
  Future<Shortlist> getShortlist({required String shortlistId}) async {
    final list = shortlists.where((s) => s.id == shortlistId).firstOrNull;
    if (list == null) throw Exception('Shortlist not found');
    final members = membersByShortlist[shortlistId] ?? [];
    return list.copyWith(memberCount: members.length, members: members);
  }

  @override
  Future<Shortlist> createShortlist({
    required String name,
    String? description,
    String? organizationId,
  }) async {
    _shortlistSeq++;
    final list = Shortlist(
      id: 'sl_${DateTime.now().millisecondsSinceEpoch}_$_shortlistSeq',
      organizationId: organizationId ?? 'org_1',
      createdBy: 'user_1',
      name: name,
      description: description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      memberCount: 0,
    );
    shortlists.add(list);
    membersByShortlist[list.id] = [];
    return list;
  }

  @override
  Future<Shortlist> updateShortlist({
    required String shortlistId,
    String? name,
    String? description,
    bool? isArchived,
  }) async {
    final idx = shortlists.indexWhere((s) => s.id == shortlistId);
    if (idx == -1) throw Exception('Shortlist not found');
    final updated = shortlists[idx].copyWith(
      name: name ?? shortlists[idx].name,
      description: description ?? shortlists[idx].description,
      isArchived: isArchived ?? shortlists[idx].isArchived,
      updatedAt: DateTime.now(),
    );
    shortlists[idx] = updated;
    return updated;
  }

  @override
  Future<void> deleteShortlist({required String shortlistId}) async {
    shortlists.removeWhere((s) => s.id == shortlistId);
    membersByShortlist.remove(shortlistId);
  }

  @override
  Future<ShortlistMember> addCreatorToShortlist({
    required String shortlistId,
    required String creatorId,
    ShortlistMemberStatus status = ShortlistMemberStatus.potential,
    String? notes,
  }) async {
    final list = membersByShortlist.putIfAbsent(shortlistId, () => []);
    if (list.any((m) => m.creatorId == creatorId)) {
      throw Exception('Creator already in this shortlist');
    }
    _memberSeq++;
    final member = ShortlistMember(
      id: 'sm_${DateTime.now().millisecondsSinceEpoch}_$_memberSeq',
      shortlistId: shortlistId,
      creatorId: creatorId,
      addedBy: 'user_1',
      status: status,
      notes: notes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      creatorDisplayName: 'Creator $creatorId',
    );
    list.add(member);
    return member;
  }

  @override
  Future<void> removeCreatorFromShortlist({
    required String shortlistId,
    required String creatorId,
  }) async {
    membersByShortlist[shortlistId]?.removeWhere(
      (m) => m.creatorId == creatorId,
    );
  }

  @override
  Future<void> updateMemberStatus({
    required String memberId,
    required ShortlistMemberStatus status,
  }) async {
    for (final members in membersByShortlist.values) {
      final idx = members.indexWhere((m) => m.id == memberId);
      if (idx != -1) {
        members[idx] = members[idx].copyWith(
          status: status,
          updatedAt: DateTime.now(),
        );
        break;
      }
    }
  }

  @override
  Future<void> updateMemberNotes({
    required String memberId,
    required String notes,
  }) async {
    for (final members in membersByShortlist.values) {
      final idx = members.indexWhere((m) => m.id == memberId);
      if (idx != -1) {
        members[idx] = members[idx].copyWith(
          notes: notes,
          updatedAt: DateTime.now(),
        );
        break;
      }
    }
  }

  @override
  Future<Set<String>> getCreatorShortlistMemberships({
    required String creatorId,
    String? organizationId,
  }) async {
    final set = <String>{};
    for (final entry in membersByShortlist.entries) {
      if (entry.value.any((m) => m.creatorId == creatorId)) {
        set.add(entry.key);
      }
    }
    return set;
  }

  @override
  Future<Map<String, List<String>>> getSavedCreatorMemberships({
    String? organizationId,
  }) async {
    final map = <String, List<String>>{};
    for (final entry in membersByShortlist.entries) {
      for (final m in entry.value) {
        map.putIfAbsent(m.creatorId, () => []).add(entry.key);
      }
    }
    return map;
  }
}

// ─── Campaigns (Phase 2C) ──────────────────────────────────────────────────

class FakeCampaignRepository implements CampaignRepository {
  final Map<String, Campaign> campaigns = {};
  final Map<String, List<CampaignDeliverable>> deliverables = {};
  final Map<String, CampaignApplication> applications = {};
  final Map<String, List<CampaignApplicationStatusHistory>> statusHistories =
      {};
  int _counter = 0;

  @override
  Future<Campaign> createDraft({
    required String organizationId,
    required String title,
    required String description,
    String? objective,
    CampaignCompensationType compensationType = CampaignCompensationType.paid,
    String currency = 'INR',
    double? budgetMin,
    double? budgetMax,
    double? barterValue,
    String? barterDescription,
    int creatorSlots = 1,
    String? targetCity,
    String? targetState,
    String targetCountry = 'IN',
    int? minFollowers,
    int? maxFollowers,
    List<String> categoryIds = const [],
    List<String> languageCodes = const [],
    List<CampaignDeliverable> deliverables = const [],
    CampaignUsageRights usageRights = const CampaignUsageRights(),
    DateTime? applicationDeadline,
    DateTime? contentDeadline,
    DateTime? campaignStartDate,
    DateTime? campaignEndDate,
    String? additionalRequirements,
  }) async {
    _counter++;
    final id = 'camp_$_counter';
    final now = DateTime.now();
    final saved = Campaign(
      id: id,
      organizationId: organizationId,
      title: title,
      description: description,
      objective: objective,
      status: CampaignStatus.draft,
      compensationType: compensationType,
      currency: currency,
      budgetMin: budgetMin,
      budgetMax: budgetMax,
      barterValue: barterValue,
      barterDescription: barterDescription,
      creatorSlots: creatorSlots,
      targetCity: targetCity,
      targetState: targetState,
      targetCountry: targetCountry,
      minFollowers: minFollowers,
      maxFollowers: maxFollowers,
      categoryIds: categoryIds,
      categoryNames: categoryIds,
      languageCodes: languageCodes,
      languageNames: languageCodes,
      deliverables: deliverables,
      usageRights: usageRights,
      applicationDeadline: applicationDeadline,
      contentDeadline: contentDeadline,
      campaignStartDate: campaignStartDate,
      campaignEndDate: campaignEndDate,
      additionalRequirements: additionalRequirements,
      createdAt: now,
      updatedAt: now,
    );
    campaigns[id] = saved;
    this.deliverables[id] = List.from(deliverables);
    return saved;
  }

  @override
  Future<Campaign> updateDraft({
    required String campaignId,
    String? title,
    String? description,
    String? objective,
    CampaignCompensationType? compensationType,
    String? currency,
    double? budgetMin,
    double? budgetMax,
    double? barterValue,
    String? barterDescription,
    int? creatorSlots,
    String? targetCity,
    String? targetState,
    String? targetCountry,
    int? minFollowers,
    int? maxFollowers,
    List<String>? categoryIds,
    List<String>? languageCodes,
    List<CampaignDeliverable>? deliverables,
    CampaignUsageRights? usageRights,
    DateTime? applicationDeadline,
    DateTime? contentDeadline,
    DateTime? campaignStartDate,
    DateTime? campaignEndDate,
    String? additionalRequirements,
  }) async {
    final existing = campaigns[campaignId];
    if (existing == null) throw Exception('Campaign not found');
    if (existing.status != CampaignStatus.draft &&
        existing.status != CampaignStatus.rejected) {
      throw Exception('Only draft or rejected campaigns can be edited');
    }
    final updated = existing.copyWith(
      title: title ?? existing.title,
      description: description ?? existing.description,
      objective: objective ?? existing.objective,
      compensationType: compensationType ?? existing.compensationType,
      currency: currency ?? existing.currency,
      budgetMin: budgetMin ?? existing.budgetMin,
      budgetMax: budgetMax ?? existing.budgetMax,
      barterValue: barterValue ?? existing.barterValue,
      barterDescription: barterDescription ?? existing.barterDescription,
      creatorSlots: creatorSlots ?? existing.creatorSlots,
      targetCity: targetCity ?? existing.targetCity,
      targetState: targetState ?? existing.targetState,
      targetCountry: targetCountry ?? existing.targetCountry,
      minFollowers: minFollowers ?? existing.minFollowers,
      maxFollowers: maxFollowers ?? existing.maxFollowers,
      categoryIds: categoryIds ?? existing.categoryIds,
      categoryNames: categoryIds ?? existing.categoryNames,
      languageCodes: languageCodes ?? existing.languageCodes,
      languageNames: languageCodes ?? existing.languageNames,
      deliverables: deliverables ?? existing.deliverables,
      usageRights: usageRights ?? existing.usageRights,
      applicationDeadline: applicationDeadline ?? existing.applicationDeadline,
      contentDeadline: contentDeadline ?? existing.contentDeadline,
      campaignStartDate: campaignStartDate ?? existing.campaignStartDate,
      campaignEndDate: campaignEndDate ?? existing.campaignEndDate,
      additionalRequirements:
          additionalRequirements ?? existing.additionalRequirements,
      updatedAt: DateTime.now(),
    );
    campaigns[campaignId] = updated;
    if (deliverables != null) {
      this.deliverables[campaignId] = List.from(deliverables);
    }
    return updated;
  }

  @override
  Future<Campaign> getCampaign(String campaignId) async {
    final campaign = campaigns[campaignId];
    if (campaign == null) throw Exception('Campaign not found');
    return campaign.copyWith(deliverables: deliverables[campaignId] ?? []);
  }

  @override
  Future<List<Campaign>> listOrganizationCampaigns({
    required String organizationId,
    CampaignStatus? status,
  }) async {
    var list = campaigns.values
        .where((c) => c.organizationId == organizationId)
        .toList();
    if (status != null) {
      list = list.where((c) => c.status == status).toList();
    }
    return list
        .map((c) => c.copyWith(deliverables: deliverables[c.id] ?? []))
        .toList();
  }

  @override
  Future<CampaignOpportunitySearchResult> searchLiveCampaigns({
    required CampaignSearchFilters filters,
    int limit = 20,
    int offset = 0,
    String? creatorId,
  }) async {
    var list = campaigns.values
        .where((c) => c.status == CampaignStatus.live)
        .toList();

    if (filters.query.isNotEmpty) {
      final q = filters.query.toLowerCase();
      list = list
          .where(
            (c) =>
                c.title.toLowerCase().contains(q) ||
                c.description.toLowerCase().contains(q),
          )
          .toList();
    }
    if (filters.categoryIds.isNotEmpty) {
      list = list
          .where(
            (c) => c.categoryIds.any((id) => filters.categoryIds.contains(id)),
          )
          .toList();
    }
    if (filters.compensationType != null) {
      list = list
          .where((c) => c.compensationType == filters.compensationType)
          .toList();
    }

    final totalCount = list.length;
    final paged = list.skip(offset).take(limit).toList();
    final items = paged
        .map(
          (c) => CampaignOpportunityItem(
            campaignId: c.id,
            organizationId: c.organizationId,
            title: c.title,
            brandName: c.brandName ?? 'Test Brand',
            compensationType: c.compensationType,
            currency: c.currency,
            budgetMin: c.budgetMin,
            budgetMax: c.budgetMax,
            barterDescription: c.barterDescription,
            categoryNames: c.categoryNames,
            deliverableCount: (deliverables[c.id] ?? []).length,
            creatorSlots: c.creatorSlots,
            applicationDeadline: c.applicationDeadline,
            contentDeadline: c.contentDeadline,
            myApplicationStatus: applications.values
                .firstWhere(
                  (a) =>
                      a.campaignId == c.id &&
                      a.creatorId == creatorId &&
                      a.status != CampaignApplicationStatus.withdrawn,
                  orElse: () => CampaignApplication(
                    id: '',
                    campaignId: '',
                    creatorId: '',
                    pitch: '',
                    createdAt: DateTime.now(),
                  ),
                )
                .status
                .wire,
          ),
        )
        .toList();

    return CampaignOpportunitySearchResult(
      items: items,
      totalCount: totalCount,
      hasMore: offset + limit < totalCount,
    );
  }

  @override
  Future<Campaign> submitForReview(String campaignId) async {
    final campaign = campaigns[campaignId];
    if (campaign == null) throw Exception('Campaign not found');
    if (campaign.status != CampaignStatus.draft) {
      throw Exception('Only draft campaigns can be submitted for review');
    }
    final updated = campaign.copyWith(
      status: CampaignStatus.pendingReview,
      updatedAt: DateTime.now(),
    );
    campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<Campaign> moderateCampaign({
    required String campaignId,
    required String action,
    String? reason,
  }) async {
    final campaign = campaigns[campaignId];
    if (campaign == null) throw Exception('Campaign not found');
    if (campaign.status != CampaignStatus.pendingReview) {
      throw Exception('Only pendingReview campaigns can be moderated');
    }
    final targetStatus = action == 'approve'
        ? CampaignStatus.live
        : CampaignStatus.rejected;
    final now = DateTime.now();
    final updated = campaign.copyWith(
      status: targetStatus,
      publishedAt: targetStatus == CampaignStatus.live
          ? now
          : campaign.publishedAt,
      rejectionReason: reason,
      updatedAt: now,
    );
    campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<Campaign> pauseCampaign(String campaignId) async {
    final campaign = campaigns[campaignId];
    if (campaign == null) throw Exception('Campaign not found');
    if (campaign.status != CampaignStatus.live) {
      throw Exception('Only live campaigns can be paused');
    }
    final updated = campaign.copyWith(
      status: CampaignStatus.paused,
      updatedAt: DateTime.now(),
    );
    campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<Campaign> resumeCampaign(String campaignId) async {
    final campaign = campaigns[campaignId];
    if (campaign == null) throw Exception('Campaign not found');
    if (campaign.status != CampaignStatus.paused) {
      throw Exception('Only paused campaigns can be resumed');
    }
    final updated = campaign.copyWith(
      status: CampaignStatus.live,
      updatedAt: DateTime.now(),
    );
    campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<Campaign> closeCampaign(String campaignId) async {
    final campaign = campaigns[campaignId];
    if (campaign == null) throw Exception('Campaign not found');
    final updated = campaign.copyWith(
      status: CampaignStatus.closed,
      closedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<void> deleteDraft(String campaignId) async {
    campaigns.remove(campaignId);
    deliverables.remove(campaignId);
  }

  @override
  Future<CampaignApplication> submitApplication({
    required String campaignId,
    required String creatorId,
    required String pitch,
    double? proposedRate,
    String currency = 'INR',
  }) async {
    final campaign = campaigns[campaignId];
    if (campaign == null) throw Exception('Campaign not found');
    if (campaign.status != CampaignStatus.live) {
      throw Exception('Campaign is not live');
    }
    if (campaign.applicationDeadline != null &&
        campaign.applicationDeadline!.isBefore(DateTime.now())) {
      throw Exception('Application deadline has passed');
    }

    final existing = applications.values.firstWhere(
      (a) =>
          a.campaignId == campaignId &&
          a.creatorId == creatorId &&
          a.status != CampaignApplicationStatus.withdrawn,
      orElse: () => CampaignApplication(
        id: '',
        campaignId: '',
        creatorId: '',
        pitch: '',
        createdAt: DateTime.now(),
      ),
    );
    if (existing.id.isNotEmpty) {
      throw Exception('You have already applied to this campaign');
    }

    _counter++;
    final appId = 'app_$_counter';
    final now = DateTime.now();
    final app = CampaignApplication(
      id: appId,
      campaignId: campaignId,
      creatorId: creatorId,
      status: CampaignApplicationStatus.submitted,
      pitch: pitch,
      proposedRate: proposedRate,
      currency: currency,
      createdAt: now,
      updatedAt: now,
      campaignTitle: campaign.title,
      brandName: campaign.brandName ?? 'Test Brand',
      creatorDisplayName: 'Creator $creatorId',
    );

    applications[appId] = app;
    statusHistories[appId] = [
      CampaignApplicationStatusHistory(
        id: 'hist_$_counter',
        applicationId: appId,
        fromStatus: null,
        toStatus: CampaignApplicationStatus.submitted,
        changedBy: creatorId,
        createdAt: now,
      ),
    ];
    return app;
  }

  @override
  Future<CampaignApplication> getApplication(String applicationId) async {
    final app = applications[applicationId];
    if (app == null) throw Exception('Application not found');
    return app.copyWith(statusHistory: statusHistories[applicationId] ?? []);
  }

  @override
  Future<List<CampaignApplication>> getCreatorApplications(
    String creatorId,
  ) async {
    return applications.values.where((a) => a.creatorId == creatorId).toList();
  }

  @override
  Future<List<CampaignApplication>> getCampaignApplicants({
    required String campaignId,
    CampaignApplicationStatus? status,
  }) async {
    var list = applications.values
        .where((a) => a.campaignId == campaignId)
        .toList();
    if (status != null) {
      list = list.where((a) => a.status == status).toList();
    }
    return list;
  }

  @override
  Future<CampaignApplication> transitionApplicationStatus({
    required String applicationId,
    required CampaignApplicationStatus newStatus,
    String? reason,
  }) async {
    final app = applications[applicationId];
    if (app == null) throw Exception('Application not found');
    final campaign = campaigns[app.campaignId];

    // Slot capacity check when selecting
    if (newStatus == CampaignApplicationStatus.selected && campaign != null) {
      final selectedCount = applications.values
          .where(
            (a) =>
                a.campaignId == app.campaignId &&
                a.status == CampaignApplicationStatus.selected,
          )
          .length;
      if (selectedCount >= campaign.creatorSlots) {
        throw Exception(
          'Campaign creator slot capacity reached (${campaign.creatorSlots})',
        );
      }
    }

    final oldStatus = app.status;
    final now = DateTime.now();
    final updated = app.copyWith(
      status: newStatus,
      reviewedAt: now,
      updatedAt: now,
    );
    applications[applicationId] = updated;

    _counter++;
    statusHistories
        .putIfAbsent(applicationId, () => [])
        .add(
          CampaignApplicationStatusHistory(
            id: 'hist_$_counter',
            applicationId: applicationId,
            fromStatus: oldStatus,
            toStatus: newStatus,
            changedBy: 'brand_reviewer',
            reason: reason,
            createdAt: now,
          ),
        );
    return updated;
  }

  @override
  Future<CampaignApplication> withdrawApplication(String applicationId) async {
    final app = applications[applicationId];
    if (app == null) throw Exception('Application not found');
    if (app.status == CampaignApplicationStatus.selected ||
        app.status == CampaignApplicationStatus.rejected) {
      throw Exception(
        'Cannot withdraw an application that has already been decided',
      );
    }

    final oldStatus = app.status;
    final now = DateTime.now();
    final updated = app.copyWith(
      status: CampaignApplicationStatus.withdrawn,
      withdrawnAt: now,
      updatedAt: now,
    );
    applications[applicationId] = updated;

    _counter++;
    statusHistories
        .putIfAbsent(applicationId, () => [])
        .add(
          CampaignApplicationStatusHistory(
            id: 'hist_$_counter',
            applicationId: applicationId,
            fromStatus: oldStatus,
            toStatus: CampaignApplicationStatus.withdrawn,
            changedBy: app.creatorId,
            createdAt: now,
          ),
        );
    return updated;
  }

  Future<List<CampaignApplicationStatusHistory>> getApplicationHistory(
    String applicationId,
  ) async {
    return statusHistories[applicationId] ?? [];
  }
}
