// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CampaignApplicationStatusHistory _$CampaignApplicationStatusHistoryFromJson(
  Map<String, dynamic> json,
) => _CampaignApplicationStatusHistory(
  id: json['id'] as String,
  applicationId: json['application_id'] as String,
  fromStatus: $enumDecodeNullable(
    _$CampaignApplicationStatusEnumMap,
    json['from_status'],
  ),
  toStatus: $enumDecode(_$CampaignApplicationStatusEnumMap, json['to_status']),
  changedBy: json['changed_by'] as String?,
  reason: json['reason'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CampaignApplicationStatusHistoryToJson(
  _CampaignApplicationStatusHistory instance,
) => <String, dynamic>{
  'id': instance.id,
  'application_id': instance.applicationId,
  'from_status': _$CampaignApplicationStatusEnumMap[instance.fromStatus],
  'to_status': _$CampaignApplicationStatusEnumMap[instance.toStatus]!,
  'changed_by': instance.changedBy,
  'reason': instance.reason,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$CampaignApplicationStatusEnumMap = {
  CampaignApplicationStatus.submitted: 'submitted',
  CampaignApplicationStatus.underReview: 'under_review',
  CampaignApplicationStatus.shortlisted: 'shortlisted',
  CampaignApplicationStatus.selected: 'selected',
  CampaignApplicationStatus.rejected: 'rejected',
  CampaignApplicationStatus.withdrawn: 'withdrawn',
};

_CampaignApplication _$CampaignApplicationFromJson(Map<String, dynamic> json) =>
    _CampaignApplication(
      id: json['id'] as String,
      campaignId: json['campaign_id'] as String,
      creatorId: json['creator_id'] as String,
      status:
          $enumDecodeNullable(
            _$CampaignApplicationStatusEnumMap,
            json['status'],
          ) ??
          CampaignApplicationStatus.submitted,
      pitch: json['pitch'] as String,
      proposedRate: (json['proposed_rate'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'INR',
      reviewedAt: json['reviewed_at'] == null
          ? null
          : DateTime.parse(json['reviewed_at'] as String),
      withdrawnAt: json['withdrawn_at'] == null
          ? null
          : DateTime.parse(json['withdrawn_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      campaignTitle: json['campaign_title'] as String?,
      brandName: json['brand_name'] as String?,
      brandLogoUrl: json['brand_logo_url'] as String?,
      creatorDisplayName: json['creator_display_name'] as String?,
      creatorAvatarPath: json['creator_avatar_path'] as String?,
      creatorCity: json['creator_city'] as String?,
      creatorFollowers: (json['creator_followers'] as num?)?.toInt(),
      creatorPrimaryCategories:
          (json['creator_primary_categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      statusHistory:
          (json['status_history'] as List<dynamic>?)
              ?.map(
                (e) => CampaignApplicationStatusHistory.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CampaignApplicationToJson(
  _CampaignApplication instance,
) => <String, dynamic>{
  'id': instance.id,
  'campaign_id': instance.campaignId,
  'creator_id': instance.creatorId,
  'status': _$CampaignApplicationStatusEnumMap[instance.status]!,
  'pitch': instance.pitch,
  'proposed_rate': instance.proposedRate,
  'currency': instance.currency,
  'reviewed_at': instance.reviewedAt?.toIso8601String(),
  'withdrawn_at': instance.withdrawnAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'campaign_title': instance.campaignTitle,
  'brand_name': instance.brandName,
  'brand_logo_url': instance.brandLogoUrl,
  'creator_display_name': instance.creatorDisplayName,
  'creator_avatar_path': instance.creatorAvatarPath,
  'creator_city': instance.creatorCity,
  'creator_followers': instance.creatorFollowers,
  'creator_primary_categories': instance.creatorPrimaryCategories,
  'status_history': instance.statusHistory.map((e) => e.toJson()).toList(),
};
