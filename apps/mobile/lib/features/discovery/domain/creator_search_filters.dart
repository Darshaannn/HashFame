import 'package:freezed_annotation/freezed_annotation.dart';

import '../../creator/domain/creator_profile.dart';
import '../../creator/domain/social_account.dart';
import '../../profile_common/domain/verification.dart';

part 'creator_search_filters.freezed.dart';
part 'creator_search_filters.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class CreatorSearchFilters with _$CreatorSearchFilters {
  const CreatorSearchFilters._();

  const factory CreatorSearchFilters({
    @Default('') String query,
    @Default([]) List<String> categoryIds,
    @Default([]) List<String> languageCodes,
    String? city,
    String? state,
    @Default([]) List<SocialPlatform> platforms,
    int? minFollowers,
    int? maxFollowers,
    double? minRate,
    double? maxRate,
    AvailabilityStatus? availability,
    bool? isRepresented,
    FieldVerificationStatus? verificationStatus,
  }) = _CreatorSearchFilters;

  factory CreatorSearchFilters.fromJson(Map<String, dynamic> json) =>
      _$CreatorSearchFiltersFromJson(json);

  bool get isEmpty =>
      query.isEmpty &&
      categoryIds.isEmpty &&
      languageCodes.isEmpty &&
      city == null &&
      state == null &&
      platforms.isEmpty &&
      minFollowers == null &&
      maxFollowers == null &&
      minRate == null &&
      maxRate == null &&
      availability == null &&
      isRepresented == null &&
      verificationStatus == null;

  int get activeFilterCount {
    var count = 0;
    if (categoryIds.isNotEmpty) count++;
    if (languageCodes.isNotEmpty) count++;
    if (city != null && city!.isNotEmpty) count++;
    if (state != null && state!.isNotEmpty) count++;
    if (platforms.isNotEmpty) count++;
    if (minFollowers != null || maxFollowers != null) count++;
    if (minRate != null || maxRate != null) count++;
    if (availability != null) count++;
    if (isRepresented != null) count++;
    if (verificationStatus != null) count++;
    return count;
  }
}
