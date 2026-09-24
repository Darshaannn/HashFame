import 'package:freezed_annotation/freezed_annotation.dart';

import 'creator_profile.dart';

part 'profile_completion.freezed.dart';
part 'profile_completion.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class MissingRecommendation with _$MissingRecommendation {
  const factory MissingRecommendation({
    required String key,
    required String title,
    required String description,
    required int weight,
    required String actionRoute,
  }) = _MissingRecommendation;

  factory MissingRecommendation.fromJson(Map<String, dynamic> json) =>
      _$MissingRecommendationFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class ProfileCompletionReport with _$ProfileCompletionReport {
  const factory ProfileCompletionReport({
    required int percentage,
    required List<MissingRecommendation> recommendations,
    required Map<String, bool> completedFields,
  }) = _ProfileCompletionReport;

  factory ProfileCompletionReport.fromJson(Map<String, dynamic> json) =>
      _$ProfileCompletionReportFromJson(json);
}

abstract class ProfileCompletionCalculator {
  /// Explainable Profile Completion Formula for Creators
  ///
  /// Weights:
  /// - Profile Photo: 10%
  /// - Bio (>= 20 chars): 10%
  /// - Location (City/State): 10%
  /// - Categories (at least 1 category selected): 15%
  /// - Languages (at least 1 language): 10%
  /// - Social Accounts (at least 1 connected/self-reported account): 15%
  /// - Rate Card (at least 1 rate item defined): 15%
  /// - Portfolio (at least 1 item added): 10%
  /// - Availability (set or confirmed): 5%
  /// Total: 100%
  static ProfileCompletionReport calculate(CreatorProfile profile) {
    int percentage = 0;
    final completedFields = <String, bool>{};
    final recommendations = <MissingRecommendation>[];

    // 1. Profile photo (10%)
    final hasAvatar = profile.avatarPath != null && profile.avatarPath!.isNotEmpty;
    completedFields['avatar'] = hasAvatar;
    if (hasAvatar) {
      percentage += 10;
    } else {
      recommendations.add(const MissingRecommendation(
        key: 'avatar',
        title: 'Add a profile photo',
        description: 'Profiles with real photos receive significantly more partnership requests.',
        weight: 10,
        actionRoute: '/profile/edit',
      ));
    }

    // 2. Bio (10%)
    final hasBio = profile.bio != null && profile.bio!.trim().length >= 20;
    completedFields['bio'] = hasBio;
    if (hasBio) {
      percentage += 10;
    } else {
      recommendations.add(const MissingRecommendation(
        key: 'bio',
        title: 'Add your professional bio',
        description: 'Describe your niche, content style, and what brands you love working with.',
        weight: 10,
        actionRoute: '/profile/edit',
      ));
    }

    // 3. Location (10%)
    final hasLocation = profile.location.city != null && profile.location.city!.trim().isNotEmpty;
    completedFields['location'] = hasLocation;
    if (hasLocation) {
      percentage += 10;
    } else {
      recommendations.add(const MissingRecommendation(
        key: 'location',
        title: 'Specify your city & location',
        description: 'Help brands find you for localized and regional campaigns.',
        weight: 10,
        actionRoute: '/profile/edit',
      ));
    }

    // 4. Categories (15%)
    final hasCategories = profile.primaryCategories.isNotEmpty;
    completedFields['categories'] = hasCategories;
    if (hasCategories) {
      percentage += 15;
    } else {
      recommendations.add(const MissingRecommendation(
        key: 'categories',
        title: 'Select your content categories',
        description: 'Add your primary content domains (e.g., Tech, Fashion, Gaming).',
        weight: 15,
        actionRoute: '/profile/edit',
      ));
    }

    // 5. Languages (10%)
    final hasLanguages = profile.languages.isNotEmpty;
    completedFields['languages'] = hasLanguages;
    if (hasLanguages) {
      percentage += 10;
    } else {
      recommendations.add(const MissingRecommendation(
        key: 'languages',
        title: 'Add languages you create content in',
        description: 'Highlight your multi-lingual reach to marketers.',
        weight: 10,
        actionRoute: '/profile/edit',
      ));
    }

    // 6. Social Accounts (15%)
    final hasSocials = profile.socialAccounts.isNotEmpty;
    completedFields['socialAccounts'] = hasSocials;
    if (hasSocials) {
      percentage += 15;
    } else {
      recommendations.add(const MissingRecommendation(
        key: 'socialAccounts',
        title: 'Connect your social accounts',
        description: 'Add your Instagram, YouTube, or LinkedIn handles.',
        weight: 15,
        actionRoute: '/profile/edit/socials',
      ));
    }

    // 7. Rate Card (15%)
    final hasRates = profile.rateCard.where((r) => r.isActive).isNotEmpty;
    completedFields['rateCard'] = hasRates;
    if (hasRates) {
      percentage += 15;
    } else {
      recommendations.add(const MissingRecommendation(
        key: 'rateCard',
        title: 'Set up your rate card',
        description: 'List standard prices for Reels, Stories, or dedicated Videos.',
        weight: 15,
        actionRoute: '/profile/edit/rates',
      ));
    }

    // 8. Portfolio (10%)
    final hasPortfolio = profile.portfolio.isNotEmpty;
    completedFields['portfolio'] = hasPortfolio;
    if (hasPortfolio) {
      percentage += 10;
    } else {
      recommendations.add(const MissingRecommendation(
        key: 'portfolio',
        title: 'Add portfolio work',
        description: 'Showcase top-performing content, viral reels, or previous brand posts.',
        weight: 10,
        actionRoute: '/profile/edit/portfolio',
      ));
    }

    // 9. Availability (5%)
    // Availability status default is open, so if profile exists it is 5%
    completedFields['availability'] = true;
    percentage += 5;

    return ProfileCompletionReport(
      percentage: percentage.clamp(0, 100),
      recommendations: recommendations,
      completedFields: completedFields,
    );
  }
}
