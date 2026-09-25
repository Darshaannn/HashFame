import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/telemetry/analytics_service.dart';
import '../domain/campaign.dart';
import '../domain/campaign_application.dart';
import '../domain/campaign_opportunity_item.dart';

// Brand Campaign Listing
final organizationCampaignsProvider = FutureProvider.autoDispose
    .family<List<Campaign>, String>((ref, organizationId) async {
      final repo = ref.watch(campaignRepositoryProvider);
      return repo.listOrganizationCampaigns(organizationId: organizationId);
    });

// Single Campaign Details
final campaignDetailProvider = FutureProvider.autoDispose
    .family<Campaign, String>((ref, campaignId) async {
      final repo = ref.watch(campaignRepositoryProvider);
      return repo.getCampaign(campaignId);
    });

// Campaign Applicants
final campaignApplicantsProvider = FutureProvider.autoDispose
    .family<List<CampaignApplication>, String>((ref, campaignId) async {
      final repo = ref.watch(campaignRepositoryProvider);
      return repo.getCampaignApplicants(campaignId: campaignId);
    });

// Creator Applications List
final creatorApplicationsProvider = FutureProvider.autoDispose
    .family<List<CampaignApplication>, String>((ref, creatorId) async {
      final repo = ref.watch(campaignRepositoryProvider);
      return repo.getCreatorApplications(creatorId);
    });

// Single Application Details
final applicationDetailProvider = FutureProvider.autoDispose
    .family<CampaignApplication, String>((ref, applicationId) async {
      final repo = ref.watch(campaignRepositoryProvider);
      return repo.getApplication(applicationId);
    });

// Opportunity Search Filters State
class CampaignSearchFiltersNotifier extends Notifier<CampaignSearchFilters> {
  @override
  CampaignSearchFilters build() => const CampaignSearchFilters();

  void update(CampaignSearchFilters Function(CampaignSearchFilters) cb) {
    state = cb(state);
  }

  void set(CampaignSearchFilters filters) {
    state = filters;
  }
}

final campaignFiltersProvider =
    NotifierProvider<CampaignSearchFiltersNotifier, CampaignSearchFilters>(
      CampaignSearchFiltersNotifier.new,
    );

// Creator Opportunity Discovery State & Controller
class OpportunitySearchState {
  const OpportunitySearchState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = false,
    this.nextOffset = 0,
  });

  final List<CampaignOpportunityItem> items;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int nextOffset;

  OpportunitySearchState copyWith({
    List<CampaignOpportunityItem>? items,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? nextOffset,
  }) {
    return OpportunitySearchState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      nextOffset: nextOffset ?? this.nextOffset,
    );
  }
}

final opportunitySearchControllerProvider =
    NotifierProvider<OpportunitySearchController, OpportunitySearchState>(
      OpportunitySearchController.new,
    );

class OpportunitySearchController extends Notifier<OpportunitySearchState> {
  @override
  OpportunitySearchState build() => const OpportunitySearchState();

  Future<void> search({
    required CampaignSearchFilters filters,
    String? creatorId,
    bool isRefresh = false,
  }) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = ref.read(campaignRepositoryProvider);
      final analytics = ref.read(analyticsProvider);
      final result = await repo.searchLiveCampaigns(
        filters: filters,
        limit: 20,
        offset: 0,
        creatorId: creatorId,
      );
      state = state.copyWith(
        items: result.items,
        isLoading: false,
        hasMore: result.hasMore,
        nextOffset: result.items.length,
      );
      unawaited(analytics.event(AnalyticsEvent.campaignViewed));
    } catch (e) {
      state = state.copyWith(isLoading: false, error: mapFailure(e).message);
    }
  }

  Future<void> loadMore({
    required CampaignSearchFilters filters,
    String? creatorId,
  }) async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final repo = ref.read(campaignRepositoryProvider);
      final result = await repo.searchLiveCampaigns(
        filters: filters,
        limit: 20,
        offset: state.nextOffset,
        creatorId: creatorId,
      );
      state = state.copyWith(
        items: [...state.items, ...result.items],
        isLoadingMore: false,
        hasMore: result.hasMore,
        nextOffset: state.nextOffset + result.items.length,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: mapFailure(e).message,
      );
    }
  }
}

// Campaign Action Controller (Save Draft, Submit for Review, Close, Moderate, Apply, Transition, Withdraw)
final campaignActionControllerProvider =
    NotifierProvider<CampaignActionController, AsyncValue<void>>(
      CampaignActionController.new,
    );

