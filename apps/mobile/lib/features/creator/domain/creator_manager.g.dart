// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_manager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatorManagerRelationship _$CreatorManagerRelationshipFromJson(
  Map<String, dynamic> json,
) => _CreatorManagerRelationship(
  id: json['id'] as String,
  creatorId: json['creator_id'] as String,
  managerId: json['manager_id'] as String,
  managerName: json['manager_name'] as String?,
  managerCompany: json['manager_company'] as String?,
  status:
      $enumDecodeNullable(_$ManagerRelationshipStatusEnumMap, json['status']) ??
      ManagerRelationshipStatus.pending,
  notes: json['notes'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CreatorManagerRelationshipToJson(
  _CreatorManagerRelationship instance,
) => <String, dynamic>{
  'id': instance.id,
  'creator_id': instance.creatorId,
  'manager_id': instance.managerId,
  'manager_name': instance.managerName,
  'manager_company': instance.managerCompany,
  'status': _$ManagerRelationshipStatusEnumMap[instance.status]!,
  'notes': instance.notes,
  'created_at': instance.createdAt?.toIso8601String(),
};

const _$ManagerRelationshipStatusEnumMap = {
  ManagerRelationshipStatus.pending: 'pending',
  ManagerRelationshipStatus.accepted: 'accepted',
  ManagerRelationshipStatus.revoked: 'revoked',
};
