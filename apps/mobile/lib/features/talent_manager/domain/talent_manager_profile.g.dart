// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_manager_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TalentManagerProfile _$TalentManagerProfileFromJson(
  Map<String, dynamic> json,
) => _TalentManagerProfile(
  userId: json['user_id'] as String,
  displayName: json['display_name'] as String,
  bio: json['bio'] as String?,
  companyName: json['company_name'] as String?,
  organizationId: json['organization_id'] as String?,
  representedCreatorsCount:
      (json['represented_creators_count'] as num?)?.toInt() ?? 0,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TalentManagerProfileToJson(
  _TalentManagerProfile instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'display_name': instance.displayName,
  'bio': instance.bio,
  'company_name': instance.companyName,
  'organization_id': instance.organizationId,
  'represented_creators_count': instance.representedCreatorsCount,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