class CampaignActionController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<Campaign?> createDraft({
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
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      final analytics = ref.read(analyticsProvider);
      final campaign = await repo.createDraft(
        organizationId: organizationId,
        title: title,
        description: description,
        objective: objective,
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
        languageCodes: languageCodes,
        deliverables: deliverables,
        usageRights: usageRights,
        applicationDeadline: applicationDeadline,
        contentDeadline: contentDeadline,
        campaignStartDate: campaignStartDate,
        campaignEndDate: campaignEndDate,
        additionalRequirements: additionalRequirements,
      );
      unawaited(analytics.event(AnalyticsEvent.campaignDraftCreated));
      ref.invalidate(organizationCampaignsProvider(organizationId));
      state = const AsyncData(null);
      return campaign;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return null;
    }
  }

  Future<Campaign?> updateDraft({
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
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      final analytics = ref.read(analyticsProvider);
      final campaign = await repo.updateDraft(
        campaignId: campaignId,
        title: title,
        description: description,
        objective: objective,
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
        languageCodes: languageCodes,
        deliverables: deliverables,
        usageRights: usageRights,
        applicationDeadline: applicationDeadline,
        contentDeadline: contentDeadline,
        campaignStartDate: campaignStartDate,
        campaignEndDate: campaignEndDate,
        additionalRequirements: additionalRequirements,
      );
      unawaited(analytics.event(AnalyticsEvent.campaignDraftUpdated));
      ref.invalidate(campaignDetailProvider(campaignId));
      state = const AsyncData(null);
      return campaign;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return null;
    }
  }

  Future<bool> submitForReview(String campaignId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      final analytics = ref.read(analyticsProvider);
      await repo.submitForReview(campaignId);
      unawaited(analytics.event(AnalyticsEvent.campaignSubmitted));
      ref.invalidate(campaignDetailProvider(campaignId));
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return false;
    }
  }

  Future<bool> pauseCampaign(String campaignId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      await repo.pauseCampaign(campaignId);
      ref.invalidate(campaignDetailProvider(campaignId));
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return false;
    }
  }

  Future<bool> resumeCampaign(String campaignId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      await repo.resumeCampaign(campaignId);
      ref.invalidate(campaignDetailProvider(campaignId));
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return false;
    }
  }

  Future<bool> closeCampaign(String campaignId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      final analytics = ref.read(analyticsProvider);
      await repo.closeCampaign(campaignId);
      unawaited(analytics.event(AnalyticsEvent.campaignClosed));
      ref.invalidate(campaignDetailProvider(campaignId));
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return false;
    }
  }

  Future<bool> deleteDraft(String campaignId, String organizationId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      await repo.deleteDraft(campaignId);
      ref.invalidate(organizationCampaignsProvider(organizationId));
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return false;
    }
  }

  Future<bool> submitApplication({
    required String campaignId,
    required String creatorId,
    required String pitch,
    double? proposedRate,
    String currency = 'INR',
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      final analytics = ref.read(analyticsProvider);
      await repo.submitApplication(
        campaignId: campaignId,
        creatorId: creatorId,
        pitch: pitch,
        proposedRate: proposedRate,
        currency: currency,
      );
      unawaited(analytics.event(AnalyticsEvent.campaignApplicationSubmitted));
      ref.invalidate(creatorApplicationsProvider(creatorId));
      ref.invalidate(campaignDetailProvider(campaignId));
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return false;
    }
  }

  Future<bool> transitionApplicationStatus({
    required String applicationId,
    required String campaignId,
    required CampaignApplicationStatus newStatus,
    String? reason,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      final analytics = ref.read(analyticsProvider);
      await repo.transitionApplicationStatus(
        applicationId: applicationId,
        newStatus: newStatus,
        reason: reason,
      );
      unawaited(analytics.event(AnalyticsEvent.applicationStatusChanged));
      ref.invalidate(campaignApplicantsProvider(campaignId));
      ref.invalidate(applicationDetailProvider(applicationId));
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return false;
    }
  }

  Future<bool> withdrawApplication(
    String applicationId,
    String creatorId,
  ) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(campaignRepositoryProvider);
      final analytics = ref.read(analyticsProvider);
      await repo.withdrawApplication(applicationId);
      unawaited(analytics.event(AnalyticsEvent.campaignApplicationWithdrawn));
      ref.invalidate(creatorApplicationsProvider(creatorId));
      ref.invalidate(applicationDetailProvider(applicationId));
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(mapFailure(e), st);
      return false;
    }
  }
}
