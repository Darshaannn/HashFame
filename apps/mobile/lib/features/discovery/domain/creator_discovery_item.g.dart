// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_discovery_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatorDiscoveryItem _$CreatorDiscoveryItemFromJson(
  Map<String, dynamic> json,
) => _CreatorDiscoveryItem(
  creatorId: json['creator_id'] as String,
  displayName: json['display_name'] as String,
  professionalName: json['professional_name'] as String?,
  avatarPath: json['avatar_path'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String? ?? 'IN',
  primaryCategoryNames:
      (json['primary_category_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  subcategoryNames:
      (json['subcategory_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  languageNames:
      (json['language_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  primaryPlatform: $enumDecodeNullable(
    _$SocialPlatformEnumMap,
    json['primary_platform'],
  ),
  totalFollowers: (json['total_followers'] as num?)?.toInt(),
  startingRate: (json['starting_rate'] as num?)?.toDouble(),
  startingRateDeliverable: $enumDecodeNullable(
    _$DeliverableTypeEnumMap,
    json['starting_rate_deliverable'],
  ),
  availabilityStatus:
      $enumDecodeNullable(
        _$AvailabilityStatusEnumMap,
        json['availability_status'],
      ) ??
      AvailabilityStatus.open,
  isRepresented: json['is_represented'] as bool? ?? false,
  verificationSummary: json['verification_summary'] == null
      ? const VerificationSummary()
      : VerificationSummary.fromJson(
          json['verification_summary'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CreatorDiscoveryItemToJson(
  _CreatorDiscoveryItem instance,
) => <String, dynamic>{
  'creator_id': instance.creatorId,
  'display_name': instance.displayName,
  'professional_name': instance.professionalName,
  'avatar_path': instance.avatarPath,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'primary_category_names': instance.primaryCategoryNames,
  'subcategory_names': instance.subcategoryNames,
  'language_names': instance.languageNames,
  'primary_platform': _$SocialPlatformEnumMap[instance.primaryPlatform],
  'total_followers': instance.totalFollowers,
  'starting_rate': instance.startingRate,
  'starting_rate_deliverable':
      _$DeliverableTypeEnumMap[instance.startingRateDeliverable],
  'availability_status':
      _$AvailabilityStatusEnumMap[instance.availabilityStatus]!,
  'is_represented': instance.isRepresented,
  'verification_summary': instance.verificationSummary.toJson(),
};

const _$SocialPlatformEnumMap = {
  SocialPlatform.instagram: 'instagram',
  SocialPlatform.youtube: 'youtube',
  SocialPlatform.facebook: 'facebook',
  SocialPlatform.x: 'x',
  SocialPlatform.linkedin: 'linkedin',
  SocialPlatform.other: 'other',
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

const _$AvailabilityStatusEnumMap = {
  AvailabilityStatus.open: 'open',
  AvailabilityStatus.limited: 'limited',
  AvailabilityStatus.unavailable: 'unavailable',
};
