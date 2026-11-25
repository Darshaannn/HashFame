import 'package:flutter/foundation.dart';

/// Supported influencer follower tiers with clear numeric bounds
enum InfluencerTier {
  nano(minFollowers: 1000, maxFollowers: 10000, label: 'Nano (1K - 10K)'),
  micro(minFollowers: 10000, maxFollowers: 100000, label: 'Micro (10K - 100K)'),
  midTier(
    minFollowers: 100000,
    maxFollowers: 500000,
    label: 'Mid-Tier (100K - 500K)',
  ),
  macro(
    minFollowers: 500000,
    maxFollowers: 1000000,
    label: 'Macro (500K - 1M)',
  ),
  mega(minFollowers: 1000000, maxFollowers: null, label: 'Mega (1M+)');

  const InfluencerTier({
    required this.minFollowers,
    required this.maxFollowers,
    required this.label,
  });

  final int minFollowers;
  final int? maxFollowers;
  final String label;
}

/// Parsed structured search intent extracted from natural-language query
@immutable
class ParsedSearchCriteria {
  const ParsedSearchCriteria({
    required this.rawQuery,
    this.nameOrKeyword,
    this.city,
    this.category,
    this.minFollowers,
    this.maxFollowers,
    this.tier,
    this.platform,
    this.unsupportedConditions = const [],
    this.isNaturalLanguage = false,
  });

  final String rawQuery;
  final String? nameOrKeyword;
  final String? city;
  final String? category;
  final int? minFollowers;
  final int? maxFollowers;
  final InfluencerTier? tier;
  final String? platform;
  final List<String> unsupportedConditions;
  final bool isNaturalLanguage;

  bool get hasStructuredFilters =>
      city != null ||
      category != null ||
      minFollowers != null ||
      maxFollowers != null ||
      tier != null ||
      platform != null;

  String get summaryDescription {
    final parts = <String>[];
    if (category != null) parts.add('$category creators');
    if (city != null) parts.add('in $city');
    if (tier != null) {
      parts.add(tier!.label);
    } else if (minFollowers != null && maxFollowers != null) {
      parts.add(
        '${_formatCount(minFollowers!)} - ${_formatCount(maxFollowers!)} followers',
      );
    } else if (minFollowers != null) {
      parts.add('>${_formatCount(minFollowers!)} followers');
    } else if (maxFollowers != null) {
      parts.add('<${_formatCount(maxFollowers!)} followers');
    }
    if (platform != null) parts.add('on $platform');
    if (nameOrKeyword != null && nameOrKeyword!.isNotEmpty) {
      parts.add('matching "$nameOrKeyword"');
    }
    return parts.isEmpty ? rawQuery : parts.join(' · ');
  }

  static String _formatCount(int count) {
    if (count >= 10000000) return '${(count / 10000000).toStringAsFixed(1)}Cr';
    if (count >= 100000) return '${(count / 100000).toStringAsFixed(0)}L';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(0)}K';
    return count.toString();
  }

  ParsedSearchCriteria copyWith({
    String? rawQuery,
    String? nameOrKeyword,
    String? city,
    String? category,
    int? minFollowers,
    int? maxFollowers,
    InfluencerTier? tier,
    String? platform,
    List<String>? unsupportedConditions,
    bool? isNaturalLanguage,
  }) {
    return ParsedSearchCriteria(
      rawQuery: rawQuery ?? this.rawQuery,
      nameOrKeyword: nameOrKeyword ?? this.nameOrKeyword,
      city: city ?? this.city,
      category: category ?? this.category,
      minFollowers: minFollowers ?? this.minFollowers,
      maxFollowers: maxFollowers ?? this.maxFollowers,
      tier: tier ?? this.tier,
      platform: platform ?? this.platform,
      unsupportedConditions:
          unsupportedConditions ?? this.unsupportedConditions,
      isNaturalLanguage: isNaturalLanguage ?? this.isNaturalLanguage,
    );
  }
}
