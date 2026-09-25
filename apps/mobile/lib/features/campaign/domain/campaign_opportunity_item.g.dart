// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_opportunity_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CampaignOpportunityItem _$CampaignOpportunityItemFromJson(
  Map<String, dynamic> json,
) => _CampaignOpportunityItem(
  campaignId: json['campaign_id'] as String,
  organizationId: json['organization_id'] as String,
  title: json['title'] as String,
  brandName: json['brand_name'] as String,
  brandLogoUrl: json['brand_logo_url'] as String?,
  compensationType: $enumDecode(
    _$CampaignCompensationTypeEnumMap,
    json['compensation_type'],
  ),
  currency: json['currency'] as String? ?? 'INR',
  budgetMin: (json['budget_min'] as num?)?.toDouble(),
  budgetMax: (json['budget_max'] as num?)?.toDouble(),
  barterValue: (json['barter_value'] as num?)?.toDouble(),
  barterDescription: json['barter_description'] as String?,
  creatorSlots: (json['creator_slots'] as num?)?.toInt() ?? 1,
  categoryNames:
      (json['category_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  languageNames:
      (json['language_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  platforms:
      (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  deliverableCount: (json['deliverable_count'] as num?)?.toInt() ?? 0,
  targetCity: json['target_city'] as String?,
  targetState: json['target_state'] as String?,
  targetCountry: json['target_country'] as String? ?? 'IN',
  applicationDeadline: json['application_deadline'] == null
      ? null
      : DateTime.parse(json['application_deadline'] as String),
  contentDeadline: json['content_deadline'] == null
      ? null
      : DateTime.parse(json['content_deadline'] as String),
  publishedAt: json['published_at'] == null
      ? null
      : DateTime.parse(json['published_at'] as String),
  myApplicationStatus: json['my_application_status'] as String?,
  myApplicationId: json['my_application_id'] as String?,
);

Map<String, dynamic> _$CampaignOpportunityItemToJson(
  _CampaignOpportunityItem instance,
) => <String, dynamic>{
  'campaign_id': instance.campaignId,
  'organization_id': instance.organizationId,
  'title': instance.title,
  'brand_name': instance.brandName,
  'brand_logo_url': instance.brandLogoUrl,
  'compensation_type':
      _$CampaignCompensationTypeEnumMap[instance.compensationType]!,
  'currency': instance.currency,
  'budget_min': instance.budgetMin,
  'budget_max': instance.budgetMax,
  'barter_value': instance.barterValue,
  'barter_description': instance.barterDescription,
  'creator_slots': instance.creatorSlots,
  'category_names': instance.categoryNames,
  'language_names': instance.languageNames,
  'platforms': instance.platforms,
  'deliverable_count': instance.deliverableCount,
  'target_city': instance.targetCity,
  'target_state': instance.targetState,
  'target_country': instance.targetCountry,
  'application_deadline': instance.applicationDeadline?.toIso8601String(),
  'content_deadline': instance.contentDeadline?.toIso8601String(),
  'published_at': instance.publishedAt?.toIso8601String(),
  'my_application_status': instance.myApplicationStatus,
  'my_application_id': instance.myApplicationId,
};

const _$CampaignCompensationTypeEnumMap = {
  CampaignCompensationType.paid: 'paid',
  CampaignCompensationType.barter: 'barter',
  CampaignCompensationType.paidAndBarter: 'paid_and_barter',
};

_CampaignSearchFilters _$CampaignSearchFiltersFromJson(
  Map<String, dynamic> json,
) => _CampaignSearchFilters(
  query: json['query'] as String? ?? '',
  categoryIds:
      (json['category_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  languageCodes:
      (json['language_codes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  platforms:
      (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  compensationType: $enumDecodeNullable(
    _$CampaignCompensationTypeEnumMap,
    json['compensation_type'],
  ),
  minBudget: (json['min_budget'] as num?)?.toDouble(),
  maxBudget: (json['max_budget'] as num?)?.toDouble(),
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  onlyAvailableSlots: json['only_available_slots'] as bool?,
);

Map<String, dynamic> _$CampaignSearchFiltersToJson(
  _CampaignSearchFilters instance,
) => <String, dynamic>{
  'query': instance.query,
  'category_ids': instance.categoryIds,
  'language_codes': instance.languageCodes,
  'platforms': instance.platforms,
  'compensation_type':
      _$CampaignCompensationTypeEnumMap[instance.compensationType],
  'min_budget': instance.minBudget,
  'max_budget': instance.maxBudget,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'only_available_slots': instance.onlyAvailableSlots,
};
