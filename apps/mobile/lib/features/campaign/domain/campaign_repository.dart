import 'campaign.dart';
import 'campaign_application.dart';
import 'campaign_opportunity_item.dart';

class CampaignOpportunitySearchResult {
  const CampaignOpportunitySearchResult({
    required this.items,
    required this.totalCount,
    required this.hasMore,
  });

  final List<CampaignOpportunityItem> items;
  final int totalCount;
  final bool hasMore;
}

abstract interface class CampaignRepository {
  // Brand / Agency Operations
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
  });

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
  });

  Future<Campaign> getCampaign(String campaignId);

  Future<List<Campaign>> listOrganizationCampaigns({
    required String organizationId,
    CampaignStatus? status,
  });

  Future<Campaign> submitForReview(String campaignId);

  Future<Campaign> pauseCampaign(String campaignId);

  Future<Campaign> resumeCampaign(String campaignId);

  Future<Campaign> closeCampaign(String campaignId);

  Future<void> deleteDraft(String campaignId);

  // Moderation (Protected Server/Admin Path)
  Future<Campaign> moderateCampaign({
    required String campaignId,
    required String action, // 'approve' or 'reject'
    String? reason,
  });

  // Creator Opportunity Discovery
  Future<CampaignOpportunitySearchResult> searchLiveCampaigns({
    required CampaignSearchFilters filters,
    int limit = 20,
    int offset = 0,
    String? creatorId,
  });

  // Application Lifecycle
  Future<CampaignApplication> submitApplication({
    required String campaignId,
    required String creatorId,
    required String pitch,
    double? proposedRate,
    String currency = 'INR',
  });

  Future<List<CampaignApplication>> getCreatorApplications(String creatorId);

  Future<CampaignApplication> getApplication(String applicationId);

  Future<List<CampaignApplication>> getCampaignApplicants({
    required String campaignId,
    CampaignApplicationStatus? status,
  });

  Future<CampaignApplication> transitionApplicationStatus({
    required String applicationId,
    required CampaignApplicationStatus newStatus,
    String? reason,
  });

  Future<CampaignApplication> withdrawApplication(String applicationId);
}
