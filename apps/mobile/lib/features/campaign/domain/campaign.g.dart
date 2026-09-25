// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CampaignDeliverable _$CampaignDeliverableFromJson(Map<String, dynamic> json) =>
    _CampaignDeliverable(
      id: json['id'] as String,
      campaignId: json['campaign_id'] as String,
      deliverableType: $enumDecode(
        _$CampaignDeliverableTypeEnumMap,
        json['deliverable_type'],
      ),
      platform: json['platform'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CampaignDeliverableToJson(
  _CampaignDeliverable instance,
) => <String, dynamic>{
  'id': instance.id,
  'campaign_id': instance.campaignId,
  'deliverable_type':
      _$CampaignDeliverableTypeEnumMap[instance.deliverableType]!,
  'platform': instance.platform,
  'quantity': instance.quantity,
  'description': instance.description,
};

const _$CampaignDeliverableTypeEnumMap = {
  CampaignDeliverableType.instagramReel: 'instagram_reel',
  CampaignDeliverableType.instagramStory: 'instagram_story',
  CampaignDeliverableType.instagramPost: 'instagram_post',
  CampaignDeliverableType.youtubeVideo: 'youtube_video',
  CampaignDeliverableType.youtubeIntegration: 'youtube_integration',
  CampaignDeliverableType.youtubeShort: 'youtube_short',
  CampaignDeliverableType.ugcVideo: 'ugc_video',
  CampaignDeliverableType.other: 'other',
};

_CampaignUsageRights _$CampaignUsageRightsFromJson(
  Map<String, dynamic> json,
) => _CampaignUsageRights(
  organicRepostingAllowed: json['organic_reposting_allowed'] as bool? ?? true,
  paidUsageRequired: json['paid_usage_required'] as bool? ?? false,
  whitelistingRequired: json['whitelisting_required'] as bool? ?? false,
  usageDurationMonths: (json['usage_duration_months'] as num?)?.toInt(),
  usageTerritory: json['usage_territory'] as String? ?? 'India',
  exclusivityRequired: json['exclusivity_required'] as bool? ?? false,
  exclusivityDurationDays: (json['exclusivity_duration_days'] as num?)?.toInt(),
  contentApprovalRequired: json['content_approval_required'] as bool? ?? true,
  disclosureRequired: json['disclosure_required'] as bool? ?? true,
);

Map<String, dynamic> _$CampaignUsageRightsToJson(
  _CampaignUsageRights instance,
) => <String, dynamic>{
  'organic_reposting_allowed': instance.organicRepostingAllowed,
  'paid_usage_required': instance.paidUsageRequired,
  'whitelisting_required': instance.whitelistingRequired,
  'usage_duration_months': instance.usageDurationMonths,
  'usage_territory': instance.usageTerritory,
  'exclusivity_required': instance.exclusivityRequired,
  'exclusivity_duration_days': instance.exclusivityDurationDays,
  'content_approval_required': instance.contentApprovalRequired,
  'disclosure_required': instance.disclosureRequired,
};

_Campaign _$CampaignFromJson(Map<String, dynamic> json) => _Campaign(
  id: json['id'] as String,
  organizationId: json['organization_id'] as String,
  createdBy: json['created_by'] as String?,
  title: json['title'] as String,
  objective: json['objective'] as String?,
  description: json['description'] as String,
  status:
      $enumDecodeNullable(_$CampaignStatusEnumMap, json['status']) ??
      CampaignStatus.draft,
  compensationType:
      $enumDecodeNullable(
        _$CampaignCompensationTypeEnumMap,
        json['compensation_type'],
      ) ??
      CampaignCompensationType.paid,
  currency: json['currency'] as String? ?? 'INR',
  budgetMin: (json['budget_min'] as num?)?.toDouble(),
  budgetMax: (json['budget_max'] as num?)?.toDouble(),
  barterValue: (json['barter_value'] as num?)?.toDouble(),
  barterDescription: json['barter_description'] as String?,
  creatorSlots: (json['creator_slots'] as num?)?.toInt() ?? 1,
  targetCity: json['target_city'] as String?,
  targetState: json['target_state'] as String?,
  targetCountry: json['target_country'] as String? ?? 'IN',
  minFollowers: (json['min_followers'] as num?)?.toInt(),
  maxFollowers: (json['max_followers'] as num?)?.toInt(),
  categoryIds:
      (json['category_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  categoryNames:
      (json['category_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  languageCodes:
      (json['language_codes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  languageNames:
      (json['language_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  deliverables:
      (json['deliverables'] as List<dynamic>?)
          ?.map((e) => CampaignDeliverable.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  usageRights: json['usage_rights'] == null
      ? const CampaignUsageRights()
      : CampaignUsageRights.fromJson(
          json['usage_rights'] as Map<String, dynamic>,
        ),
  applicationDeadline: json['application_deadline'] == null
      ? null
      : DateTime.parse(json['application_deadline'] as String),
  contentDeadline: json['content_deadline'] == null
      ? null
      : DateTime.parse(json['content_deadline'] as String),
  campaignStartDate: json['campaign_start_date'] == null
      ? null
      : DateTime.parse(json['campaign_start_date'] as String),
  campaignEndDate: json['campaign_end_date'] == null
      ? null
      : DateTime.parse(json['campaign_end_date'] as String),
  additionalRequirements: json['additional_requirements'] as String?,
  rejectionReason: json['rejection_reason'] as String?,
  publishedAt: json['published_at'] == null
      ? null
      : DateTime.parse(json['published_at'] as String),
  closedAt: json['closed_at'] == null
      ? null
      : DateTime.parse(json['closed_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  applicantCount: (json['applicant_count'] as num?)?.toInt() ?? 0,
  selectedCount: (json['selected_count'] as num?)?.toInt() ?? 0,
  brandName: json['brand_name'] as String?,
  brandLogoUrl: json['brand_logo_url'] as String?,
);

Map<String, dynamic> _$CampaignToJson(_Campaign instance) => <String, dynamic>{
  'id': instance.id,
  'organization_id': instance.organizationId,
  'created_by': instance.createdBy,
  'title': instance.title,
  'objective': instance.objective,
  'description': instance.description,
  'status': _$CampaignStatusEnumMap[instance.status]!,
  'compensation_type':
      _$CampaignCompensationTypeEnumMap[instance.compensationType]!,
  'currency': instance.currency,
  'budget_min': instance.budgetMin,
  'budget_max': instance.budgetMax,
  'barter_value': instance.barterValue,
  'barter_description': instance.barterDescription,
  'creator_slots': instance.creatorSlots,
  'target_city': instance.targetCity,
  'target_state': instance.targetState,
  'target_country': instance.targetCountry,
  'min_followers': instance.minFollowers,
  'max_followers': instance.maxFollowers,
  'category_ids': instance.categoryIds,
  'category_names': instance.categoryNames,
  'language_codes': instance.languageCodes,
  'language_names': instance.languageNames,
  'deliverables': instance.deliverables.map((e) => e.toJson()).toList(),
  'usage_rights': instance.usageRights.toJson(),
  'application_deadline': instance.applicationDeadline?.toIso8601String(),
  'content_deadline': instance.contentDeadline?.toIso8601String(),
  'campaign_start_date': instance.campaignStartDate?.toIso8601String(),
  'campaign_end_date': instance.campaignEndDate?.toIso8601String(),
  'additional_requirements': instance.additionalRequirements,
  'rejection_reason': instance.rejectionReason,
  'published_at': instance.publishedAt?.toIso8601String(),
  'closed_at': instance.closedAt?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'applicant_count': instance.applicantCount,
  'selected_count': instance.selectedCount,
  'brand_name': instance.brandName,
  'brand_logo_url': instance.brandLogoUrl,
};

const _$CampaignStatusEnumMap = {
  CampaignStatus.draft: 'draft',
  CampaignStatus.pendingReview: 'pending_review',
  CampaignStatus.live: 'live',
  CampaignStatus.paused: 'paused',
  CampaignStatus.closed: 'closed',
  CampaignStatus.cancelled: 'cancelled',
  CampaignStatus.rejected: 'rejected',
};

const _$CampaignCompensationTypeEnumMap = {
  CampaignCompensationType.paid: 'paid',
  CampaignCompensationType.barter: 'barter',
  CampaignCompensationType.paidAndBarter: 'paid_and_barter',
};
