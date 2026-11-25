import 'parsed_search_criteria.dart';

/// Deterministic, zero-cost Natural-Language Search Interpreter
/// Handles English, Hindi, and Marathi phrasing without external API dependencies.
class NaturalLanguageSearchInterpreter {
  const NaturalLanguageSearchInterpreter._();

  static const Map<String, String> _cityAliases = {
    'mumbai': 'Mumbai',
    'bombay': 'Mumbai',
    'delhi': 'Delhi',
    'new delhi': 'Delhi',
    'ncr': 'Delhi',
    'bangalore': 'Bengaluru',
    'bengaluru': 'Bengaluru',
    'pune': 'Pune',
    'poona': 'Pune',
    'hyderabad': 'Hyderabad',
    'chennai': 'Chennai',
    'madras': 'Chennai',
    'kolkata': 'Kolkata',
    'calcutta': 'Kolkata',
    'jaipur': 'Jaipur',
    'ahmedabad': 'Ahmedabad',
    'chandigarh': 'Chandigarh',
    'goa': 'Goa',
    'gurgaon': 'Gurugram',
    'gurugram': 'Gurugram',
    'noida': 'Noida',
  };

  static const Map<String, String> _categorySynonyms = {
    'fashion': 'Fashion & Style',
    'style': 'Fashion & Style',
    'clothing': 'Fashion & Style',
    'outfit': 'Fashion & Style',
    'model': 'Fashion & Modeling',
    'modeling': 'Fashion & Modeling',
    'beauty': 'Beauty & Skincare',
    'skincare': 'Beauty & Skincare',
    'makeup': 'Beauty & Skincare',
    'cosmetics': 'Beauty & Skincare',
    'travel': 'Travel & Adventure',
    'traveler': 'Travel & Adventure',
    'wanderlust': 'Travel & Adventure',
    'trip': 'Travel & Adventure',
    'food': 'Food & Culinary',
    'foodie': 'Food & Culinary',
    'culinary': 'Food & Culinary',
    'cooking': 'Food & Culinary',
    'chef': 'Food & Culinary',
    'fitness': 'Health & Fitness',
    'gym': 'Health & Fitness',
    'workout': 'Health & Fitness',
    'health': 'Health & Fitness',
    'wellness': 'Health & Fitness',
    'lifestyle': 'Lifestyle & Vlogs',
    'vlog': 'Lifestyle & Vlogs',
    'vlogger': 'Lifestyle & Vlogs',
    'daily': 'Lifestyle & Vlogs',
    'automotive': 'Automotive & Cars',
    'automobile': 'Automotive & Cars',
    'car': 'Automotive & Cars',
    'cars': 'Automotive & Cars',
    'bike': 'Bikes & Moto',
    'bikes': 'Bikes & Moto',
    'moto': 'Bikes & Moto',
    'comedy': 'Comedy & Entertainment',
    'entertainment': 'Comedy & Entertainment',
    'funny': 'Comedy & Entertainment',
    'acting': 'Acting & Cinema',
    'cinema': 'Acting & Cinema',
    'actor': 'Acting & Cinema',
    'actress': 'Acting & Cinema',
    'movie': 'Acting & Cinema',
    'music': 'Music & Performing Arts',
    'singer': 'Music & Performing Arts',
    'song': 'Music & Performing Arts',
    'parenting': 'Parenting & Family',
    'mom': 'Parenting & Family',
    'mother': 'Parenting & Family',
    'family': 'Parenting & Family',
    'real estate': 'Real Estate & Architecture',
    'property': 'Real Estate & Architecture',
    'business': 'Entrepreneurship & Business',
    'entrepreneur': 'Entrepreneurship & Business',
    'startup': 'Entrepreneurship & Business',
    'decor': 'Home Decor & Living',
    'interior': 'Home Decor & Living',
  };

