// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialAccount _$SocialAccountFromJson(Map<String, dynamic> json) =>
    _SocialAccount(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      platform: $enumDecode(_$SocialPlatformEnumMap, json['platform']),
      handle: json['handle'] as String,
      profileUrl: json['profile_url'] as String?,
      userProvidedFollowerCount: (json['user_provided_follower_count'] as num?)
          ?.toInt(),
      connectionStatus:
          $enumDecodeNullable(
            _$SocialConnectionStatusEnumMap,
            json['connection_status'],
          ) ??
          SocialConnectionStatus.selfReported,
      verificationStatus:
          $enumDecodeNullable(
            _$FieldVerificationStatusEnumMap,
            json['verification_status'],
          ) ??
          FieldVerificationStatus.notStarted,
      lastVerifiedAt: json['last_verified_at'] == null
          ? null
          : DateTime.parse(json['last_verified_at'] as String),
    );

Map<String, dynamic> _$SocialAccountToJson(_SocialAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'platform': _$SocialPlatformEnumMap[instance.platform]!,
      'handle': instance.handle,
      'profile_url': instance.profileUrl,
      'user_provided_follower_count': instance.userProvidedFollowerCount,
      'connection_status':
          _$SocialConnectionStatusEnumMap[instance.connectionStatus]!,
      'verification_status':
          _$FieldVerificationStatusEnumMap[instance.verificationStatus]!,
      'last_verified_at': instance.lastVerifiedAt?.toIso8601String(),
    };

const _$SocialPlatformEnumMap = {
  SocialPlatform.instagram: 'instagram',
  SocialPlatform.youtube: 'youtube',
  SocialPlatform.facebook: 'facebook',
  SocialPlatform.x: 'x',
  SocialPlatform.linkedin: 'linkedin',
  SocialPlatform.other: 'other',
};

const _$SocialConnectionStatusEnumMap = {
  SocialConnectionStatus.selfReported: 'self_reported',
  SocialConnectionStatus.connected: 'connected',
  SocialConnectionStatus.disconnected: 'disconnected',
};

const _$FieldVerificationStatusEnumMap = {
  FieldVerificationStatus.notStarted: 'not_started',
  FieldVerificationStatus.pending: 'pending',
  FieldVerificationStatus.verified: 'verified',
  FieldVerificationStatus.rejected: 'rejected',
  FieldVerificationStatus.expired: 'expired',
};
