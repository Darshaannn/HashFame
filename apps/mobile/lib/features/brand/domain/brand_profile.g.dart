// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompanyBrand _$CompanyBrandFromJson(Map<String, dynamic> json) =>
    _CompanyBrand(
      id: json['id'] as String,
      organizationId: json['organization_id'] as String,
      name: json['name'] as String,
      logoPath: json['logo_path'] as String?,
      industry: json['industry'] as String?,
      website: json['website'] as String?,
      description: json['description'] as String?,
      headquarters: json['headquarters'] as String?,
      status: json['status'] as String? ?? 'active',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CompanyBrandToJson(_CompanyBrand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organization_id': instance.organizationId,
      'name': instance.name,
      'logo_path': instance.logoPath,
      'industry': instance.industry,
      'website': instance.website,
      'description': instance.description,
      'headquarters': instance.headquarters,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_BrandMarketerProfile _$BrandMarketerProfileFromJson(
  Map<String, dynamic> json,
) => _BrandMarketerProfile(
  userId: json['user_id'] as String,
  displayName: json['display_name'] as String,
  jobTitle: json['job_title'] as String?,
  workEmail: json['work_email'] as String?,
  phone: json['phone'] as String?,
  bio: json['bio'] as String?,
  organizationId: json['organization_id'] as String?,
  organizationName: json['organization_name'] as String?,
  managedBrands:
      (json['managed_brands'] as List<dynamic>?)
          ?.map((e) => CompanyBrand.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$BrandMarketerProfileToJson(
  _BrandMarketerProfile instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'display_name': instance.displayName,
  'job_title': instance.jobTitle,
  'work_email': instance.workEmail,
  'phone': instance.phone,
  'bio': instance.bio,
  'organization_id': instance.organizationId,
  'organization_name': instance.organizationName,
  'managed_brands': instance.managedBrands.map((e) => e.toJson()).toList(),
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
