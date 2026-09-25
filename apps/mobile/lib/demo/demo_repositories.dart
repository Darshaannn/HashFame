import 'dart:async';

import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/account/domain/account_repository.dart';
import 'package:ggs_mobile/features/agency/domain/agency_profile.dart';
import 'package:ggs_mobile/features/agency/domain/agency_repository.dart';
import 'package:ggs_mobile/features/auth/domain/auth_repository.dart';
import 'package:ggs_mobile/features/brand/domain/brand_profile.dart';
import 'package:ggs_mobile/features/brand/domain/brand_repository.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_application.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_opportunity_item.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_repository.dart';
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

import 'demo_store.dart';

// ─── Demo Auth Repository ───────────────────────────────────────────────────

class DemoAuthRepository implements AuthRepository {
  DemoAuthRepository(this.store);
  final DemoStore store;
  final _changes = StreamController<SessionEvent>.broadcast();

  @override
  String? get userId {
    return switch (store.currentRole) {
      ProfessionalRole.brandMarketer => store.brandAccount.id,
      ProfessionalRole.creator => store.creatorAccount.id,
      ProfessionalRole.agency => store.agencyAccount.id,
      _ => store.brandAccount.id,
    };
  }

  @override
  Stream<SessionEvent> get events => _changes.stream;

  void notifyRoleChanged() {
    _changes.add(SessionEvent.refreshed);
  }

  @override
  Future<void> restore() async {}

  @override
  Future<void> sendOtp(String email) async {}

  @override
  Future<void> verifyOtp(String email, String code) async {
    _changes.add(SessionEvent.signedIn);
  }

  @override
  Future<void> sendPhoneOtp(String phone) async {}

  @override
  Future<void> verifyPhoneOtp(String phone, String code) async {
    _changes.add(SessionEvent.signedIn);
  }

  @override
  Future<void> signInSocial(SocialProvider provider) async {}

  @override
  Future<void> logout() async {
    _changes.add(SessionEvent.signedOut);
  }
}

// ─── Demo Account Repository ────────────────────────────────────────────────

class DemoAccountRepository implements AccountRepository {
  DemoAccountRepository(this.store);
  final DemoStore store;

  @override
  Future<AccountSnapshot> load() async {
    final account = switch (store.currentRole) {
      ProfessionalRole.brandMarketer => store.brandAccount,
      ProfessionalRole.creator => store.creatorAccount,
      ProfessionalRole.agency => store.agencyAccount,
      _ => store.brandAccount,
    };
    return AccountSnapshot(account, fetchedAt: DateTime.now(), offline: false);
  }

  @override
  Future<Account> completeOnboarding(ProfessionalRole role, String name) async {
    store.currentRole = role;
    return switch (role) {
      ProfessionalRole.brandMarketer =>
        store.brandAccount = store.brandAccount.copyWith(displayName: name),
      ProfessionalRole.creator =>
        store.creatorAccount = store.creatorAccount.copyWith(displayName: name),
      ProfessionalRole.agency =>
        store.agencyAccount = store.agencyAccount.copyWith(displayName: name),
      _ => store.brandAccount,
    };
  }

  @override
  Future<Account> updateName(String name) async {
    return store.brandAccount = store.brandAccount.copyWith(displayName: name);
  }

  @override
  Future<AccountSettings> settings() async => const AccountSettings();

  @override
  Future<void> updateSettings(AccountSettings settings) async {}

  @override
  Future<String> requestDeletion() async => 'demo-receipt';

  @override
  Future<void> clearCache() async {}
}

// ─── Demo Reference Data Repository ─────────────────────────────────────────

class DemoReferenceDataRepository implements ReferenceDataRepository {
  DemoReferenceDataRepository(this.store);
  final DemoStore store;

  @override
  Future<List<Category>> getCategories() async => store.categories;

  @override
  Future<List<Language>> getLanguages() async => store.languages;
}

// ─── Demo Creator Repository ────────────────────────────────────────────────

class DemoCreatorRepository implements CreatorRepository {
  DemoCreatorRepository(this.store);
  final DemoStore store;

