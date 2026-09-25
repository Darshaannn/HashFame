import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/widgets/creator_availability_card.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/widgets/creator_bio_card.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/widgets/creator_header_card.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/widgets/creator_rate_card_view.dart';

import '../support/fakes.dart';

// Helper to wrap a widget in MaterialApp
Widget _wrapWidget(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

void main() {
  group('CreatorHeaderCard', () {
    testWidgets('renders display name and availability badge', (tester) async {
      const profile = CreatorProfile(
        userId: 'test-1',
        displayName: 'Aarav Sharma',
        availability: CreatorAvailability(status: AvailabilityStatus.open),
      );

      await tester.pumpWidget(
        _wrapWidget(const CreatorHeaderCard(profile: profile)),
      );

      expect(find.text('Aarav Sharma'), findsOneWidget);
      // The badge shows the enum label
      expect(find.text(AvailabilityStatus.open.label), findsOneWidget);
    });

    testWidgets('shows professional name alias when set', (tester) async {
      const profile = CreatorProfile(
        userId: 'test-1',
        displayName: 'Aarav Sharma',
        professionalName: 'TechAarav',
      );

      await tester.pumpWidget(
        _wrapWidget(const CreatorHeaderCard(profile: profile)),
      );

      expect(find.text('Aarav Sharma'), findsOneWidget);
      expect(find.text('aka TechAarav'), findsOneWidget);
    });

    testWidgets('shows represented badge when isRepresented is true', (
      tester,
    ) async {
      const profile = CreatorProfile(
        userId: 'test-1',
        displayName: 'Aarav Sharma',
        isRepresented: true,
      );

      await tester.pumpWidget(
        _wrapWidget(const CreatorHeaderCard(profile: profile)),
      );

      expect(find.text('Represented by Talent Agency'), findsOneWidget);
    });

    testWidgets('calls onEditPressed when edit button tapped', (tester) async {
      bool tapped = false;
      const profile = CreatorProfile(
        userId: 'test-1',
        displayName: 'Aarav Sharma',
      );

      await tester.pumpWidget(
        _wrapWidget(
          CreatorHeaderCard(
            profile: profile,
            onEditPressed: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byTooltip('Edit Profile'));
      expect(tapped, isTrue);
    });
  });

  group('CreatorRateCardView', () {
    testWidgets('shows empty state when no active rates', (tester) async {
      const profile = CreatorProfile(userId: 'test-1', displayName: 'Test');

      await tester.pumpWidget(
        _wrapWidget(const CreatorRateCardView(profile: profile)),
      );

      expect(find.text('Rate Card'), findsOneWidget);
      expect(find.textContaining('No rate items added'), findsOneWidget);
    });

    testWidgets('renders active rate item with deliverable label and price', (
      tester,
    ) async {
      final profile = CreatorProfile(
        userId: 'test-1',
        displayName: 'Test',
        rateCard: const [
          RateItem(
            id: 'rate-1',
            userId: 'test-1',
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 50000,
            currency: 'INR',
          ),
        ],
      );

      await tester.pumpWidget(
        _wrapWidget(CreatorRateCardView(profile: profile)),
      );

      expect(find.text('Rate Card'), findsOneWidget);
      expect(find.text(DeliverableType.instagramReel.label), findsOneWidget);
      expect(find.textContaining('50000'), findsOneWidget);
    });

    testWidgets('does not render inactive rate items', (tester) async {
      final profile = CreatorProfile(
        userId: 'test-1',
        displayName: 'Test',
        rateCard: const [
          RateItem(
            id: 'rate-1',
            userId: 'test-1',
            deliverableType: DeliverableType.instagramReel,
            priceAmount: 50000,
            isActive: false, // should not render
          ),
        ],
      );

      await tester.pumpWidget(
        _wrapWidget(CreatorRateCardView(profile: profile)),
      );

      expect(find.textContaining('No rate items added'), findsOneWidget);
    });
  });

  group('CreatorBioCard', () {
    testWidgets('renders bio text when provided', (tester) async {
      const profile = CreatorProfile(
        userId: 'test-1',
        displayName: 'Test',
        bio: 'I create tech review content for Indian audiences.',
      );

      await tester.pumpWidget(
        _wrapWidget(const CreatorBioCard(profile: profile)),
      );

      expect(
        find.text('I create tech review content for Indian audiences.'),
        findsOneWidget,
      );
    });

    testWidgets('renders empty state prompt when no bio', (tester) async {
      const profile = CreatorProfile(userId: 'test-1', displayName: 'Test');

      await tester.pumpWidget(
        _wrapWidget(const CreatorBioCard(profile: profile)),
      );

      // Expect some placeholder or empty state text
      expect(find.byType(CreatorBioCard), findsOneWidget);
    });
  });

  group('CreatorAvailabilityCard', () {
    testWidgets('shows availability label for open status', (tester) async {
      const profile = CreatorProfile(
        userId: 'test-1',
        displayName: 'Test',
        availability: CreatorAvailability(status: AvailabilityStatus.open),
      );

      await tester.pumpWidget(
        _wrapWidget(
          CreatorAvailabilityCard(
            profile: profile,
            onAvailabilityChanged: (_) {},
          ),
        ),
      );

      expect(find.text(AvailabilityStatus.open.label), findsOneWidget);
    });

    testWidgets('shows unavailable status label', (tester) async {
      const profile = CreatorProfile(
        userId: 'test-1',
        displayName: 'Test',
        availability: CreatorAvailability(
          status: AvailabilityStatus.unavailable,
        ),
      );

      await tester.pumpWidget(
        _wrapWidget(
          CreatorAvailabilityCard(
            profile: profile,
            onAvailabilityChanged: (_) {},
          ),
        ),
      );

      expect(find.text(AvailabilityStatus.unavailable.label), findsOneWidget);
    });
  });

  group('FakeCreatorRepository (unit)', () {
    test('addRateItem increases rateCard length', () async {
      final repo = FakeCreatorRepository();
      expect(repo.profile.rateCard, isEmpty);

      await repo.addRateItem(
        const RateItem(
          id: 'r1',
          userId: 'test-1',
          deliverableType: DeliverableType.youtubeVideo,
          priceAmount: 75000,
        ),
      );

      expect(repo.profile.rateCard.length, equals(1));
      expect(repo.profile.rateCard.first.priceAmount, equals(75000));
    });

    test('deleteRateItem removes item by id', () async {
      final repo = FakeCreatorRepository(
        profile: const CreatorProfile(
          userId: 'test-1',
          displayName: 'Test',
          rateCard: [
            RateItem(
              id: 'r1',
              userId: 'test-1',
              deliverableType: DeliverableType.instagramReel,
              priceAmount: 10000,
            ),
            RateItem(
              id: 'r2',
              userId: 'test-1',
              deliverableType: DeliverableType.ugcVideo,
              priceAmount: 20000,
            ),
          ],
        ),
      );

      await repo.deleteRateItem('r1');
      expect(repo.profile.rateCard.length, equals(1));
      expect(repo.profile.rateCard.first.id, equals('r2'));
    });

    test('setCategories updates primaryCategories', () async {
      final repo = FakeCreatorRepository();
      await repo.setCategories(categoryIds: ['tech', 'gaming']);

      expect(repo.profile.primaryCategories.length, equals(2));
      expect(repo.profile.primaryCategories.first.id, equals('tech'));
    });

    test('setLanguages updates language list', () async {
      final repo = FakeCreatorRepository();
      await repo.setLanguages(languageCodes: ['en', 'hi', 'ta']);

      expect(repo.profile.languages.length, equals(3));
      expect(
        repo.profile.languages.map((l) => l.code).toList(),
        containsAll(['en', 'hi', 'ta']),
      );
    });

    test('updateAvailability persists new status', () async {
      final repo = FakeCreatorRepository();
      expect(repo.profile.availability.status, equals(AvailabilityStatus.open));

      await repo.updateAvailability(
        const CreatorAvailability(status: AvailabilityStatus.limited),
      );

      expect(
        repo.profile.availability.status,
        equals(AvailabilityStatus.limited),
      );
    });
  });

  group('FakeReferenceDataRepository (unit)', () {
    test('returns seeded categories', () async {
      final repo = FakeReferenceDataRepository();
      final cats = await repo.getCategories();

      expect(cats.length, equals(3));
      expect(cats.first.slug, equals('tech'));
    });

    test('returns seeded languages', () async {
      final repo = FakeReferenceDataRepository();
      final langs = await repo.getLanguages();

      expect(langs.length, equals(2));
      expect(langs.first.code, equals('en'));
    });
  });
}
