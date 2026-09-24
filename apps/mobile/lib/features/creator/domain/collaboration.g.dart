// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collaboration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PastCollaboration _$PastCollaborationFromJson(Map<String, dynamic> json) =>
    _PastCollaboration(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      brandName: json['brand_name'] as String,
      campaignName: json['campaign_name'] as String?,
      collaborationYear: (json['collaboration_year'] as num?)?.toInt(),
      deliverableType:
          $enumDecodeNullable(
            _$DeliverableTypeEnumMap,
            json['deliverable_type'],
          ) ??
          DeliverableType.instagramReel,
      proofUrl: json['proof_url'] as String?,
      proofType:
          $enumDecodeNullable(
            _$CollaborationProofTypeEnumMap,
            json['proof_type'],
          ) ??
          CollaborationProofType.selfReported,
    );

Map<String, dynamic> _$PastCollaborationToJson(_PastCollaboration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'brand_name': instance.brandName,
      'campaign_name': instance.campaignName,
      'collaboration_year': instance.collaborationYear,
      'deliverable_type': _$DeliverableTypeEnumMap[instance.deliverableType]!,
      'proof_url': instance.proofUrl,
      'proof_type': _$CollaborationProofTypeEnumMap[instance.proofType]!,
    };

const _$DeliverableTypeEnumMap = {
  DeliverableType.instagramReel: 'instagram_reel',
  DeliverableType.instagramStory: 'instagram_story',
  DeliverableType.instagramPost: 'instagram_post',
  DeliverableType.youtubeVideo: 'youtube_video',
  DeliverableType.youtubeIntegration: 'youtube_integration',
  DeliverableType.youtubeShort: 'youtube_short',
  DeliverableType.ugcVideo: 'ugc_video',
  DeliverableType.other: 'other',
};

const _$CollaborationProofTypeEnumMap = {
  CollaborationProofType.selfReported: 'self_reported',
  CollaborationProofType.platformObserved: 'platform_observed',
  CollaborationProofType.ggsVerified: 'ggs_verified',
};
