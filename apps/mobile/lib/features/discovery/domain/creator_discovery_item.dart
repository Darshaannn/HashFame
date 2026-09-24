import 'package:freezed_annotation/freezed_annotation.dart';

import '../../creator/domain/creator_profile.dart';
import '../../creator/domain/rate_card.dart';
import '../../creator/domain/social_account.dart';
import '../../profile_common/domain/verification.dart';

part 'creator_discovery_item.freezed.dart';
part 'creator_discovery_item.g.dart';

@freezed
class CreatorDiscoveryItem with _$CreatorDiscoveryItem {
  const factory CreatorDiscoveryItem({
    required String creatorId,
    required String displayName,
    String? professionalName,
    String? avatarPath,
    String? city,
    String? state,
    @Default('IN') String country,
    @Default([]) List<String> primaryCategoryNames,
    @Default([]) List<String> subcategoryNames,
    @Default([]) List<String> languageNames,
    SocialPlatform? primaryPlatform,
    int? totalFollowers,
    double? startingRate,
    DeliverableType? startingRateDeliverable,
    @Default(AvailabilityStatus.open) AvailabilityStatus availabilityStatus,
    @Default(false) bool isRepresented,
    @Default(VerificationSummary()) VerificationSummary verificationSummary,
  }) = _CreatorDiscoveryItem;

  factory CreatorDiscoveryItem.fromJson(Map<String, dynamic> json) =>
      _$CreatorDiscoveryItemFromJson(json);
}
