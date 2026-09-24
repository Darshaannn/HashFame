import 'package:supabase_flutter/supabase_flutter.dart';

import '../../creator/domain/creator_profile.dart';
import '../../creator/domain/rate_card.dart';
import '../../creator/domain/social_account.dart';
import '../../profile_common/domain/verification.dart';
import '../domain/creator_discovery_item.dart';
import '../domain/creator_search_filters.dart';
import '../domain/discovery_repository.dart';

class SupabaseDiscoveryDataSource {
  SupabaseDiscoveryDataSource(this.client);
  final SupabaseClient client;

  Future<DiscoverySearchResult> searchCreators({
    required CreatorSearchFilters filters,
    int limit = 20,
    int offset = 0,
  }) async {
    // 1. Query creator profiles join profiles
    var query = client
        .from('creator_profiles')
        .select('''
          user_id,
          professional_name,
          city,
          state,
          country,
          availability_status,
          is_represented,
          profiles!inner(display_name, avatar_path),
          creator_categories(category_id, is_primary, categories(name, parent_id)),
          creator_languages(language_code, languages(name)),
          creator_social_accounts(platform, user_provided_follower_count),
          creator_rate_items(deliverable_type, price_amount, is_active),
          field_verifications(subject, status)
        ''');

    if (filters.query.isNotEmpty) {
      final q = '%${filters.query}%';
      query = query.or('professional_name.ilike.$q,profiles.display_name.ilike.$q');
    }

    if (filters.city != null && filters.city!.isNotEmpty) {
      query = query.ilike('city', '%${filters.city}%');
    }
    if (filters.state != null && filters.state!.isNotEmpty) {
      query = query.ilike('state', '%${filters.state}%');
    }
    if (filters.availability != null) {
      query = query.eq('availability_status', filters.availability!.wire);
    }
    if (filters.isRepresented != null) {
      query = query.eq('is_represented', filters.isRepresented!);
    }

    final response = await query.range(offset, offset + limit);
    final rows = response as List;

    final items = <CreatorDiscoveryItem>[];
    for (final row in rows) {
      final item = _mapRowToDiscoveryItem(Map<String, dynamic>.from(row as Map));
      if (_matchesInMemoryFilters(item, filters)) {
        items.add(item);
      }
    }

    final hasMore = rows.length > limit;
    final nextOffset = hasMore ? offset + limit : null;

    return DiscoverySearchResult(
      items: items.take(limit).toList(),
      nextOffset: nextOffset,
      hasMore: hasMore,
    );
  }

  bool _matchesInMemoryFilters(CreatorDiscoveryItem item, CreatorSearchFilters filters) {
    if (filters.minFollowers != null && (item.totalFollowers == null || item.totalFollowers! < filters.minFollowers!)) {
      return false;
    }
    if (filters.maxFollowers != null && (item.totalFollowers == null || item.totalFollowers! > filters.maxFollowers!)) {
      return false;
    }
    if (filters.minRate != null && (item.startingRate == null || item.startingRate! < filters.minRate!)) {
      return false;
    }
    if (filters.maxRate != null && (item.startingRate == null || item.startingRate! > filters.maxRate!)) {
      return false;
    }
    if (filters.platforms.isNotEmpty && (item.primaryPlatform == null || !filters.platforms.contains(item.primaryPlatform))) {
      return false;
    }
    return true;
  }

  CreatorDiscoveryItem _mapRowToDiscoveryItem(Map<String, dynamic> row) {
    final profile = row['profiles'] as Map<String, dynamic>? ?? {};
    final catList = row['creator_categories'] as List? ?? [];
    final langList = row['creator_languages'] as List? ?? [];
    final socials = row['creator_social_accounts'] as List? ?? [];
    final rates = row['creator_rate_items'] as List? ?? [];

    final primaryCats = <String>[];
    final subCats = <String>[];
    for (final c in catList) {
      final cat = c['categories'] as Map<String, dynamic>?;
      if (cat != null && cat['name'] != null) {
        if (cat['parent_id'] == null) {
          primaryCats.add(cat['name'] as String);
        } else {
          subCats.add(cat['name'] as String);
        }
      }
    }

    final langs = <String>[];
    for (final l in langList) {
      final lang = l['languages'] as Map<String, dynamic>?;
      if (lang != null && lang['name'] != null) {
        langs.add(lang['name'] as String);
      }
    }

    SocialPlatform? primaryPlatform;
    int totalFollowers = 0;
    for (final s in socials) {
      final pStr = s['platform'] as String?;
      final p = SocialPlatform.values.where((v) => v.name == pStr).firstOrNull;
      if (p != null && primaryPlatform == null) {
        primaryPlatform = p;
      }
      final count = s['user_provided_follower_count'] as int?;
      if (count != null) totalFollowers += count;
    }

    double? startRate;
    DeliverableType? rateDeliverable;
    for (final r in rates) {
      if (r['is_active'] == true) {
        final amount = double.tryParse(r['price_amount'].toString());
        if (amount != null && (startRate == null || amount < startRate)) {
          startRate = amount;
          final dStr = r['deliverable_type'] as String?;
          rateDeliverable = DeliverableType.values.where((v) => v.name == dStr).firstOrNull;
        }
      }
    }

    final availStr = row['availability_status'] as String? ?? 'open';
    final avail = AvailabilityStatus.values.where((v) => v.name == availStr).firstOrNull ?? AvailabilityStatus.open;

    return CreatorDiscoveryItem(
      creatorId: row['user_id'] as String,
      displayName: profile['display_name'] as String? ?? '',
      professionalName: row['professional_name'] as String?,
      avatarPath: profile['avatar_path'] as String?,
      city: row['city'] as String?,
      state: row['state'] as String?,
      country: row['country'] as String? ?? 'IN',
      primaryCategoryNames: primaryCats,
      subcategoryNames: subCats,
      languageNames: langs,
      primaryPlatform: primaryPlatform,
      totalFollowers: totalFollowers > 0 ? totalFollowers : null,
      startingRate: startRate,
      startingRateDeliverable: rateDeliverable,
      availabilityStatus: avail,
      isRepresented: row['is_represented'] as bool? ?? false,
    );
  }
}

class DiscoveryRepositoryImpl implements DiscoveryRepository {
  DiscoveryRepositoryImpl(this.dataSource);
  final SupabaseDiscoveryDataSource dataSource;

  @override
  Future<DiscoverySearchResult> searchCreators({
    required CreatorSearchFilters filters,
    int limit = 20,
    int offset = 0,
  }) {
    return dataSource.searchCreators(filters: filters, limit: limit, offset: offset);
  }

  @override
  Future<CreatorDiscoveryItem?> getCreatorDiscoveryDetail({required String creatorId}) async {
    final result = await dataSource.searchCreators(
      filters: CreatorSearchFilters(query: creatorId),
      limit: 1,
      offset: 0,
    );
    return result.items.where((i) => i.creatorId == creatorId).firstOrNull;
  }

  @override
  Future<List<CreatorDiscoveryItem>> getCreatorsForComparison({
    required List<String> creatorIds,
  }) async {
    final results = <CreatorDiscoveryItem>[];
    for (final id in creatorIds) {
      final item = await getCreatorDiscoveryDetail(creatorId: id);
      if (item != null) results.add(item);
    }
    return results;
  }
}
