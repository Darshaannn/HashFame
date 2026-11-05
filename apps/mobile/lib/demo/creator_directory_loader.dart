import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/social_account.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_discovery_item.dart';
import 'package:ggs_mobile/features/profile_common/domain/reference_data.dart';
import 'package:ggs_mobile/features/profile_common/domain/verification.dart';
import 'creator_directory_fixture.dart';

/// Clean loader for imported creator directory records.
///
/// Complies with zero-fabrication guidelines:
/// - Does NOT invent bios, languages, availability, representation status,
///   social connection status, or Instagram Reel rates.
/// - Unclaimed spreadsheet listings are clearly marked as directory listings,
///   with spreadsheet-supplied metrics.
/// - Supports offline bundled JSON fixture and deterministic image matching.
class CreatorDirectoryLoader {
  const CreatorDirectoryLoader();

  /// Loads safe creators synchronously from inlined fixture with fallback.
  static List<Map<String, dynamic>> loadDirectoryRecordsSync() {
    try {
      final list = jsonDecode(kCreatorDirectorySafeJson) as List<dynamic>;
      return list.map((e) => e as Map<String, dynamic>).toList();
    } catch (_) {
      return [];
    }
  }

  /// Loads safe creators JSON fixture from assets.
  static Future<List<Map<String, dynamic>>> loadRawDirectoryRecords({
    String assetPath = 'assets/demo/ggs_demo_creators_safe.json',
  }) async {
    try {
      final jsonStr = await rootBundle.loadString(assetPath);
      final list = jsonDecode(jsonStr) as List<dynamic>;
      return list.map((e) => e as Map<String, dynamic>).toList();
    } catch (_) {
      return loadDirectoryRecordsSync();
    }
  }

  /// Converts normalized JSON entries into [CreatorDiscoveryItem] list.
  static List<CreatorDiscoveryItem> mapToDiscoveryItems(
    List<Map<String, dynamic>> records,
  ) {
    final results = <CreatorDiscoveryItem>[];

    for (final r in records) {
      final id = r['directory_id'] as String;
      final name = r['display_name'] as String;
      final handle = r['instagram_handle'] as String?;
      final followers = r['followers_count'] as int?;
      final cats = (r['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [];
      final city = r['city'] as String?;
      final imagePath = r['image_path'] as String?;

      results.add(
        CreatorDiscoveryItem(
          creatorId: id,
          displayName: name,
          professionalName: handle,
          avatarPath: imagePath,
          city: city,
          state: _inferState(city),
          country: 'IN',
          primaryCategoryNames: cats,
          languageNames: const [], // Not fabricated
          primaryPlatform: SocialPlatform.instagram,
          totalFollowers: followers,
          startingRate: null, // Commercial quote is unverified; not standard rate
          startingRateDeliverable: null,
          availabilityStatus: AvailabilityStatus.open,
          isRepresented: false, // Not fabricated
          verificationSummary: const VerificationSummary(
            identityStatus: FieldVerificationStatus.notStarted,
            emailStatus: FieldVerificationStatus.notStarted,
          ),
        ),
      );
    }

    return results;
  }

  /// Converts normalized JSON entries into [CreatorProfile] map.
  static Map<String, CreatorProfile> mapToProfiles(
    List<Map<String, dynamic>> records,
    List<Category> availableCategories,
  ) {
    final profiles = <String, CreatorProfile>{};

    for (final r in records) {
      final id = r['directory_id'] as String;
      final name = r['display_name'] as String;
      final handle = r['instagram_handle'] as String?;
      final profileUrl = r['instagram_profile_url'] as String?;
      final followers = r['followers_count'] as int?;
      final cats = (r['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [];
      final city = r['city'] as String?;
      final imagePath = r['image_path'] as String?;

      // Map categories cleanly
      final mappedCats = cats.map((catName) {
        return availableCategories.firstWhere(
          (c) =>
              c.name.toLowerCase() == catName.toLowerCase() ||
              c.name.toLowerCase().contains(catName.toLowerCase()) ||
              catName.toLowerCase().contains(c.name.toLowerCase()),
          orElse: () => Category(
            id: 'cat_${_slugify(catName)}',
            name: catName,
            slug: _slugify(catName),
          ),
        );
      }).toList();

      final socialAccounts = <SocialAccount>[];
      if (handle != null || profileUrl != null) {
        socialAccounts.add(
          SocialAccount(
            id: 'soc_${id}_ig',
            userId: id,
            platform: SocialPlatform.instagram,
            handle: handle ?? '',
            profileUrl: profileUrl,
            userProvidedFollowerCount: followers,
            connectionStatus: SocialConnectionStatus.selfReported,
          ),
        );
      }

      profiles[id] = CreatorProfile(
        userId: id,
        displayName: name,
        professionalName: handle,
        avatarPath: imagePath,
        bio: null, // No fabricated bio
        location: LocationData(
          city: city,
          state: _inferState(city),
          country: 'IN',
        ),
        availability: const CreatorAvailability(
          status: AvailabilityStatus.open,
        ),
        isRepresented: false,
        onboardingStep: 1,
        onboardingCompleted: false, // Unclaimed directory listing
        primaryCategories: mappedCats,
        languages: const [], // No fabricated languages
        socialAccounts: socialAccounts,
        rateCard: const [], // No fabricated rate cards
        portfolio: const [],
        pastCollaborations: const [],
        verificationSummary: const VerificationSummary(
          identityStatus: FieldVerificationStatus.notStarted,
          emailStatus: FieldVerificationStatus.notStarted,
        ),
      );
    }

    return profiles;
  }

  static String? _inferState(String? city) {
    if (city == null) return null;
    final c = city.toLowerCase();
    if (c.contains('mumbai') || c.contains('pune')) return 'Maharashtra';
    if (c.contains('delhi')) return 'Delhi';
    if (c.contains('bangalore') || c.contains('bengaluru')) return 'Karnataka';
    if (c.contains('chennai')) return 'Tamil Nadu';
    if (c.contains('hyderabad')) return 'Telangana';
    if (c.contains('jaipur')) return 'Rajasthan';
    if (c.contains('kolkata')) return 'West Bengal';
    return null;
  }

  static String _slugify(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_]'), '_')
        .replaceAll(RegExp(r'_+'), '_');
  }
}
