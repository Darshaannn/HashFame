import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_profile.freezed.dart';
part 'brand_profile.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class CompanyBrand with _$CompanyBrand {
  const factory CompanyBrand({
    required String id,
    required String organizationId,
    required String name,
    String? logoPath,
    String? industry,
    String? website,
    String? description,
    String? headquarters,
    @Default('active') String status,
    DateTime? createdAt,
  }) = _CompanyBrand;

  factory CompanyBrand.fromJson(Map<String, dynamic> json) =>
      _$CompanyBrandFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class BrandMarketerProfile with _$BrandMarketerProfile {
  const factory BrandMarketerProfile({
    required String userId,
    required String displayName,
    String? jobTitle,
    String? workEmail,
    String? phone,
    String? bio,
    String? organizationId,
    String? organizationName,
    @Default([]) List<CompanyBrand> managedBrands,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BrandMarketerProfile;

  factory BrandMarketerProfile.fromJson(Map<String, dynamic> json) =>
      _$BrandMarketerProfileFromJson(json);
}
