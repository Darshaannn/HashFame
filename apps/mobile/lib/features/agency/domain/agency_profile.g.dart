// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AgencyProfile _$AgencyProfileFromJson(Map<String, dynamic> json) =>
    _AgencyProfile(
      userId: json['user_id'] as String,
      agencyName: json['agency_name'] as String,
      website: json['website'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      services:
          (json['services'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      organizationId: json['organization_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AgencyProfileToJson(_AgencyProfile instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'agency_name': instance.agencyName,
      'website': instance.website,
      'description': instance.description,
      'location': instance.location,
      'services': instance.services,
      'organization_id': instance.organizationId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