  @override
  Future<CreatorProfile> getProfile({String? userId}) async {
    final targetId = userId ?? store.creatorAccount.id;
    final profile = store.creatorProfiles[targetId];
    if (profile != null) return profile;
    return CreatorProfile(userId: targetId, displayName: 'Creator Profile');
  }

  @override
  Future<CreatorProfile> updateProfile(CreatorProfile profile) async {
    store.creatorProfiles[profile.userId] = profile;
    return profile;
  }

  @override
  Future<CreatorProfile> updateOnboardingStep(int step, bool completed) async {
    final current = await getProfile();
    final updated = current.copyWith(
      onboardingStep: step,
      onboardingCompleted: completed,
    );
    store.creatorProfiles[updated.userId] = updated;
    return updated;
  }

  @override
  Future<CreatorProfile> updateAvailability(
    CreatorAvailability availability,
  ) async {
    final current = await getProfile();
    final updated = current.copyWith(availability: availability);
    store.creatorProfiles[updated.userId] = updated;
    return updated;
  }

  @override
  Future<void> setCategories({
    required List<String> categoryIds,
    String? primaryCategoryId,
  }) async {
    final current = await getProfile();
    final cats = categoryIds
        .map(
          (cid) => store.categories.firstWhere(
            (c) => c.id == cid,
            orElse: () => Category(id: cid, name: cid, slug: cid),
          ),
        )
        .toList();
    store.creatorProfiles[current.userId] = current.copyWith(
      primaryCategories: cats,
    );
  }

  @override
  Future<void> setLanguages({
    required List<String> languageCodes,
    String? primaryLanguageCode,
  }) async {
    final current = await getProfile();
    final langs = languageCodes
        .map(
          (code) => store.languages.firstWhere(
            (l) => l.code == code,
            orElse: () => Language(code: code, name: code, nativeName: code),
          ),
        )
        .toList();
    store.creatorProfiles[current.userId] = current.copyWith(languages: langs);
  }

  @override
  Future<SocialAccount> addSocialAccount(SocialAccount account) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      socialAccounts: [...current.socialAccounts, account],
    );
    return account;
  }

  @override
  Future<void> updateSocialAccount(SocialAccount account) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      socialAccounts: current.socialAccounts
          .map((s) => s.id == account.id ? account : s)
          .toList(),
    );
  }

  @override
  Future<void> deleteSocialAccount(String id) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      socialAccounts: current.socialAccounts.where((s) => s.id != id).toList(),
    );
  }

  @override
  Future<RateItem> addRateItem(RateItem item) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      rateCard: [...current.rateCard, item],
    );
    return item;
  }

  @override
  Future<void> updateRateItem(RateItem item) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      rateCard: current.rateCard
          .map((r) => r.id == item.id ? item : r)
          .toList(),
    );
  }

  @override
  Future<void> deleteRateItem(String id) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      rateCard: current.rateCard.where((r) => r.id != id).toList(),
    );
  }

  @override
  Future<PortfolioItem> addPortfolioItem(PortfolioItem item) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      portfolio: [...current.portfolio, item],
    );
    return item;
  }

  @override
  Future<void> updatePortfolioItem(PortfolioItem item) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      portfolio: current.portfolio
          .map((p) => p.id == item.id ? item : p)
          .toList(),
    );
  }

  @override
  Future<void> deletePortfolioItem(String id) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      portfolio: current.portfolio.where((p) => p.id != id).toList(),
    );
  }

  @override
  Future<PastCollaboration> addCollaboration(PastCollaboration collab) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      pastCollaborations: [...current.pastCollaborations, collab],
    );
    return collab;
  }

  @override
  Future<void> updateCollaboration(PastCollaboration collab) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      pastCollaborations: current.pastCollaborations
          .map((c) => c.id == collab.id ? collab : c)
          .toList(),
    );
  }

  @override
  Future<void> deleteCollaboration(String id) async {
    final current = await getProfile();
    store.creatorProfiles[current.userId] = current.copyWith(
      pastCollaborations: current.pastCollaborations
          .where((c) => c.id != id)
          .toList(),
    );
  }

  @override
  Future<List<CreatorManagerRelationship>> getManagerRelationships() async {
    final current = await getProfile();
    return current.managerRelationships;
  }

  @override
  Future<void> respondToManagerRequest(
    String relationshipId,
    ManagerRelationshipStatus status,
  ) async {}
}

