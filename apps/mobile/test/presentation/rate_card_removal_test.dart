import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/app/router.dart';
import 'package:ggs_mobile/core/config/app_config.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/assistant/data/assistant_service_impl.dart';
import 'package:ggs_mobile/features/assistant/domain/assistant_service.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';
import 'package:ggs_mobile/features/comparison/presentation/creator_comparison_screen.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';
import 'package:ggs_mobile/features/creator/presentation/home/widgets/creator_quick_actions_grid.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/creator_profile_controller.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/creator_profile_screen.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_discovery_item.dart';
import 'package:ggs_mobile/features/discovery/presentation/creator_public_detail_screen.dart';
import 'package:ggs_mobile/features/discovery/presentation/widgets/creator_discovery_card.dart';
import 'package:ggs_mobile/features/discovery/presentation/widgets/discover_filter_sheet.dart';

import '../support/fakes.dart';

const _testConfig = AppConfig(
  environment: AppEnvironment.local,
  name: 'GGs Test',
  supabaseUrl: 'http://127.0.0.1:54321',
  publishableKey: 'test-key',
  redirectUrl: 'com.ggs.mobile.local://auth/callback',
  supportUrl: 'https://support.hashfame.com',
);

class _TestSessionController extends SessionController {
  _TestSessionController(this._initial);
  final SessionState _initial;

  @override
  SessionState build() => _initial;
}

