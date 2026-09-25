import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';
import 'package:ggs_mobile/features/creator/domain/social_account.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_discovery_item.dart';
import 'package:ggs_mobile/features/profile_common/domain/reference_data.dart';
import 'package:ggs_mobile/features/profile_common/domain/verification.dart';

/// Ingests creator rows (from the boss demo sheet/CSV) into deterministic Demo data structures.
///
/// Maps:
/// - Creator Name -> displayName
/// - IG Handles -> Instagram SocialAccount & handle
/// - Followers -> userProvidedFollowerCount & totalFollowers
/// - Category -> Category & primaryCategoryNames
/// - Cost / Usage Rights -> startingRate & RateItem
/// - City -> LocationData.city & city
///
/// NOTE: Phone numbers and emails are explicitly NOT mapped or exposed in discovery items.
class DemoSheetCreatorImporter {
  const DemoSheetCreatorImporter();

  static List<CreatorDiscoveryItem> parseSheetDiscoveryItems(
    String csvContent,
    List<Category> availableCategories,
  ) {
    final rows = _parseCsv(csvContent);
    if (rows.isEmpty) return [];

    final results = <CreatorDiscoveryItem>[];
    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      if (row.isEmpty) continue;
      final name = row.isNotEmpty ? row[0].trim() : '';
      if (name.isEmpty ||
          name.toLowerCase() == 'creators' ||
          name.startsWith('Title:') ||
          name.startsWith('Source:')) {
        continue;
      }

      final igUrl = row.length > 1 ? row[1].trim() : '';
      final followersRaw = row.length > 2 ? row[2].trim() : '';
      final categoryRaw = row.length > 3 ? row[3].trim() : '';
      final costRaw = row.length > 6 ? row[6].trim() : '';
      final usage3M = row.length > 7 ? row[7].trim() : '';
      final usage6M = row.length > 8 ? row[8].trim() : '';
      final cityRaw = row.length > 11 ? row[11].trim() : '';

      final handle = _extractHandle(igUrl, name);
      final followers = _parseFollowers(followersRaw);
      final rate = _parseRate(costRaw, usage3M, usage6M);
      final categoryName = _normalizeCategory(categoryRaw);
      final city = _normalizeCity(cityRaw);
      final id = 'sheet_creator_${i}_${_slugify(handle)}';

      results.add(
        CreatorDiscoveryItem(
          creatorId: id,
          displayName: name,
          professionalName: handle.isNotEmpty ? handle : null,
          city: city,
          state: _inferState(city),
          country: 'IN',
          primaryCategoryNames: [categoryName],
          languageNames: const ['English', 'Hindi'],
          primaryPlatform: SocialPlatform.instagram,
          totalFollowers: followers > 0 ? followers : null,
          startingRate: rate > 0 ? rate : null,
          startingRateDeliverable: DeliverableType.instagramReel,
          availabilityStatus: AvailabilityStatus.open,
          isRepresented: i % 4 == 0,
        ),
      );
    }