  static const List<String> _ignoredStopwords = [
    'find',
    'show',
    'search',
    'get',
    'need',
    'i',
    'me',
    'the',
    'a',
    'an',
    'influencer',
    'influencers',
    'creator',
    'creators',
    'blogger',
    'bloggers',
    'who',
    'make',
    'makes',
    'content',
    'with',
    'having',
    'in',
    'from',
    'at',
    'between',
    'to',
    'and',
    'or',
    'for',
    'over',
    'more',
    'than',
    'less',
    'greater',
    'under',
    'dikhao',
    'dakhva',
    'ke',
    'madhle',
    'madhil',
    'wale',
    'wali',
    'pahije',
    'chahiye',
    'batao',
    'khojo',
  ];

  /// Parses natural language query into structured criteria
  static ParsedSearchCriteria parse(String query) {
    if (query.trim().isEmpty) {
      return const ParsedSearchCriteria(rawQuery: '');
    }

    final lower = query.toLowerCase().trim();
    String? matchedCity;
    String? matchedCategory;
    int? minFollowers;
    int? maxFollowers;
    InfluencerTier? matchedTier;
    String? matchedPlatform;
    final unsupported = <String>[];

    // 1. Detect Unsupported Constraints (Gender, Engagement, Cost/Rates)
    if (RegExp(r'\b(female|male|women|woman|men|man|girl|boy|ladki|ladka)\b')
        .hasMatch(lower)) {
      unsupported.add(
        'Demographic / Gender filter is not tracked in the directory',
      );
    }
    if (RegExp(r'\b(engagement|er|views|impressions|reach|roi)\b')
        .hasMatch(lower)) {
      unsupported.add(
        'Engagement rates / Reach metrics are currently unverified',
      );
    }
    if (RegExp(
      r'\b(rate|price|cost|budget|rupees|rs|inr|charges|sasta|cheap)\b',
    ).hasMatch(lower)) {
      unsupported.add(
        'Public Rate Cards were removed in Phase 01. Request private quotation instead',
      );
    }

    // 2. Detect Platform
    if (lower.contains('instagram') ||
        lower.contains('insta') ||
        lower.contains('ig')) {
      matchedPlatform = 'Instagram';
    }

    // 3. Detect City Aliases
    for (final entry in _cityAliases.entries) {
      final pattern = RegExp('\\b${entry.key}\\b');
      if (pattern.hasMatch(lower)) {
        matchedCity = entry.value;
        break;
      }
    }

    // 4. Detect Category Synonyms
    for (final entry in _categorySynonyms.entries) {
      final pattern = RegExp('\\b${entry.key}\\b');
      if (pattern.hasMatch(lower)) {
        matchedCategory = entry.value;
        break;
      }
    }

    // 5. Detect Influencer Tiers
    if (RegExp(r'\bnano\b').hasMatch(lower)) {
      matchedTier = InfluencerTier.nano;
      minFollowers = InfluencerTier.nano.minFollowers;
      maxFollowers = InfluencerTier.nano.maxFollowers;
    } else if (RegExp(r'\bmicro\b').hasMatch(lower)) {
      matchedTier = InfluencerTier.micro;
      minFollowers = InfluencerTier.micro.minFollowers;
      maxFollowers = InfluencerTier.micro.maxFollowers;
    } else if (RegExp(r'\b(mid-tier|mid tier|macro)\b').hasMatch(lower)) {
      if (lower.contains('mid')) {
        matchedTier = InfluencerTier.midTier;
        minFollowers = InfluencerTier.midTier.minFollowers;
        maxFollowers = InfluencerTier.midTier.maxFollowers;
      } else {
        matchedTier = InfluencerTier.macro;
        minFollowers = InfluencerTier.macro.minFollowers;
        maxFollowers = InfluencerTier.macro.maxFollowers;
      }
    } else if (RegExp(r'\bmega\b').hasMatch(lower)) {
      matchedTier = InfluencerTier.mega;
      minFollowers = InfluencerTier.mega.minFollowers;
      maxFollowers = InfluencerTier.mega.maxFollowers;
    }

    // 6. Detect Follower Count Ranges
    if (matchedTier == null) {
      // Range: between X and Y / X to Y
      final rangeMatch = RegExp(
        r'(\d+(?:\.\d+)?)\s*(k|m|lakh|lakhs|l|lac|crore|cr)?\s*(?:to|-|and)\s*(\d+(?:\.\d+)?)\s*(k|m|lakh|lakhs|l|lac|crore|cr)?',
      ).firstMatch(lower);

      if (rangeMatch != null) {
        final val1 = _parseFollowerValue(
          rangeMatch.group(1)!,
          rangeMatch.group(2) ?? rangeMatch.group(4),
        );
        final val2 = _parseFollowerValue(
          rangeMatch.group(3)!,
          rangeMatch.group(4) ?? rangeMatch.group(2),
        );
        if (val1 != null && val2 != null) {
          minFollowers = val1 < val2 ? val1 : val2;
          maxFollowers = val1 < val2 ? val2 : val1;
        }
      } else {
        // Single Bound: over X / more than X / > X
        final minMatch = RegExp(
          r'(?:over|more than|greater than|above|>|\+)\s*(\d+(?:\.\d+)?)\s*(k|m|lakh|lakhs|l|lac|crore|cr)?',
        ).firstMatch(lower);
        if (minMatch != null) {
          minFollowers = _parseFollowerValue(
            minMatch.group(1)!,
            minMatch.group(2),
          );
        }

        // Single Bound: less than X / under X / below X / < X
        final maxMatch = RegExp(
          r'(?:less than|under|below|<)\s*(\d+(?:\.\d+)?)\s*(k|m|lakh|lakhs|l|lac|crore|cr)?',
        ).firstMatch(lower);
        if (maxMatch != null) {
          maxFollowers = _parseFollowerValue(
            maxMatch.group(1)!,
            maxMatch.group(2),
          );
        }
      }
    }

    // 7. Extract remaining keywords for exact/partial name match
    var cleanedTokens = lower.split(RegExp(r'[\s,]+'));
    cleanedTokens = cleanedTokens.where((t) {
      if (_ignoredStopwords.contains(t)) return false;
      if (matchedCity != null && _cityAliases.containsKey(t)) return false;
      if (matchedCategory != null && _categorySynonyms.containsKey(t)) {
        return false;
      }
      if (t == 'nano' || t == 'micro' || t == 'macro' || t == 'mega') {
        return false;
      }
      if (RegExp(r'^\d+[kml]?$').hasMatch(t)) return false;
      return true;
    }).toList();

    final keyword = cleanedTokens.isNotEmpty ? cleanedTokens.join(' ') : null;

    final isNl =
        matchedCity != null ||
        matchedCategory != null ||
        minFollowers != null ||
        maxFollowers != null ||
        matchedTier != null ||
        unsupported.isNotEmpty;

    return ParsedSearchCriteria(
      rawQuery: query,
      nameOrKeyword: keyword,
      city: matchedCity,
      category: matchedCategory,
      minFollowers: minFollowers,
      maxFollowers: maxFollowers,
      tier: matchedTier,
      platform: matchedPlatform,
      unsupportedConditions: unsupported,
      isNaturalLanguage: isNl,
    );
  }

  static int? _parseFollowerValue(String numStr, String? unit) {
    final num = double.tryParse(numStr);
    if (num == null) return null;
    final u = unit?.toLowerCase().trim();

    if (u == 'k') return (num * 1000).round();
    if (u == 'm') return (num * 1000000).round();
    if (u == 'lakh' || u == 'lakhs' || u == 'l' || u == 'lac') {
      return (num * 100000).round();
    }
    if (u == 'crore' || u == 'cr') return (num * 10000000).round();
    return num.round();
  }
}
