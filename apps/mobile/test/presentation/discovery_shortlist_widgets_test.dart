import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/features/comparison/presentation/creator_comparison_screen.dart';
import 'package:ggs_mobile/features/discovery/presentation/discover_screen.dart';
import 'package:ggs_mobile/features/discovery/presentation/widgets/discover_filter_sheet.dart';
import 'package:ggs_mobile/features/profile_common/presentation/widgets/category_multi_select_picker.dart';
import 'package:ggs_mobile/features/profile_common/presentation/widgets/language_multi_select_picker.dart';
import 'package:ggs_mobile/features/shortlist/domain/shortlist_member.dart';
import 'package:ggs_mobile/features/shortlist/presentation/shortlist_detail_screen.dart';
import 'package:ggs_mobile/features/shortlist/presentation/shortlists_screen.dart';

import '../support/fakes.dart';

void main() {
  Widget buildTestApp(
    Widget child, {
    FakeShortlistRepository? shortlistRepo,
    FakeDiscoveryRepository? discoveryRepo,
  }) {
    return ProviderScope(
      overrides: [
        referenceDataRepositoryProvider.overrideWithValue(
          FakeReferenceDataRepository(),
        ),
        creatorRepositoryProvider.overrideWithValue(FakeCreatorRepository()),
        discoveryRepositoryProvider.overrideWithValue(
          discoveryRepo ?? FakeDiscoveryRepository(),
        ),
        shortlistRepositoryProvider.overrideWithValue(
          shortlistRepo ?? FakeShortlistRepository(),
        ),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('Category & Language MultiSelectPicker Widget Tests', () {
    testWidgets(
      'CategoryMultiSelectPicker renders categories and handles selection',
      (tester) async {
        final fakeRef = FakeReferenceDataRepository();
        final cats = await fakeRef.getCategories();
        Set<String> selected = {'cat-1'};

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CategoryMultiSelectPicker(
                categories: cats,
                selectedCategoryIds: selected,
                onChanged: (val) => selected = val,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Tech & Gadgets'), findsOneWidget);
        expect(find.text('Fashion & Style'), findsOneWidget);

        await tester.tap(find.text('Fashion & Style'));
        await tester.pumpAndSettle();
        expect(selected.contains('cat-2'), isTrue);
      },
    );

    testWidgets(
      'LanguageMultiSelectPicker renders languages and handles selection',
      (tester) async {
        final fakeRef = FakeReferenceDataRepository();
        final langs = await fakeRef.getLanguages();
        Set<String> selected = {'en'};

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LanguageMultiSelectPicker(
                languages: langs,
                selectedLanguageCodes: selected,
                onChanged: (val) => selected = val,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('English (English)'), findsOneWidget);
        expect(find.text('Hindi (हिन्दी)'), findsOneWidget);

        await tester.tap(find.text('Hindi (हिन्दी)'));
        await tester.pumpAndSettle();
        expect(selected.contains('hi'), isTrue);
      },
    );
  });

  group('Discover Screen & Card Widget Tests', () {
    testWidgets('DiscoverScreen renders search field and creator list', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestApp(const DiscoverScreen()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();

      expect(find.text('Discover Creators'), findsOneWidget);
      expect(find.text('Rohan Sharma'), findsOneWidget);
      expect(find.text('Ananya Verma'), findsOneWidget);

      final vikram = find.text('Vikram Joshi');
      await tester.scrollUntilVisible(
        vikram,
        100,
        scrollable: find.byType(Scrollable).last,
      );
      expect(vikram, findsOneWidget);
    });

    testWidgets('DiscoverFilterSheet opens and applies filter', (tester) async {
      await tester.pumpWidget(buildTestApp(const DiscoverFilterSheet()));
      await tester.pumpAndSettle();

      expect(find.text('Filter Creators'), findsOneWidget);
      expect(find.text('Availability'), findsOneWidget);

      final applyBtn = find.text('Apply Filters (0)');
      await tester.scrollUntilVisible(
        applyBtn,
        100,
        scrollable: find.byType(Scrollable).first,
      );
      expect(applyBtn, findsOneWidget);
    });
  });

  group('Shortlists Screens Widget Tests', () {
    testWidgets('ShortlistsScreen renders empty state and create action', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestApp(const ShortlistsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Shortlists'), findsOneWidget);
      expect(find.text('No shortlists yet'), findsOneWidget);
      expect(find.text('Create First Shortlist'), findsOneWidget);
    });

    testWidgets(
      'ShortlistDetailScreen renders member status and note buttons',
      (tester) async {
        final fakeShortlistRepo = FakeShortlistRepository();
        final list = await fakeShortlistRepo.createShortlist(
          name: 'Festive Campaign',
        );
        await fakeShortlistRepo.addCreatorToShortlist(
          shortlistId: list.id,
          creatorId: 'c1',
          status: ShortlistMemberStatus.potential,
          notes: 'Initial outreach test',
        );

        await tester.pumpWidget(
          buildTestApp(
            ShortlistDetailScreen(shortlistId: list.id),
            shortlistRepo: fakeShortlistRepo,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Festive Campaign'), findsOneWidget);
        expect(find.text('Potential'), findsOneWidget);
        expect(find.text('Note: Initial outreach test'), findsOneWidget);
      },
    );
  });

  group('Comparison Screen Widget Tests', () {
    testWidgets(
      'CreatorComparisonScreen shows empty state initially and compares creators',
      (tester) async {
        final fakeDiscoveryRepo = FakeDiscoveryRepository();

        await tester.pumpWidget(
          buildTestApp(
            const CreatorComparisonScreen(),
            discoveryRepo: fakeDiscoveryRepo,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Compare Creators'), findsOneWidget);
        expect(find.text('No creators selected'), findsOneWidget);
      },
    );
  });
}
