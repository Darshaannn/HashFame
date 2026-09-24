// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_search_filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatorSearchFilters _$CreatorSearchFiltersFromJson(
  Map<String, dynamic> json,
) => _CreatorSearchFilters(
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
  city: json['city'] as String?,
  state: json['state'] as String?,
  platforms:
      (json['platforms'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$SocialPlatformEnumMap, e))
          .toList() ??
      const [],
  minFollowers: (json['min_followers'] as num?)?.toInt(),
  maxFollowers: (json['max_followers'] as num?)?.toInt(),
  minRate: (json['min_rate'] as num?)?.toDouble(),
  maxRate: (json['max_rate'] as num?)?.toDouble(),
  availability: $enumDecodeNullable(
    _$AvailabilityStatusEnumMap,
    json['availability'],
  ),
  isRepresented: json['is_represented'] as bool?,
  verificationStatus: $enumDecodeNullable(
    _$FieldVerificationStatusEnumMap,
    json['verification_status'],
  ),
);

Map<String, dynamic> _$CreatorSearchFiltersToJson(
  _CreatorSearchFilters instance,
) => <String, dynamic>{
  'query': instance.query,
  'category_ids': instance.categoryIds,
  'language_codes': instance.languageCodes,
  'city': instance.city,
  'state': instance.state,
  'platforms': instance.platforms
      .map((e) => _$SocialPlatformEnumMap[e]!)
      .toList(),
  'min_followers': instance.minFollowers,
  'max_followers': instance.maxFollowers,
  'min_rate': instance.minRate,
  'max_rate': instance.maxRate,
  'availability': _$AvailabilityStatusEnumMap[instance.availability],
  'is_represented': instance.isRepresented,
  'verification_status':
      _$FieldVerificationStatusEnumMap[instance.verificationStatus],
};

const _$SocialPlatformEnumMap = {
  SocialPlatform.instagram: 'instagram',
  SocialPlatform.youtube: 'youtube',
  SocialPlatform.facebook: 'facebook',
  SocialPlatform.x: 'x',
  SocialPlatform.linkedin: 'linkedin',
  SocialPlatform.other: 'other',
};

const _$AvailabilityStatusEnumMap = {
  AvailabilityStatus.open: 'open',
  AvailabilityStatus.limited: 'limited',
  AvailabilityStatus.unavailable: 'unavailable',
};

const _$FieldVerificationStatusEnumMap = {
  FieldVerificationStatus.notStarted: 'not_started',
  FieldVerificationStatus.pending: 'pending',
  FieldVerificationStatus.verified: 'verified',
  FieldVerificationStatus.rejected: 'rejected',
  FieldVerificationStatus.expired: 'expired',
};