// ─── Demo Brand Repository ──────────────────────────────────────────────────

class DemoBrandRepository implements BrandRepository {
  DemoBrandRepository(this.store);
  final DemoStore store;

  @override
  Future<BrandMarketerProfile> getProfile({String? userId}) async =>
      store.brandProfile;

  @override
  Future<BrandMarketerProfile> updateProfile(
    BrandMarketerProfile profile,
  ) async {
    store.brandProfile = profile;
    return profile;
  }

  @override
  Future<CompanyBrand> createBrand(CompanyBrand brand) async {
    store.brandProfile = store.brandProfile.copyWith(
      managedBrands: [...store.brandProfile.managedBrands, brand],
    );
    return brand;
  }

  @override
  Future<void> updateBrand(CompanyBrand brand) async {}

  @override
  Future<List<CompanyBrand>> getBrands({String? organizationId}) async =>
      store.brandProfile.managedBrands;
}

// ─── Demo Agency Repository ─────────────────────────────────────────────────

class DemoAgencyRepository implements AgencyRepository {
  DemoAgencyRepository(this.store);
  final DemoStore store;

  @override
  Future<AgencyProfile> getProfile({String? userId}) async =>
      store.agencyProfile;

  @override
  Future<AgencyProfile> updateProfile(AgencyProfile profile) async {
    store.agencyProfile = profile;
    return profile;
  }
}

// ─── Demo Talent Manager Repository ─────────────────────────────────────────

class DemoTalentManagerRepository implements TalentManagerRepository {
  DemoTalentManagerRepository(this.store);
  final DemoStore store;

  @override
  Future<TalentManagerProfile> getProfile({String? userId}) async =>
      const TalentManagerProfile(
        userId: 'demo_talent_manager',
        displayName: 'Vikram Talent Lead',
        companyName: 'Apex Creators India',
      );

  @override
  Future<TalentManagerProfile> updateProfile(
    TalentManagerProfile profile,
  ) async => profile;
}

// ─── Demo Discovery Repository ──────────────────────────────────────────────

class DemoDiscoveryRepository implements DiscoveryRepository {
  DemoDiscoveryRepository(this.store);
  final DemoStore store;

