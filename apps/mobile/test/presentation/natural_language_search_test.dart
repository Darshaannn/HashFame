import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/demo/creator_directory_loader.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_search_ranker.dart';
import 'package:ggs_mobile/features/discovery/domain/natural_language_search_interpreter.dart';
import 'package:ggs_mobile/features/discovery/domain/parsed_search_criteria.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Phase 05 Natural-Language Search Interpreter Tests', () {
    test(
      'Parses English query with City, Category, and Numeric Follower Range',
      () {
        final criteria = NaturalLanguageSearchInterpreter.parse(
          'Find Mumbai beauty influencers between 50K and 200K followers',
        );

        expect(criteria.city, 'Mumbai');
        expect(criteria.category, 'Beauty & Skincare');
        expect(criteria.minFollowers, 50000);
        expect(criteria.maxFollowers, 200000);
        expect(criteria.isNaturalLanguage, isTrue);
      },
    );

    test('Parses Hindi / Hinglish phrasing accurately', () {
      final criteria = NaturalLanguageSearchInterpreter.parse(
        'Mumbai ke fashion influencers dikhao',
      );

      expect(criteria.city, 'Mumbai');
      expect(criteria.category, 'Fashion & Style');
      expect(criteria.isNaturalLanguage, isTrue);
    });

    test('Parses Marathi phrasing accurately', () {
      final criteria = NaturalLanguageSearchInterpreter.parse(
        'Pune madhle fitness creators dakhva',
      );

      expect(criteria.city, 'Pune');
      expect(criteria.category, 'Health & Fitness');
      expect(criteria.isNaturalLanguage, isTrue);
    });

    test('Parses Indian Lakh and Crore notation correctly', () {
      final criteriaLakh = NaturalLanguageSearchInterpreter.parse(
        'Travel creators with over 1 lakh followers',
      );
      expect(criteriaLakh.minFollowers, 100000);
      expect(criteriaLakh.category, 'Travel & Adventure');

      final criteriaCrore = NaturalLanguageSearchInterpreter.parse(
        'Automobile creators with more than 1 crore followers',
      );
      expect(criteriaCrore.minFollowers, 10000000);
      expect(criteriaCrore.category, 'Automotive & Cars');
    });

    test('Parses Influencer Tiers (Nano, Micro, Macro, Mega)', () {
      final microCriteria = NaturalLanguageSearchInterpreter.parse(
        'Find micro influencers in fitness',
      );
      expect(microCriteria.tier, InfluencerTier.micro);
      expect(microCriteria.minFollowers, 10000);
      expect(microCriteria.maxFollowers, 100000);
      expect(microCriteria.category, 'Health & Fitness');

      final nanoCriteria = NaturalLanguageSearchInterpreter.parse(
        'Nano fashion creators',
      );
      expect(nanoCriteria.tier, InfluencerTier.nano);
      expect(nanoCriteria.minFollowers, 1000);
      expect(nanoCriteria.maxFollowers, 10000);
    });

    test('Flags unsupported conditions without guessing or silent failure', () {
      final criteria = NaturalLanguageSearchInterpreter.parse(
        'Find female fashion influencers in Bangalore with high engagement rate',
      );

      expect(criteria.city, 'Bengaluru');
      expect(criteria.category, 'Fashion & Style');
      expect(criteria.unsupportedConditions.isNotEmpty, isTrue);
      expect(
        criteria.unsupportedConditions.any(
          (c) => c.contains('Demographic / Gender'),
        ),
        isTrue,
      );
      expect(
        criteria.unsupportedConditions.any(
          (c) => c.contains('Engagement rates'),
        ),
        isTrue,
      );
    });

    test(
      'Warns that Rate Cards were removed in Phase 01 when user asks for rates',
      () {
        final criteria = NaturalLanguageSearchInterpreter.parse(
          'Cheap lifestyle influencers under 5000 rs',
        );
        expect(
          criteria.unsupportedConditions.any(
            (c) => c.contains('Rate Cards were removed in Phase 01'),
          ),
          isTrue,
        );
      },
    );
  });

  group('Phase 05 Creator Search Ranker & Relevance Tests', () {
    test(
      'Enforces hard constraints: excludes creators from non-matching city',
      () {
        final records = CreatorDirectoryLoader.loadDirectoryRecordsSync();
        final creators = CreatorDirectoryLoader.mapToDiscoveryItems(records);

        final criteria = NaturalLanguageSearchInterpreter.parse(
          'Mumbai travel creators',
        );
        final ranked = CreatorSearchRanker.rankCreators(
          creators: creators,
          criteria: criteria,
        );

        for (final c in ranked) {
          expect(c.city?.toLowerCase().contains('mumbai'), isTrue);
        }
      },
    );

    test(
      'Enforces follower constraints accurately against real directory items',
      () {
        final records = CreatorDirectoryLoader.loadDirectoryRecordsSync();
        final creators = CreatorDirectoryLoader.mapToDiscoveryItems(records);

        final criteria = NaturalLanguageSearchInterpreter.parse(
          'Travel creators between 50K and 500K',
        );
        final ranked = CreatorSearchRanker.rankCreators(
          creators: creators,
          criteria: criteria,
        );

        for (final c in ranked) {
          expect(c.totalFollowers, isNotNull);
          expect(
            c.totalFollowers! >= 50000 && c.totalFollowers! <= 500000,
            isTrue,
          );
        }
      },
    );
  });
}
