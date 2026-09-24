// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatorAvailability _$CreatorAvailabilityFromJson(Map<String, dynamic> json) =>
    _CreatorAvailability(
      status:
          $enumDecodeNullable(_$AvailabilityStatusEnumMap, json['status']) ??
          AvailabilityStatus.open,
      availableFrom: json['available_from'] == null
          ? null
          : DateTime.parse(json['available_from'] as String),
    );

Map<String, dynamic> _$CreatorAvailabilityToJson(
  _CreatorAvailability instance,
) => <String, dynamic>{
  'status': _$AvailabilityStatusEnumMap[instance.status]!,
  'available_from': instance.availableFrom?.toIso8601String(),
};

const _$AvailabilityStatusEnumMap = {
  AvailabilityStatus.open: 'open',
  AvailabilityStatus.limited: 'limited',
  AvailabilityStatus.unavailable: 'unavailable',
};

_CreatorProfile _$CreatorProfileFromJson(
  Map<String, dynamic> json,
) => _CreatorProfile(
  userId: json['user_id'] as String,
  displayName: json['display_name'] as String,
  professionalName: json['professional_name'] as String?,
  avatarPath: json['avatar_path'] as String?,
  bio: json['bio'] as String?,
  location: json['location'] == null
      ? const LocationData()
      : LocationData.fromJson(json['location'] as Map<String, dynamic>),
  availability: json['availability'] == null
      ? const CreatorAvailability()
      : CreatorAvailability.fromJson(
          json['availability'] as Map<String, dynamic>,
        ),
  isRepresented: json['is_represented'] as bool? ?? false,
  onboardingStep: (json['onboarding_step'] as num?)?.toInt() ?? 1,
  onboardingCompleted: json['onboarding_completed'] as bool? ?? false,
  primaryCategories:
      (json['primary_categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  additionalCategories:
      (json['additional_categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  socialAccounts:
      (json['social_accounts'] as List<dynamic>?)
          ?.map((e) => SocialAccount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  rateCard:
      (json['rate_card'] as List<dynamic>?)
          ?.map((e) => RateItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  portfolio:
      (json['portfolio'] as List<dynamic>?)
          ?.map((e) => PortfolioItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pastCollaborations:
      (json['past_collaborations'] as List<dynamic>?)
          ?.map((e) => PastCollaboration.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  managerRelationships:
      (json['manager_relationships'] as List<dynamic>?)
          ?.map(
            (e) =>
                CreatorManagerRelationship.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  verificationSummary: json['verification_summary'] == null
      ? const VerificationSummary()
      : VerificationSummary.fromJson(
          json['verification_summary'] as Map<String, dynamic>,
        ),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$CreatorProfileToJson(
  _CreatorProfile instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'display_name': instance.displayName,
  'professional_name': instance.professionalName,
  'avatar_path': instance.avatarPath,
  'bio': instance.bio,
  'location': instance.location.toJson(),
  'availability': instance.availability.toJson(),
  'is_represented': instance.isRepresented,
  'onboarding_step': instance.onboardingStep,
  'onboarding_completed': instance.onboardingCompleted,
  'primary_categories': instance.primaryCategories
      .map((e) => e.toJson())
      .toList(),
  'additional_categories': instance.additionalCategories
      .map((e) => e.toJson())
      .toList(),
  'languages': instance.languages.map((e) => e.toJson()).toList(),
  'social_accounts': instance.socialAccounts.map((e) => e.toJson()).toList(),
  'rate_card': instance.rateCard.map((e) => e.toJson()).toList(),
  'portfolio': instance.portfolio.map((e) => e.toJson()).toList(),
  'past_collaborations': instance.pastCollaborations
      .map((e) => e.toJson())
      .toList(),
  'manager_relationships': instance.managerRelationships
      .map((e) => e.toJson())
      .toList(),
  'verification_summary': instance.verificationSummary.toJson(),
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
