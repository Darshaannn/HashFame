import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/app.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/config/app_config.dart';
import 'package:ggs_mobile/demo/demo_repositories.dart';
import 'package:ggs_mobile/demo/demo_store.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';

Widget createTestApp({ProfessionalRole? initialRole}) {
  final store = DemoStore.instance;
  store.reset();
  if (initialRole != null) {
    store.currentRole = initialRole;
  }

  final authRepo = DemoAuthRepository(store);
  final accountRepo = DemoAccountRepository(store);
  final refDataRepo = DemoReferenceDataRepository(store);
  final creatorRepo = DemoCreatorRepository(store);
  final brandRepo = DemoBrandRepository(store);
  final agencyRepo = DemoAgencyRepository(store);
  final talentManagerRepo = DemoTalentManagerRepository(store);
  final discoveryRepo = DemoDiscoveryRepository(store);
  final shortlistRepo = DemoShortlistRepository(store);
  final campaignRepo = DemoCampaignRepository(store);

  const testConfig = AppConfig(
    environment: AppEnvironment.local,
    name: 'GGs Demo',
    supabaseUrl: 'http://localhost',
    publishableKey: 'sb_publishable_demo_test',
    redirectUrl: 'com.ggs.mobile.local://auth/callback',
    supportUrl: 'https://support.ggs.platform',
    firebaseEnabled: false,
  );

  return ProviderScope(
    overrides: [
      configProvider.overrideWithValue(testConfig),
      authRepositoryProvider.overrideWithValue(authRepo),
      accountRepositoryProvider.overrideWithValue(accountRepo),
      referenceDataRepositoryProvider.overrideWithValue(refDataRepo),
      creatorRepositoryProvider.overrideWithValue(creatorRepo),
      brandRepositoryProvider.overrideWithValue(brandRepo),
      agencyRepositoryProvider.overrideWithValue(agencyRepo),
      talentManagerRepositoryProvider.overrideWithValue(talentManagerRepo),
      discoveryRepositoryProvider.overrideWithValue(discoveryRepo),
      shortlistRepositoryProvider.overrideWithValue(shortlistRepo),
      campaignRepositoryProvider.overrideWithValue(campaignRepo),
    ],
    child: const FoundationApp(),
  );
}

void main() {
  setUp(() {
    DemoStore.instance.reset();
  });

  group('Navigation & Session Flow Integration Tests', () {
    testWidgets('Demo Launcher renders and navigates to Brand Home', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('VIEW AS BRAND'), findsOneWidget);
      expect(find.text('VIEW AS CREATOR'), findsOneWidget);
      expect(find.text('View as Agency'), findsOneWidget);

      await tester.tap(find.text('VIEW AS BRAND'));
      await tester.pumpAndSettle();

      expect(find.text('Brand Workspace'), findsOneWidget);
      expect(find.text('Discover Creators'), findsOneWidget);
    });

    testWidgets('Brand Bottom Navigation switches across tabs seamlessly', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('VIEW AS BRAND'));
      await tester.pumpAndSettle();

      // Home Tab
      expect(find.text('Brand Workspace'), findsOneWidget);

      // Tap Profile Tab (Tab 4) from Brand Home Shell
      await tester.tap(find.widgetWithText(NavigationDestination, 'Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Brand Profile'), findsOneWidget);
      expect(find.text('Edit Brand Profile'), findsOneWidget);
      expect(find.text('Account Settings'), findsOneWidget);

      // Tap Home Tab (Tab 0) from Profile Shell
      await tester.tap(find.widgetWithText(NavigationDestination, 'Home'));
      await tester.pumpAndSettle();
      expect(find.text('Brand Workspace'), findsOneWidget);

      // Tap Discover Tab (Tab 1)
      await tester.tap(find.widgetWithText(NavigationDestination, 'Discover'));
      await tester.pumpAndSettle();
      expect(find.text('Discover Creators'), findsOneWidget);
    });

    testWidgets(
      'Creator navigation through tabs including Activity & Profile',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('VIEW AS CREATOR'));
        await tester.pumpAndSettle();

        // Home Tab
        expect(find.text('Creator Home'), findsOneWidget);

        // Tap Profile (Tab 4) from Creator Shell
        await tester.tap(find.widgetWithText(NavigationDestination, 'Profile'));
        await tester.pumpAndSettle();
        expect(find.text('My Creator Profile'), findsOneWidget);
        expect(find.text('Profile Completeness'), findsOneWidget);
        expect(find.text('Bio & About'), findsOneWidget);

        // Tap Home back from Profile
        await tester.tap(find.widgetWithText(NavigationDestination, 'Home'));
        await tester.pumpAndSettle();
        expect(find.text('Creator Home'), findsOneWidget);

        // Tap Activity (Tab 3)
        await tester.tap(
          find.widgetWithText(NavigationDestination, 'Activity'),
        );
        await tester.pumpAndSettle();
        expect(find.text('Activity Feed'), findsOneWidget);
      },
    );

    testWidgets('Agency navigation through tabs including Talent & Profile', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('View as Agency'));
      await tester.pumpAndSettle();

      // Home Tab
      expect(find.text('Agency Workspace'), findsOneWidget);

      // Tap Profile (Tab 4) from Agency Shell
      await tester.tap(find.widgetWithText(NavigationDestination, 'Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Agency Profile'), findsOneWidget);
      expect(find.text('Edit Agency Profile'), findsOneWidget);

      // Tap Home back from Profile
      await tester.tap(find.widgetWithText(NavigationDestination, 'Home'));
      await tester.pumpAndSettle();
      expect(find.text('Agency Workspace'), findsOneWidget);

      // Tap Talent (Tab 3)
      await tester.tap(find.widgetWithText(NavigationDestination, 'Talent'));
      await tester.pumpAndSettle();
      expect(find.text('Managed Talent Roster'), findsOneWidget);
    });

    testWidgets(
      'Settings screen loads with cohesive sections and back navigation',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('VIEW AS BRAND'));
        await tester.pumpAndSettle();

        // Navigate to Settings
        await tester.tap(find.byIcon(Icons.settings_outlined).first);
        await tester.pumpAndSettle();

        expect(find.text('Settings & Preferences'), findsOneWidget);
        expect(find.text('ACCOUNT INFORMATION'), findsOneWidget);
        expect(find.text('PREFERENCES'), findsOneWidget);
        expect(find.text('SECURITY'), findsOneWidget);

        // Back navigation
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();

        expect(find.text('Brand Workspace'), findsOneWidget);
      },
    );

    testWidgets(
      'Sign Out dialog in Demo Mode returns safely to Demo Launcher',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('VIEW AS BRAND'));
        await tester.pumpAndSettle();

        // Go to Profile
        await tester.tap(find.widgetWithText(NavigationDestination, 'Profile'));
        await tester.pumpAndSettle();

        // Scroll to ensure Sign Out is visible if necessary
        final signOutTile = find.widgetWithText(ListTile, 'Sign Out');
        await tester.ensureVisible(signOutTile);
        await tester.tap(signOutTile);
        await tester.pumpAndSettle();

        // Sign Out Confirmation Dialog
        expect(find.text('Sign out?'), findsOneWidget);
        expect(
          find.text('You\'ll need to sign in again to access your account.'),
          findsOneWidget,
        );

        // Tap Confirm Sign Out
        await tester.tap(find.widgetWithText(FilledButton, 'Sign Out'));
        await tester.pumpAndSettle();

        // Returned to Demo Launcher
        expect(find.text('VIEW AS BRAND'), findsOneWidget);
        expect(find.text('VIEW AS CREATOR'), findsOneWidget);
      },
    );
  });
}
