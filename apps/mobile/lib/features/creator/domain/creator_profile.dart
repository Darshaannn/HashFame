import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ggs_mobile/features/creator/domain/collaboration.dart';
import 'package:ggs_mobile/features/creator/domain/creator_manager.dart';
import 'package:ggs_mobile/features/creator/domain/portfolio.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';
import 'package:ggs_mobile/features/creator/domain/social_account.dart';
import 'package:ggs_mobile/features/profile_common/domain/reference_data.dart';
import 'package:ggs_mobile/features/profile_common/domain/verification.dart';

part 'creator_profile.freezed.dart';
part 'creator_profile.g.dart';

enum AvailabilityStatus {
  open,
  limited,
  unavailable;

  String get label => switch (this) {
    open => 'Open to Collaborations',
    limited => 'Limited Availability',
    unavailable => 'Currently Unavailable',
  };

  String get wire => switch (this) {
    open => 'open',
    limited => 'limited',
    unavailable => 'unavailable',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class CreatorAvailability with _$CreatorAvailability {
  const factory CreatorAvailability({
    @Default(AvailabilityStatus.open) AvailabilityStatus status,
    DateTime? availableFrom,
  }) = _CreatorAvailability;

  factory CreatorAvailability.fromJson(Map<String, dynamic> json) =>
      _$CreatorAvailabilityFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class CreatorProfile with _$CreatorProfile {
  const factory CreatorProfile({
    required String userId,
    required String displayName,
    String? professionalName,
    String? avatarPath,
    String? bio,
    @Default(LocationData()) LocationData location,
    @Default(CreatorAvailability()) CreatorAvailability availability,
    @Default(false) bool isRepresented,
    @Default(1) int onboardingStep,
    @Default(false) bool onboardingCompleted,
    @Default([]) List<Category> primaryCategories,
    @Default([]) List<Category> additionalCategories,
    @Default([]) List<Language> languages,
    @Default([]) List<SocialAccount> socialAccounts,
    @Default([]) List<RateItem> rateCard,
    @Default([]) List<PortfolioItem> portfolio,
    @Default([]) List<PastCollaboration> pastCollaborations,
    @Default([]) List<CreatorManagerRelationship> managerRelationships,
    @Default(VerificationSummary()) VerificationSummary verificationSummary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CreatorProfile;

  factory CreatorProfile.fromJson(Map<String, dynamic> json) =>
      _$CreatorProfileFromJson(json);
}
