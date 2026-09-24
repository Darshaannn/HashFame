import 'creator_discovery_item.dart';
import 'creator_search_filters.dart';

class DiscoverySearchResult {
  const DiscoverySearchResult({
    required this.items,
    this.nextOffset,
    required this.hasMore,
  });

  final List<CreatorDiscoveryItem> items;
  final int? nextOffset;
  final bool hasMore;
}

abstract interface class DiscoveryRepository {
  Future<DiscoverySearchResult> searchCreators({
    required CreatorSearchFilters filters,
    int limit = 20,
    int offset = 0,
  });

  Future<CreatorDiscoveryItem?> getCreatorDiscoveryDetail({
    required String creatorId,
  });

  Future<List<CreatorDiscoveryItem>> getCreatorsForComparison({
    required List<String> creatorIds,
  });
}
