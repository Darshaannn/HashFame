import 'creator_discovery_item.dart';
import 'parsed_search_criteria.dart';

/// Transparent, deterministic ranking for Creator Discovery
class CreatorSearchRanker {
  const CreatorSearchRanker._();

  /// Ranks creators based on relevance to the parsed search criteria
  static List<CreatorDiscoveryItem> rankCreators({
    required List<CreatorDiscoveryItem> creators,
    required ParsedSearchCriteria criteria,
  }) {
    final scored = <MapEntry<CreatorDiscoveryItem, double>>[];

    for (final creator in creators) {
      final score = _calculateRelevanceScore(creator, criteria);
      if (score >= 0) {
        scored.add(MapEntry(creator, score));
      }
    }

    // Sort descending by relevance score
    scored.sort((a, b) => b.value.compareTo(a.value));
    return scored.map((e) => e.key).toList();
  }

  static double _calculateRelevanceScore(
    CreatorDiscoveryItem creator,
    ParsedSearchCriteria criteria,
  ) {
    // 1. Enforce Hard Constraints
    // City filter
    if (criteria.city != null && criteria.city!.isNotEmpty) {
      if (creator.city == null ||
          !creator.city!.toLowerCase().contains(criteria.city!.toLowerCase())) {
        return -1.0; // Exclude non-matching city
      }
    }

    // Follower Range filter
    final followers = creator.totalFollowers;
    if (criteria.minFollowers != null) {
      if (followers == null || followers < criteria.minFollowers!) {
        return -1.0;
      }
    }
    if (criteria.maxFollowers != null) {
      if (followers == null || followers > criteria.maxFollowers!) {
        return -1.0;
      }
    }

    // Category filter
    if (criteria.category != null && criteria.category!.isNotEmpty) {
      final hasCat = creator.primaryCategoryNames.any(
        (c) => c.toLowerCase().contains(criteria.category!.toLowerCase()),
      );
      if (!hasCat) {
        return -1.0; // Exclude non-matching category
      }
    }

    // 2. Compute Soft Relevance Score (0.0 to 100.0)
    double score = 50.0;

    // Exact or Partial Name/Handle match
    if (criteria.nameOrKeyword != null && criteria.nameOrKeyword!.isNotEmpty) {
      final kw = criteria.nameOrKeyword!.toLowerCase();
      final name = creator.displayName.toLowerCase();
      final handle = creator.professionalName?.toLowerCase() ?? '';

      if (handle == kw || handle == '@$kw') {
        score += 40.0; // Exact handle match
      } else if (name == kw) {
        score += 35.0; // Exact name match
      } else if (handle.contains(kw)) {
        score += 25.0;
      } else if (name.contains(kw)) {
        score += 20.0;
      } else {
        score -= 20.0; // Token did not match name or handle
      }
    }

    // Boost verified/represented creators slightly
    if (creator.isRepresented) {
      score += 5.0;
    }

    // Natural popularity signal (scaled logarithmically up to +10 pts)
    if (followers != null && followers > 0) {
      score += (followers / 100000).clamp(0.0, 10.0);
    }

    return score;
  }
}