    return results;
  }

  static Map<String, CreatorProfile> parseSheetProfiles(
    String csvContent,
    List<Category> availableCategories,
    List<Language> availableLanguages,
  ) {
    final rows = _parseCsv(csvContent);
    if (rows.isEmpty) return {};

    final profiles = <String, CreatorProfile>{};
    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      if (row.isEmpty) continue;
      final name = row.isNotEmpty ? row[0].trim() : '';
      if (name.isEmpty ||
          name.toLowerCase() == 'creators' ||
          name.startsWith('Title:') ||
          name.startsWith('Source:')) {
        continue;
      }

      final igUrl = row.length > 1 ? row[1].trim() : '';
      final followersRaw = row.length > 2 ? row[2].trim() : '';
      final categoryRaw = row.length > 3 ? row[3].trim() : '';
      final costRaw = row.length > 6 ? row[6].trim() : '';
      final usage3M = row.length > 7 ? row[7].trim() : '';
      final usage6M = row.length > 8 ? row[8].trim() : '';
      final cityRaw = row.length > 11 ? row[11].trim() : '';

      final handle = _extractHandle(igUrl, name);
      final followers = _parseFollowers(followersRaw);
      final rate = _parseRate(costRaw, usage3M, usage6M);
      final categoryName = _normalizeCategory(categoryRaw);
      final city = _normalizeCity(cityRaw);
      final id = 'sheet_creator_${i}_${_slugify(handle)}';

      final matchingCat = availableCategories.firstWhere(
        (c) =>
            c.name.toLowerCase().contains(categoryName.toLowerCase()) ||
            categoryName.toLowerCase().contains(c.name.toLowerCase()),
        orElse: () => Category(
          id: 'cat_${_slugify(categoryName)}',
          name: categoryName,
          slug: _slugify(categoryName),
        ),
      );

      final rates = <RateItem>[];
      if (rate > 0) {
        rates.add(
          RateItem(
            id: 'rate_${id}_1',
            userId: id,
            deliverableType: DeliverableType.instagramReel,
            priceAmount: rate,
            description: '1x Instagram Reel / Video Collaboration',
            isActive: true,
          ),
        );
      }

      profiles[id] = CreatorProfile(
        userId: id,
        displayName: name,
        professionalName: handle.isNotEmpty ? handle : null,
        bio:
            'Professional content creator specializing in $categoryName in ${city ?? "India"}. Focused on high-engagement visual storytelling and authentic brand collaborations.',
        location: LocationData(
          city: city,
          state: _inferState(city),
          country: 'IN',
        ),
        availability: const CreatorAvailability(
          status: AvailabilityStatus.open,
        ),
        isRepresented: i % 4 == 0,
        onboardingStep: 5,
        onboardingCompleted: true,
        primaryCategories: [matchingCat],
        languages: availableLanguages.take(2).toList(),
        socialAccounts: [
          SocialAccount(
            id: 'soc_${id}_ig',
            userId: id,
            platform: SocialPlatform.instagram,
            handle: handle.isNotEmpty ? handle : _slugify(name),
            profileUrl: igUrl.isNotEmpty ? igUrl : null,
            userProvidedFollowerCount: followers > 0 ? followers : null,
            connectionStatus: SocialConnectionStatus.connected,
          ),
        ],
        rateCard: rates,
        verificationSummary: const VerificationSummary(
          identityStatus: FieldVerificationStatus.verified,
          emailStatus: FieldVerificationStatus.verified,
        ),
      );
    }

    return profiles;
  }

  static List<List<String>> _parseCsv(String input) {
    final lines = input.split(RegExp(r'\r?\n'));
    final result = <List<String>>[];

    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      final row = <String>[];
      var current = StringBuffer();
      var inQuotes = false;

      for (var i = 0; i < line.length; i++) {
        final char = line[i];
        if (char == '"') {
          inQuotes = !inQuotes;
        } else if (char == ',' && !inQuotes) {
          row.add(current.toString());
          current = StringBuffer();
        } else {
          current.write(char);
        }
      }
      row.add(current.toString());
      result.add(row);
    }

    return result;
  }

  static String _extractHandle(String igUrl, String name) {
    if (igUrl.isNotEmpty && igUrl.contains('instagram.com/')) {
      var path = igUrl.split('instagram.com/').last;
      path = path.split('?').first;
      path = path.split('/').where((s) => s.isNotEmpty).firstOrNull ?? '';
      if (path.isNotEmpty && path != 'p') return path;
    }
    return _slugify(name);
  }

  static int _parseFollowers(String raw) {
    if (raw.isEmpty) return 0;
    final cleaned = raw.replaceAll(',', '').replaceAll(' ', '').toUpperCase();
    try {
      if (cleaned.endsWith('M')) {
        final numPart = double.parse(cleaned.substring(0, cleaned.length - 1));
        return (numPart * 1000000).round();
      } else if (cleaned.endsWith('K')) {
        final numPart = double.parse(cleaned.substring(0, cleaned.length - 1));
        return (numPart * 1000).round();
      } else {
        return int.tryParse(cleaned) ??
            (double.tryParse(cleaned)?.round() ?? 0);
      }
    } catch (_) {
      return 0;
    }
  }

  static double _parseRate(String costRaw, String usage3M, String usage6M) {
    for (final raw in [costRaw, usage3M, usage6M]) {
      if (raw.isEmpty) continue;
      final cleaned = raw
          .replaceAll(',', '')
          .replaceAll(' ', '')
          .replaceAll('₹', '');
      final parsed = double.tryParse(cleaned);
      if (parsed != null && parsed > 0) {
        return parsed;
      }
    }
    return 0;
  }

  static String _normalizeCategory(String raw) {
    if (raw.isEmpty) return 'Lifestyle & Vlogs';
    final lower = raw.toLowerCase();
    if (lower.contains('bike') ||
        lower.contains('car') ||
        lower.contains('truck') ||
        lower.contains('auto')) {
      return 'Technology & Gadgets';
    }
    if (lower.contains('fashion') ||
        lower.contains('model') ||
        lower.contains('actor')) {
      return 'Fashion & Style';
    }
    if (lower.contains('beauty') || lower.contains('skincare')) {
      return 'Beauty & Skincare';
    }
    if (lower.contains('food') || lower.contains('cooking')) {
      return 'Food & Culinary';
    }
    if (lower.contains('fitness') || lower.contains('gym')) {
      return 'Health & Fitness';
    }
    if (lower.contains('travel') || lower.contains('wander')) {
      return 'Travel & Adventure';
    }
    if (lower.contains('home') ||
        lower.contains('decor') ||
        lower.contains('interior') ||
        lower.contains('mom') ||
        lower.contains('real estate')) {
      return 'Lifestyle & Vlogs';
    }
    return raw.trim();
  }

  static String? _normalizeCity(String raw) {
    if (raw.isEmpty) return null;
    final cleaned = raw.replaceAll(RegExp(r'[0-9]'), '').trim();
    if (cleaned.isEmpty) return null;
    if (cleaned.contains('/')) {
      final parts = cleaned.split('/');
      return parts.first.trim();
    }
    if (cleaned.contains(',')) {
      final parts = cleaned.split(',');
      return parts.first.trim();
    }
    return cleaned;
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