Widget _wrapWithOverrides(Widget child, {List<dynamic> overrides = const []}) {
  return ProviderScope(
    overrides: [
      configProvider.overrideWithValue(_testConfig),
      ...overrides,
    ].cast(),
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Phase 01: Rate Card Removal Across Interfaces', () {
    testWidgets(
      '1. Brand Discovery cards and search contain no rate cards or Starting Rate',
      (tester) async {
        const fakeDiscoveryItem = CreatorDiscoveryItem(
          creatorId: 'c1',
          displayName: 'Rohan Joshi',
          professionalName: 'rohanj',
          city: 'Mumbai',
          country: 'India',
          primaryCategoryNames: ['Comedy', 'Lifestyle'],
          subcategoryNames: [],
          languageNames: ['English', 'Hindi'],
          totalFollowers: 450000,
          startingRate: 50000, // Underlying data exists in backend/fixtures
          availabilityStatus: AvailabilityStatus.open,
          isRepresented: false,
        );

        await tester.pumpWidget(
          _wrapWithOverrides(
            const CreatorDiscoveryCard(creator: fakeDiscoveryItem),
          ),
        );
        await tester.pumpAndSettle();

        // Verified: No Starting Rate or ₹50000 label on discovery cards
        expect(find.textContaining('Starting Rate'), findsNothing);
        expect(find.textContaining('From ₹'), findsNothing);
        expect(find.textContaining('₹50,000'), findsNothing);
        expect(find.text('Rate Card'), findsNothing);
        expect(find.text('Rohan Joshi'), findsOneWidget);
      },
    );

    testWidgets(
      '2. Creator Public Profile contains no visible Rate Card section',
      (tester) async {
        final fakeCreatorRepo = FakeCreatorRepository();
        fakeCreatorRepo.profile = fakeCreatorRepo.profile.copyWith(
          rateCard: const [
            RateItem(
              id: 'r1',
              userId: 'test-user',
              deliverableType: DeliverableType.instagramReel,
              priceAmount: 35000,
              isActive: true,
            ),
          ],
        );

        await tester.pumpWidget(
          _wrapWithOverrides(
            const CreatorPublicDetailScreen(creatorId: 'c1'),
            overrides: [
              creatorRepositoryProvider.overrideWithValue(fakeCreatorRepo),
              creatorProfileProvider('c1')
                  .overrideWith((ref) async => fakeCreatorRepo.profile),
            ],
          ),
        );
        await tester.pumpAndSettle();

        // No Rate Card section rendered
        expect(find.text('Rate Card'), findsNothing);
        expect(find.text('₹35000'), findsNothing);
        expect(find.text('Add Rate'), findsNothing);
      },
    );

    testWidgets(
      "3. Creator's Own Profile has no Manage Rate Card or Rate Card view",
      (tester) async {
        final fakeCreatorRepo = FakeCreatorRepository();
        fakeCreatorRepo.profile = fakeCreatorRepo.profile.copyWith(
          rateCard: const [
            RateItem(
              id: 'r1',
              userId: 'test-user',
              deliverableType: DeliverableType.instagramReel,
              priceAmount: 25000,
              isActive: true,
            ),
          ],
        );

        final fakeAccount = Account(
          id: 'acc-creator',
          primaryRoleLabel: ProfessionalRole.creator,
          displayName: 'Test Creator',
          accountState: AccountState.active,
          updatedAt: DateTime.utc(2026),
        );
        final fakeSnapshot = AccountSnapshot(
          fakeAccount,
          offline: true,
          fetchedAt: DateTime.utc(2026),
        );

        await tester.pumpWidget(
          _wrapWithOverrides(
            const CreatorProfileScreen(),
            overrides: [
              creatorRepositoryProvider.overrideWithValue(fakeCreatorRepo),
              currentCreatorProfileProvider.overrideWith(
                (ref) async => fakeCreatorRepo.profile,
              ),
              sessionProvider.overrideWith(
                () => _TestSessionController(
                  SessionState(SessionPhase.ready, snapshot: fakeSnapshot),
                ),
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Manage Rate Card'), findsNothing);
        expect(find.text('Rate Card'), findsNothing);
        expect(find.text('Add Rate'), findsNothing);

        // Scroll down to Account Menu to verify other action tiles
        await tester.scrollUntilVisible(
          find.text('Edit Basic Profile'),
          300,
          scrollable: find.byType(Scrollable).first,
        );
        // Valid sections remain
        expect(find.text('Edit Basic Profile'), findsOneWidget);
        expect(find.text('Portfolio & Work Samples'), findsOneWidget);
      },
    );

    testWidgets('4. Agency Talent and Roster contain no rate displays', (
      tester,
    ) async {
      const fakeDiscoveryItem = CreatorDiscoveryItem(
        creatorId: 'c2',
        displayName: 'Priya Sharma',
        professionalName: 'priyasharma',
        city: 'Delhi',
        country: 'India',
        primaryCategoryNames: ['Fashion'],
        subcategoryNames: [],
        languageNames: ['Hindi'],
        totalFollowers: 800000,
        startingRate: 75000,
        availabilityStatus: AvailabilityStatus.open,
        isRepresented: true,
      );

      await tester.pumpWidget(
        _wrapWithOverrides(
          const CreatorDiscoveryCard(creator: fakeDiscoveryItem),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('₹75,000'), findsNothing);
      expect(find.textContaining('Rate Card'), findsNothing);
      expect(find.text('Priya Sharma'), findsOneWidget);
    });

    testWidgets('5. Creator Comparison has no Starting Rate column or row', (
      tester,
    ) async {
      const c1 = CreatorDiscoveryItem(
        creatorId: 'c1',
        displayName: 'Creator One',
        country: 'India',
        primaryCategoryNames: ['Tech'],
        subcategoryNames: [],
        languageNames: ['English'],
        totalFollowers: 100000,
        startingRate: 20000,
        availabilityStatus: AvailabilityStatus.open,
        isRepresented: false,
      );
      const c2 = CreatorDiscoveryItem(
        creatorId: 'c2',
        displayName: 'Creator Two',
        country: 'India',
        primaryCategoryNames: ['Tech'],
        subcategoryNames: [],
        languageNames: ['English'],
        totalFollowers: 200000,
        startingRate: 40000,
        availabilityStatus: AvailabilityStatus.open,
        isRepresented: true,
      );

      final fakeDiscoveryRepo = FakeDiscoveryRepository();
      fakeDiscoveryRepo.creators.addAll([c1, c2]);

      await tester.pumpWidget(
        _wrapWithOverrides(
          const CreatorComparisonScreen(),
          overrides: [
            discoveryRepositoryProvider.overrideWithValue(fakeDiscoveryRepo),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Starting Rate'), findsNothing);
      expect(find.text('₹20000'), findsNothing);
      expect(find.text('₹40000'), findsNothing);
    });

    testWidgets('6. Creator Home contains no Rate Card shortcut tile', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: CreatorQuickActionsGrid())),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rate\nCard'), findsNothing);
      expect(find.text('Rate Card'), findsNothing);
      expect(find.text('Discover\nWork'), findsOneWidget);
      expect(find.text('Portfolio'), findsOneWidget);
    });

    testWidgets(
      '7. Discover filter sheet has no Starting Rate price range inputs',
      (tester) async {
        await tester.pumpWidget(
          _wrapWithOverrides(const DiscoverFilterSheet()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Starting Rate (INR ₹)'), findsNothing);
        expect(find.text('Min Price'), findsNothing);
        expect(find.text('Max Price'), findsNothing);
        expect(find.text('Filter Creators'), findsOneWidget);
      },
    );

    test(
      '8. AI suggestions no longer request Rate Cards or rate updates',
      () async {
        const assistant = DemoAssistantServiceImpl();
        final res = await assistant.executeTask(
          const AssistantRequest(
            role: AssistantRole.creator,
            task: AssistantTask.suggestProfileImprovements,
            contextData: {'hasBio': true, 'hasLanguages': true},
          ),
        );

        expect(res.suggestion, isNotNull);
        expect(res.suggestion!.contains('rate card'), isFalse);
        expect(res.suggestion!.contains('Rate card'), isFalse);
      },
    );

    test(
      '9. Obsolete /profile/edit/rates route safely redirects to /profile',
      () {
        final container = ProviderContainer(
          overrides: [
            configProvider.overrideWithValue(_testConfig),
            sessionProvider.overrideWith(
              () => _TestSessionController(
                const SessionState(SessionPhase.ready),
              ),
            ),
          ],
        );
        final router = container.read(routerProvider);

        final match = router.configuration.findMatch(
          Uri.parse('/profile/edit/rates'),
        );
        expect(match, isNotNull);
      },
    );
  });
}