  @override
  Future<DiscoverySearchResult> searchCreators({
    required CreatorSearchFilters filters,
    int limit = 20,
    int offset = 0,
  }) async {
    var filtered = store.discoveryItems.where((c) {
      if (filters.query.isNotEmpty) {
        final q = filters.query.toLowerCase();
        final matchName =
            c.displayName.toLowerCase().contains(q) ||
            (c.professionalName?.toLowerCase().contains(q) ?? false);
        final matchCategory = c.primaryCategoryNames.any(
          (cat) => cat.toLowerCase().contains(q),
        );
        final matchCity = c.city?.toLowerCase().contains(q) ?? false;
        if (!matchName && !matchCategory && !matchCity) return false;
      }

      if (filters.categoryIds.isNotEmpty) {
        final targetCatNames = filters.categoryIds
            .map(
              (cid) => store.categories
                  .firstWhere(
                    (cat) => cat.id == cid,
                    orElse: () => Category(id: cid, name: cid, slug: cid),
                  )
                  .name
                  .toLowerCase(),
            )
            .toList();
        final hasCat = c.primaryCategoryNames.any(
          (cName) => targetCatNames.any(
            (t) =>
                cName.toLowerCase().contains(t) ||
                t.contains(cName.toLowerCase()),
          ),
        );
        if (!hasCat) return false;
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

      if (filters.minFollowers != null &&
          (c.totalFollowers == null ||
              c.totalFollowers! < filters.minFollowers!)) {
        return false;
      }
      if (filters.maxFollowers != null &&
          (c.totalFollowers == null ||
              c.totalFollowers! > filters.maxFollowers!)) {
        return false;
      }

      if (filters.platforms.isNotEmpty &&
          (c.primaryPlatform == null ||
              !filters.platforms.contains(c.primaryPlatform))) {
        return false;
      }

      if (filters.isRepresented != null &&
          c.isRepresented != filters.isRepresented) {
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
    return store.discoveryItems
        .where((c) => c.creatorId == creatorId)
        .firstOrNull;
  }

  @override
  Future<List<CreatorDiscoveryItem>> getCreatorsForComparison({
    required List<String> creatorIds,
  }) async {
    return store.discoveryItems
        .where((c) => creatorIds.contains(c.creatorId))
        .toList();
  }
}

// ─── Demo Shortlist Repository ──────────────────────────────────────────────

class DemoShortlistRepository implements ShortlistRepository {
  DemoShortlistRepository(this.store);
  final DemoStore store;

  @override
  Future<List<Shortlist>> listShortlists({String? organizationId}) async {
    return store.shortlists.values.map((s) {
      final members = store.shortlistMembers[s.id] ?? [];
      return s.copyWith(memberCount: members.length, members: members);
    }).toList();
  }

  @override
  Future<Shortlist> getShortlist({required String shortlistId}) async {
    final list = store.shortlists[shortlistId];
    if (list == null) throw Exception('Shortlist not found');
    final members = store.shortlistMembers[shortlistId] ?? [];
    return list.copyWith(memberCount: members.length, members: members);
  }

  @override
  Future<Shortlist> createShortlist({
    required String name,
    String? description,
    String? organizationId,
  }) async {
    final id = 'sl_${DateTime.now().millisecondsSinceEpoch}';
    final list = Shortlist(
      id: id,
      organizationId: organizationId ?? store.brandAccount.id,
      createdBy: store.brandAccount.id,
      name: name,
      description: description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      memberCount: 0,
    );
    store.shortlists[id] = list;
    store.shortlistMembers[id] = [];
    return list;
  }

  @override
  Future<Shortlist> updateShortlist({
    required String shortlistId,
    String? name,
    String? description,
    bool? isArchived,
  }) async {
    final list = store.shortlists[shortlistId];
    if (list == null) throw Exception('Shortlist not found');
    final updated = list.copyWith(
      name: name ?? list.name,
      description: description ?? list.description,
      isArchived: isArchived ?? list.isArchived,
      updatedAt: DateTime.now(),
    );
    store.shortlists[shortlistId] = updated;
    return updated;
  }

  @override
  Future<void> deleteShortlist({required String shortlistId}) async {
    store.shortlists.remove(shortlistId);
    store.shortlistMembers.remove(shortlistId);
  }

  @override
  Future<ShortlistMember> addCreatorToShortlist({
    required String shortlistId,
    required String creatorId,
    ShortlistMemberStatus status = ShortlistMemberStatus.potential,
    String? notes,
  }) async {
    final members = store.shortlistMembers.putIfAbsent(shortlistId, () => []);
    final existingIdx = members.indexWhere((m) => m.creatorId == creatorId);
    if (existingIdx != -1) {
      final updated = members[existingIdx].copyWith(
        status: status,
        notes: notes,
        updatedAt: DateTime.now(),
      );
      members[existingIdx] = updated;
      return updated;
    }

    final creator = store.discoveryItems
        .where((c) => c.creatorId == creatorId)
        .firstOrNull;
    final member = ShortlistMember(
      id: 'sm_${DateTime.now().millisecondsSinceEpoch}',
      shortlistId: shortlistId,
      creatorId: creatorId,
      addedBy: store.brandAccount.id,
      status: status,
      notes: notes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      creatorDisplayName: creator?.displayName ?? 'Creator $creatorId',
      creatorCity: creator?.city,
      creatorPrimaryCategory: creator?.primaryCategoryNames.firstOrNull,
    );
    members.add(member);

    // Update shortlist member count
    final list = store.shortlists[shortlistId];
    if (list != null) {
      store.shortlists[shortlistId] = list.copyWith(
        memberCount: members.length,
        updatedAt: DateTime.now(),
      );
    }

    return member;
  }

  @override
  Future<void> removeCreatorFromShortlist({
    required String shortlistId,
    required String creatorId,
  }) async {
    final members = store.shortlistMembers[shortlistId];
    if (members != null) {
      members.removeWhere((m) => m.creatorId == creatorId);
      final list = store.shortlists[shortlistId];
      if (list != null) {
        store.shortlists[shortlistId] = list.copyWith(
          memberCount: members.length,
          updatedAt: DateTime.now(),
        );
      }
    }
  }

  @override
  Future<void> updateMemberStatus({
    required String memberId,
    required ShortlistMemberStatus status,
  }) async {
    for (final members in store.shortlistMembers.values) {
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
    for (final members in store.shortlistMembers.values) {
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
    for (final entry in store.shortlistMembers.entries) {
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
    for (final entry in store.shortlistMembers.entries) {
      for (final m in entry.value) {
        map.putIfAbsent(m.creatorId, () => []).add(entry.key);
      }
    }
    return map;
  }
}

// ─── Demo Campaign Repository ───────────────────────────────────────────────

class DemoCampaignRepository implements CampaignRepository {
  DemoCampaignRepository(this.store);
  final DemoStore store;

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
    final id = 'camp_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();
    final catNames = categoryIds
        .map(
          (cid) => store.categories
              .firstWhere(
                (c) => c.id == cid,
                orElse: () => Category(id: cid, name: cid, slug: cid),
              )
              .name,
        )
        .toList();
    final langNames = languageCodes
        .map(
          (code) => store.languages
              .firstWhere(
                (l) => l.code == code,
                orElse: () =>
                    Language(code: code, name: code, nativeName: code),
              )
              .name,
        )
        .toList();

    final campaign = Campaign(
      id: id,
      organizationId: organizationId,
      createdBy: store.brandAccount.id,
      title: title,
      objective: objective,
      description: description,
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
      categoryNames: catNames,
      languageCodes: languageCodes,
      languageNames: langNames,
      deliverables: deliverables,
      usageRights: usageRights,
      applicationDeadline: applicationDeadline,
      contentDeadline: contentDeadline,
      campaignStartDate: campaignStartDate,
      campaignEndDate: campaignEndDate,
      additionalRequirements: additionalRequirements,
      brandName: store.brandProfile.organizationName ?? 'Nova Beauty India',
      createdAt: now,
      updatedAt: now,
    );

    store.campaigns[id] = campaign;
    return campaign;
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
    final existing = store.campaigns[campaignId];
    if (existing == null) throw Exception('Campaign not found');

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
      languageCodes: languageCodes ?? existing.languageCodes,
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

    store.campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<Campaign> getCampaign(String campaignId) async {
    final campaign = store.campaigns[campaignId];
    if (campaign == null) throw Exception('Campaign not found');

    // Count applicants
    final apps = store.applications.values
        .where((a) => a.campaignId == campaignId)
        .toList();
    final selectedCount = apps
        .where((a) => a.status == CampaignApplicationStatus.selected)
        .length;

    return campaign.copyWith(
      applicantCount: apps.length,
      selectedCount: selectedCount,
    );
  }

  @override
  Future<List<Campaign>> listOrganizationCampaigns({
    required String organizationId,
    CampaignStatus? status,
  }) async {
    return store.campaigns.values
        .where((c) {
          if (status != null && c.status != status) return false;
          return true;
        })
        .map((c) {
          final apps = store.applications.values
              .where((a) => a.campaignId == c.id)
              .toList();
          final selectedCount = apps
              .where((a) => a.status == CampaignApplicationStatus.selected)
              .length;
          return c.copyWith(
            applicantCount: apps.length,
            selectedCount: selectedCount,
          );
        })
        .toList();
  }

  @override
  Future<Campaign> submitForReview(String campaignId) async {
    final c = store.campaigns[campaignId];
    if (c == null) throw Exception('Campaign not found');
    final updated = c.copyWith(
      status: CampaignStatus.live, // In demo mode, instantly publish to live
      publishedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    store.campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<Campaign> pauseCampaign(String campaignId) async {
    final c = store.campaigns[campaignId];
    if (c == null) throw Exception('Campaign not found');
    final updated = c.copyWith(
      status: CampaignStatus.paused,
      updatedAt: DateTime.now(),
    );
    store.campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<Campaign> resumeCampaign(String campaignId) async {
    final c = store.campaigns[campaignId];
    if (c == null) throw Exception('Campaign not found');
    final updated = c.copyWith(
      status: CampaignStatus.live,
      updatedAt: DateTime.now(),
    );
    store.campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<Campaign> closeCampaign(String campaignId) async {
    final c = store.campaigns[campaignId];
    if (c == null) throw Exception('Campaign not found');
    final updated = c.copyWith(
      status: CampaignStatus.closed,
      closedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    store.campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<void> deleteDraft(String campaignId) async {
    store.campaigns.remove(campaignId);
  }

  @override
  Future<Campaign> moderateCampaign({
    required String campaignId,
    required String action,
    String? reason,
  }) async {
    final c = store.campaigns[campaignId];
    if (c == null) throw Exception('Campaign not found');
    final newStatus = action == 'approve'
        ? CampaignStatus.live
        : CampaignStatus.rejected;
    final updated = c.copyWith(
      status: newStatus,
      rejectionReason: reason,
      updatedAt: DateTime.now(),
    );
    store.campaigns[campaignId] = updated;
    return updated;
  }

  @override
  Future<CampaignOpportunitySearchResult> searchLiveCampaigns({
    required CampaignSearchFilters filters,
    int limit = 20,
    int offset = 0,
    String? creatorId,
  }) async {
    final liveCampaigns = store.campaigns.values
        .where((c) => c.status == CampaignStatus.live)
        .toList();

    final filtered = liveCampaigns.where((c) {
      if (filters.query.isNotEmpty) {
        final q = filters.query.toLowerCase();
        final matchTitle = c.title.toLowerCase().contains(q);
        final matchDesc = c.description.toLowerCase().contains(q);
        final matchBrand = c.brandName?.toLowerCase().contains(q) ?? false;
        final matchCity = c.targetCity?.toLowerCase().contains(q) ?? false;
        if (!matchTitle && !matchDesc && !matchBrand && !matchCity) {
          return false;
        }
      }

      if (filters.compensationType != null &&
          c.compensationType != filters.compensationType) {
        return false;
      }

      if (filters.city != null && filters.city!.isNotEmpty) {
        if (c.targetCity?.toLowerCase().contains(filters.city!.toLowerCase()) !=
            true) {
          return false;
        }
      }

      return true;
    }).toList();

    final items = filtered.map((c) {
      final myApp = creatorId != null
          ? store.applications.values
                .where((a) => a.campaignId == c.id && a.creatorId == creatorId)
                .firstOrNull
          : null;

      final platforms = c.deliverables.map((d) => d.platform).toSet().toList();

      return CampaignOpportunityItem(
        campaignId: c.id,
        organizationId: c.organizationId,
        title: c.title,
        brandName: c.brandName ?? 'Brand',
        brandLogoUrl: c.brandLogoUrl,
        compensationType: c.compensationType,
        currency: c.currency,
        budgetMin: c.budgetMin,
        budgetMax: c.budgetMax,
        barterValue: c.barterValue,
        barterDescription: c.barterDescription,
        creatorSlots: c.creatorSlots,
        categoryNames: c.categoryNames,
        languageNames: c.languageNames,
        platforms: platforms.isEmpty ? ['Instagram'] : platforms,
        deliverableCount: c.deliverables.length,
        targetCity: c.targetCity,
        targetState: c.targetState,
        targetCountry: c.targetCountry,
        applicationDeadline: c.applicationDeadline,
        contentDeadline: c.contentDeadline,
        publishedAt: c.publishedAt,
        myApplicationStatus: myApp?.status.wire,
        myApplicationId: myApp?.id,
      );
    }).toList();

    final paged = items.skip(offset).take(limit).toList();
    final hasMore = items.length > offset + limit;

    return CampaignOpportunitySearchResult(
      items: paged,
      totalCount: items.length,
      hasMore: hasMore,
    );
  }

  @override
  Future<CampaignApplication> submitApplication({
    required String campaignId,
    required String creatorId,
    required String pitch,
    double? proposedRate,
    String currency = 'INR',
  }) async {
    final appId = 'app_${DateTime.now().millisecondsSinceEpoch}';
    final campaign = store.campaigns[campaignId];
    final creator =
        store.creatorProfiles[creatorId] ??
        CreatorProfile(userId: creatorId, displayName: 'Aisha Mehta');

    final app = CampaignApplication(
      id: appId,
      campaignId: campaignId,
      creatorId: creatorId,
      status: CampaignApplicationStatus.submitted,
      pitch: pitch,
      proposedRate: proposedRate,
      currency: currency,
      createdAt: DateTime.now(),
      campaignTitle: campaign?.title,
      brandName: campaign?.brandName ?? 'Nova Beauty India',
      creatorDisplayName: creator.displayName,
      creatorCity: creator.location.city,
      creatorPrimaryCategories: creator.primaryCategories
          .map((c) => c.name)
          .toList(),
      statusHistory: [
        CampaignApplicationStatusHistory(
          id: 'hist_${DateTime.now().millisecondsSinceEpoch}',
          applicationId: appId,
          toStatus: CampaignApplicationStatus.submitted,
          createdAt: DateTime.now(),
          reason: 'Application submitted by creator',
        ),
      ],
    );

    store.applications[appId] = app;
    return app;
  }

  @override
  Future<List<CampaignApplication>> getCreatorApplications(
    String creatorId,
  ) async {
    return store.applications.values
        .where((a) => a.creatorId == creatorId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<CampaignApplication> getApplication(String applicationId) async {
    final app = store.applications[applicationId];
    if (app == null) throw Exception('Application not found');
    return app;
  }

  @override
  Future<List<CampaignApplication>> getCampaignApplicants({
    required String campaignId,
    CampaignApplicationStatus? status,
  }) async {
    var apps = store.applications.values
        .where((a) => a.campaignId == campaignId)
        .toList();
    if (status != null) {
      apps = apps.where((a) => a.status == status).toList();
    }
    apps.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return apps;
  }

  @override
  Future<CampaignApplication> transitionApplicationStatus({
    required String applicationId,
    required CampaignApplicationStatus newStatus,
    String? reason,
  }) async {
    final app = store.applications[applicationId];
    if (app == null) throw Exception('Application not found');

    final historyItem = CampaignApplicationStatusHistory(
      id: 'hist_${DateTime.now().millisecondsSinceEpoch}',
      applicationId: applicationId,
      fromStatus: app.status,
      toStatus: newStatus,
      createdAt: DateTime.now(),
      reason: reason ?? 'Status updated to ${newStatus.label}',
    );

    final updated = app.copyWith(
      status: newStatus,
      reviewedAt: DateTime.now(),
      updatedAt: DateTime.now(),
      statusHistory: [...app.statusHistory, historyItem],
    );

    store.applications[applicationId] = updated;

    // Update campaign selectedCount
    final campaign = store.campaigns[app.campaignId];
    if (campaign != null) {
      final allCampaignApps = store.applications.values
          .where((a) => a.campaignId == campaign.id)
          .toList();
      final selectedCount = allCampaignApps
          .where((a) => a.status == CampaignApplicationStatus.selected)
          .length;
      store.campaigns[campaign.id] = campaign.copyWith(
        selectedCount: selectedCount,
      );
    }

    return updated;
  }

  @override
  Future<CampaignApplication> withdrawApplication(String applicationId) async {
    return transitionApplicationStatus(
      applicationId: applicationId,
      newStatus: CampaignApplicationStatus.withdrawn,
      reason: 'Application withdrawn by creator',
    );
  }
}
