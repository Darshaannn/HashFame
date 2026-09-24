// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortlist_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShortlistMember _$ShortlistMemberFromJson(Map<String, dynamic> json) =>
    _ShortlistMember(
      id: json['id'] as String,
      shortlistId: json['shortlist_id'] as String,
      creatorId: json['creator_id'] as String,
      addedBy: json['added_by'] as String,
      status:
          $enumDecodeNullable(_$ShortlistMemberStatusEnumMap, json['status']) ??
          ShortlistMemberStatus.potential,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      creatorDisplayName: json['creator_display_name'] as String?,
      creatorProfessionalName: json['creator_professional_name'] as String?,
      creatorAvatarPath: json['creator_avatar_path'] as String?,
      creatorCity: json['creator_city'] as String?,
      creatorPrimaryCategory: json['creator_primary_category'] as String?,
    );

Map<String, dynamic> _$ShortlistMemberToJson(_ShortlistMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shortlist_id': instance.shortlistId,
      'creator_id': instance.creatorId,
      'added_by': instance.addedBy,
      'status': _$ShortlistMemberStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'creator_display_name': instance.creatorDisplayName,
      'creator_professional_name': instance.creatorProfessionalName,
      'creator_avatar_path': instance.creatorAvatarPath,
      'creator_city': instance.creatorCity,
      'creator_primary_category': instance.creatorPrimaryCategory,
    };

const _$ShortlistMemberStatusEnumMap = {
  ShortlistMemberStatus.potential: 'potential',
  ShortlistMemberStatus.reviewing: 'reviewing',
  ShortlistMemberStatus.backup: 'backup',
  ShortlistMemberStatus.negotiating: 'negotiating',
  ShortlistMemberStatus.confirmed: 'confirmed',
  ShortlistMemberStatus.rejected: 'rejected',
};
