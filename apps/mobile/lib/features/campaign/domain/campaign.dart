import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign.freezed.dart';
part 'campaign.g.dart';

enum CampaignStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('pending_review')
  pendingReview,
  @JsonValue('live')
  live,
  @JsonValue('paused')
  paused,
  @JsonValue('closed')
  closed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('rejected')
  rejected,
}

extension CampaignStatusExtension on CampaignStatus {
  String get wire => switch (this) {
    CampaignStatus.draft => 'draft',
    CampaignStatus.pendingReview => 'pending_review',
    CampaignStatus.live => 'live',
    CampaignStatus.paused => 'paused',
    CampaignStatus.closed => 'closed',
    CampaignStatus.cancelled => 'cancelled',
    CampaignStatus.rejected => 'rejected',
  };

  String get label => switch (this) {
    CampaignStatus.draft => 'Draft',
    CampaignStatus.pendingReview => 'Under Review',
    CampaignStatus.live => 'Live',
    CampaignStatus.paused => 'Paused',
    CampaignStatus.closed => 'Closed',
    CampaignStatus.cancelled => 'Cancelled',
    CampaignStatus.rejected => 'Changes Requested',
  };
}

enum CampaignCompensationType {
  @JsonValue('paid')
  paid,
  @JsonValue('barter')
  barter,
  @JsonValue('paid_and_barter')
  paidAndBarter,
}

extension CampaignCompensationTypeExtension on CampaignCompensationType {
  String get wire => switch (this) {
    CampaignCompensationType.paid => 'paid',
    CampaignCompensationType.barter => 'barter',
    CampaignCompensationType.paidAndBarter => 'paid_and_barter',
  };

  String get label => switch (this) {
    CampaignCompensationType.paid => 'Paid',
    CampaignCompensationType.barter => 'Barter / Product',
    CampaignCompensationType.paidAndBarter => 'Paid + Barter',
  };
}

enum CampaignDeliverableType {
  @JsonValue('instagram_reel')
  instagramReel,
  @JsonValue('instagram_story')
  instagramStory,
  @JsonValue('instagram_post')
  instagramPost,
  @JsonValue('youtube_video')
  youtubeVideo,
  @JsonValue('youtube_integration')
  youtubeIntegration,
  @JsonValue('youtube_short')
  youtubeShort,
  @JsonValue('ugc_video')
  ugcVideo,
  @JsonValue('other')
  other,
}

extension CampaignDeliverableTypeExtension on CampaignDeliverableType {
  String get wire => switch (this) {
    CampaignDeliverableType.instagramReel => 'instagram_reel',
    CampaignDeliverableType.instagramStory => 'instagram_story',
    CampaignDeliverableType.instagramPost => 'instagram_post',
    CampaignDeliverableType.youtubeVideo => 'youtube_video',
    CampaignDeliverableType.youtubeIntegration => 'youtube_integration',
    CampaignDeliverableType.youtubeShort => 'youtube_short',
    CampaignDeliverableType.ugcVideo => 'ugc_video',
    CampaignDeliverableType.other => 'other',
  };

  String get label => switch (this) {
    CampaignDeliverableType.instagramReel => 'Instagram Reel',
    CampaignDeliverableType.instagramStory => 'Instagram Story',
    CampaignDeliverableType.instagramPost => 'Instagram Post',
    CampaignDeliverableType.youtubeVideo => 'YouTube Dedicated Video',
    CampaignDeliverableType.youtubeIntegration => 'YouTube Integration',
    CampaignDeliverableType.youtubeShort => 'YouTube Short',
    CampaignDeliverableType.ugcVideo => 'UGC Video',
    CampaignDeliverableType.other => 'Other Deliverable',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class CampaignDeliverable with _$CampaignDeliverable {
  const factory CampaignDeliverable({
    required String id,
    required String campaignId,
    required CampaignDeliverableType deliverableType,
    required String platform,
    @Default(1) int quantity,
    String? description,
  }) = _CampaignDeliverable;

  factory CampaignDeliverable.fromJson(Map<String, dynamic> json) =>
      _$CampaignDeliverableFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class CampaignUsageRights with _$CampaignUsageRights {
  const factory CampaignUsageRights({
    @Default(true) bool organicRepostingAllowed,
    @Default(false) bool paidUsageRequired,
    @Default(false) bool whitelistingRequired,
    int? usageDurationMonths,
    @Default('India') String usageTerritory,
    @Default(false) bool exclusivityRequired,
    int? exclusivityDurationDays,
    @Default(true) bool contentApprovalRequired,
    @Default(true) bool disclosureRequired,
  }) = _CampaignUsageRights;

  factory CampaignUsageRights.fromJson(Map<String, dynamic> json) =>
      _$CampaignUsageRightsFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class Campaign with _$Campaign {
  const factory Campaign({
    required String id,
    required String organizationId,
    String? createdBy,
    required String title,
    String? objective,
    required String description,
    @Default(CampaignStatus.draft) CampaignStatus status,
    @Default(CampaignCompensationType.paid)
    CampaignCompensationType compensationType,
    @Default('INR') String currency,
    double? budgetMin,
    double? budgetMax,
    double? barterValue,
    String? barterDescription,
    @Default(1) int creatorSlots,
    String? targetCity,
    String? targetState,
    @Default('IN') String targetCountry,
    int? minFollowers,
    int? maxFollowers,
    @Default([]) List<String> categoryIds,
    @Default([]) List<String> categoryNames,
    @Default([]) List<String> languageCodes,
    @Default([]) List<String> languageNames,
    @Default([]) List<CampaignDeliverable> deliverables,
    @Default(CampaignUsageRights()) CampaignUsageRights usageRights,
    DateTime? applicationDeadline,
    DateTime? contentDeadline,
    DateTime? campaignStartDate,
    DateTime? campaignEndDate,
    String? additionalRequirements,
    String? rejectionReason,
    DateTime? publishedAt,
    DateTime? closedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(0) int applicantCount,
    @Default(0) int selectedCount,
    String? brandName,
    String? brandLogoUrl,
  }) = _Campaign;

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);
}
