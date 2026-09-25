import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/portfolio.dart';
import 'package:ggs_mobile/features/creator/domain/profile_completion.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';
import 'package:ggs_mobile/features/creator/domain/social_account.dart';
import 'package:ggs_mobile/features/profile_common/domain/reference_data.dart';

void main() {
  group('ProfileCompletionCalculator', () {
    // ─── Empty profile ─────────────────────────────────────────────────────────

    test(
      'scores 5% for a brand-new profile (availability is always counted)',
      () {
        const profile = CreatorProfile(
          userId: 'test-user',
          displayName: 'Test',
        );
        final result = ProfileCompletionCalculator.calculate(profile);

        // Availability is always marked true (5 pts)
        expect(result.percentage, equals(5));
        expect(result.completedFields['availability'], isTrue);
      },
    );

    test('reports all 8 missing field recommendations for empty profile', () {
      const profile = CreatorProfile(userId: 'test-user', displayName: 'Test');
      final result = ProfileCompletionCalculator.calculate(profile);

      final missingKeys = result.recommendations.map((r) => r.key).toSet();
      expect(
        missingKeys,
        containsAll([
          'avatar',
          'bio',
          'location',
          'categories',
          'languages',
          'socialAccounts',
          'rateCard',
          'portfolio',
        ]),
      );
      expect(result.recommendations.length, equals(8));
    });

    // ─── Full profile ──────────────────────────────────────────────────────────

    test('scores 100% for a fully populated profile', () {
      final profile = CreatorProfile(
        userId: 'test-user',
        displayName: 'Aarav Sharma',
        avatarPath: 'avatars/aarav.jpg', // 10
        bio: 'Tech reviewer and digital creator based in Bengaluru.', // 10
        location: const LocationData(city: 'Bengaluru', state: 'KA'), // 10
        primaryCategories: const [
          Category(id: 'cat-1', name: 'Technology', slug: 'tech'),
        ], // 15
        languages: const [
          Language(code: 'en', name: 'English', nativeName: 'English'),
        ], // 10
        socialAccounts: const [
          SocialAccount(
            id: 'soc-1',
            userId: 'test-user',
            platform: SocialPlatform.youtube,
            handle: 'techguy',
          ),
        ], // 15
        rateCard: const [
          RateItem(
            id: 'rate-1',
            userId: 'test-user',
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 50000,
          ),
        ], // 15
        portfolio: const [
          PortfolioItem(
            id: 'port-1',
            userId: 'test-user',
            title: 'Top 10 Gadgets 2026',
          ),
        ], // 10
        // availability is always 5
      );

      final result = ProfileCompletionCalculator.calculate(profile);

      expect(result.percentage, equals(100));
      expect(result.recommendations, isEmpty);
      expect(result.completedFields['avatar'], isTrue);
      expect(result.completedFields['bio'], isTrue);
      expect(result.completedFields['location'], isTrue);
      expect(result.completedFields['categories'], isTrue);
      expect(result.completedFields['languages'], isTrue);
      expect(result.completedFields['socialAccounts'], isTrue);
      expect(result.completedFields['rateCard'], isTrue);
      expect(result.completedFields['portfolio'], isTrue);
      expect(result.completedFields['availability'], isTrue);
    });

    // ─── Partial profiles ──────────────────────────────────────────────────────

    test('partial profile with avatar+bio+location scores 35%', () {
      final profile = CreatorProfile(
        userId: 'test-user',
        displayName: 'Test',
        avatarPath: 'avatars/test.jpg', // 10
        bio: 'Gaming streamer and content creator since 2020.', // 10
        location: const LocationData(city: 'Mumbai'), // 10
        // availability always: 5
      );

      final result = ProfileCompletionCalculator.calculate(profile);

      expect(result.percentage, equals(35));
      final missingKeys = result.recommendations.map((r) => r.key).toSet();
      expect(
        missingKeys,
        containsAll([
          'categories',
          'languages',
          'socialAccounts',
          'rateCard',
          'portfolio',
        ]),
      );
    });

    test('bio shorter than 20 chars is not counted', () {
      const profile = CreatorProfile(
        userId: 'test-user',
        displayName: 'Test',
        bio: 'Short', // < 20 chars — should NOT score
      );
      final result = ProfileCompletionCalculator.calculate(profile);

      expect(result.completedFields['bio'], isFalse);
      // Only availability (5%) contributes
      expect(result.percentage, equals(5));
    });

    test('inactive rate items do not satisfy rateCard completion', () {
      final profile = CreatorProfile(
        userId: 'test-user',
        displayName: 'Test',
        rateCard: const [
          RateItem(
            id: 'rate-1',
            userId: 'test-user',
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 10000,
            isActive: false, // inactive — should not count
          ),
        ],
      );
      final result = ProfileCompletionCalculator.calculate(profile);

      expect(result.completedFields['rateCard'], isFalse);
    });

    // ─── Recommendation weights ────────────────────────────────────────────────

    test('recommendation weights sum is 95 (availability is auto-counted)', () {
      const profile = CreatorProfile(userId: 'test-user', displayName: 'Test');
      final result = ProfileCompletionCalculator.calculate(profile);

      final totalWeight = result.recommendations.fold<int>(
        0,
        (sum, r) => sum + r.weight,
      );
      expect(totalWeight, equals(95)); // 100 - 5 (availability)
    });

    test('recommendation action routes are non-empty strings', () {
      const profile = CreatorProfile(userId: 'test-user', displayName: 'Test');
      final result = ProfileCompletionCalculator.calculate(profile);

      for (final rec in result.recommendations) {
        expect(rec.actionRoute.isNotEmpty, isTrue);
        expect(rec.title.isNotEmpty, isTrue);
        expect(rec.description.isNotEmpty, isTrue);
      }
    });
  });
}
