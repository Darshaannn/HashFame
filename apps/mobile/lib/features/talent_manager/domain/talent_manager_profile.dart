import 'package:freezed_annotation/freezed_annotation.dart';

part 'talent_manager_profile.freezed.dart';
part 'talent_manager_profile.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class TalentManagerProfile with _$TalentManagerProfile {
  const factory TalentManagerProfile({
    required String userId,
    required String displayName,
    String? bio,
    String? companyName,
    String? organizationId,
    @Default(0) int representedCreatorsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TalentManagerProfile;

  factory TalentManagerProfile.fromJson(Map<String, dynamic> json) =>
      _$TalentManagerProfileFromJson(json);
}
