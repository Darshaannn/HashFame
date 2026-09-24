import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_profile.freezed.dart';
part 'agency_profile.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class AgencyProfile with _$AgencyProfile {
  const factory AgencyProfile({
    required String userId,
    required String agencyName,
    String? website,
    String? description,
    String? location,
    @Default([]) List<String> services,
    String? organizationId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AgencyProfile;

  factory AgencyProfile.fromJson(Map<String, dynamic> json) =>
      _$AgencyProfileFromJson(json);
}
