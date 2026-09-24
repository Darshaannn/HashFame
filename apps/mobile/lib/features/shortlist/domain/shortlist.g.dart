// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Shortlist _$ShortlistFromJson(Map<String, dynamic> json) => _Shortlist(
  id: json['id'] as String,
  organizationId: json['organization_id'] as String,
  createdBy: json['created_by'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  isArchived: json['is_archived'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  memberCount: (json['member_count'] as num?)?.toInt() ?? 0,
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => ShortlistMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ShortlistToJson(_Shortlist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organization_id': instance.organizationId,
      'created_by': instance.createdBy,
      'name': instance.name,
      'description': instance.description,
      'is_archived': instance.isArchived,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'member_count': instance.memberCount,
      'members': instance.members.map((e) => e.toJson()).toList(),
    };
