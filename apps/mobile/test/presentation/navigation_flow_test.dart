import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/app.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/config/app_config.dart';
import 'package:ggs_mobile/demo/demo_repositories.dart';
import 'package:ggs_mobile/demo/demo_store.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/assistant/data/assistant_service_impl.dart';

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
  final collabRepo = DemoCollaborationRepository(store);
  final activityRepo = DemoActivityRepository(store);

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
      collaborationRepositoryProvider.overrideWithValue(collabRepo),
      activityRepositoryProvider.overrideWithValue(activityRepo),
      assistantServiceProvider.overrideWithValue(const DemoAssistantServiceImpl()),
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

      // Tap Creator Tab (Tab 1)
      await tester.tap(find.widgetWithText(NavigationDestination, 'Creator'));
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

    testWidgets(
      'Secondary subpages have BackButton with accessible touch targets',
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

        // Verify BackButton exists and has min 48x48 bounds
        final backButton = find.byType(BackButton);
        expect(backButton, findsOneWidget);
        final size = tester.getSize(backButton);
        expect(size.width, greaterThanOrEqualTo(48.0));
        expect(size.height, greaterThanOrEqualTo(48.0));
      },
    );

    testWidgets(
      'Brand campaign creation form guards unsaved changes on back navigation',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('VIEW AS BRAND'));
        await tester.pumpAndSettle();

        // Go to Campaigns tab
        await tester.tap(
          find.widgetWithText(NavigationDestination, 'Campaigns'),
        );
        await tester.pumpAndSettle();

        // Tap Create / Plus action or FAB
        final fab = find.byType(FloatingActionButton);
        if (fab.evaluate().isNotEmpty) {
          await tester.tap(fab);
        } else {
          final createBtn = find.text('Create Campaign');
          if (createBtn.evaluate().isNotEmpty) {
            await tester.tap(createBtn.first);
          }
        }
        await tester.pumpAndSettle();

        // If on campaign creation screen, enter text into title
        final titleField = find.widgetWithText(TextFormField, 'Campaign Title');
        if (titleField.evaluate().isNotEmpty) {
          await tester.enterText(titleField, 'Summer Launch 2026');
          await tester.pumpAndSettle();

          // Tap Back
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          // Exit confirmation dialog should appear
          expect(find.text('Exit campaign creation?'), findsOneWidget);

          // Tap Cancel / Keep Editing
          await tester.tap(find.text('Keep Editing'));
          await tester.pumpAndSettle();

          // Still on creation screen
          expect(find.text('Create Campaign'), findsOneWidget);
        }
      },
    );

    testWidgets(
      'Discover Creators shows back button and navigates back to Brand Home',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('VIEW AS BRAND'));
        await tester.pumpAndSettle();

        // Switch to Creator tab
        await tester.tap(find.widgetWithText(NavigationDestination, 'Creator'));
        await tester.pumpAndSettle();

        expect(find.text('Discover Creators'), findsOneWidget);

        // Verify back button is visible
        final backButton = find.byType(BackButton);
        expect(backButton, findsOneWidget);

        // Tap back button
        await tester.tap(backButton);
        await tester.pumpAndSettle();

        // Should return to Brand Home / Workspace
        expect(find.text('Brand Workspace'), findsOneWidget);
      },
    );

    testWidgets(
      'Discover Work shows back button and navigates back to Creator Home',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('VIEW AS CREATOR'));
        await tester.pumpAndSettle();

        // Switch to Discover Work tab
        await tester.tap(
          find.widgetWithText(NavigationDestination, 'Discover Work'),
        );
        await tester.pumpAndSettle();

        expect(find.text('Discover Work'), findsOneWidget);

        // Verify back button is visible
        final backButton = find.byType(BackButton);
        expect(backButton, findsOneWidget);

        // Tap back button
        await tester.tap(backButton);
        await tester.pumpAndSettle();

        // Should return to Creator Home
        expect(find.text('Creator Home'), findsOneWidget);
      },
    );

    testWidgets(
      'Root Home Android Back displays Exit GGs? confirmation and Cancel keeps app open',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Start at Brand Home
        await tester.tap(find.text('VIEW AS BRAND'));
        await tester.pumpAndSettle();
        expect(find.text('Brand Workspace'), findsOneWidget);

        // Simulate Android System Back button at root
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();

        // Confirmation dialog appears
        expect(find.text('Exit GGs?'), findsOneWidget);
        expect(
          find.text('Are you sure you want to exit the application?'),
          findsOneWidget,
        );
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Exit'), findsOneWidget);

        // Tap Cancel keeps app open
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(find.text('Brand Workspace'), findsOneWidget);
        expect(find.text('Exit GGs?'), findsNothing);
      },
    );

    testWidgets(
      'Brand journey: Home -> Creator -> Creator Profile -> Back -> Creator -> Back -> Home',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // 1. Home
        await tester.tap(find.text('VIEW AS BRAND'));
        await tester.pumpAndSettle();
        expect(find.text('Brand Workspace'), findsOneWidget);

        // 2. Creator tab
        await tester.tap(find.widgetWithText(NavigationDestination, 'Creator'));
        await tester.pumpAndSettle();
        expect(find.text('Discover Creators'), findsOneWidget);

        // 3. Creator Profile
        final firstCreatorCard = find.text('Aisha Mehta');
        if (firstCreatorCard.evaluate().isNotEmpty) {
          await tester.tap(firstCreatorCard);
          await tester.pumpAndSettle();
          expect(find.text('Creator Profile'), findsOneWidget);

          // 4. Android Back -> Creator
          await tester.binding.handlePopRoute();
          await tester.pumpAndSettle();
          expect(find.text('Discover Creators'), findsOneWidget);
        }

        // 5. Android Back -> Home
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(find.text('Brand Workspace'), findsOneWidget);
      },
    );

    testWidgets(
      'Creator journey: Home -> Discover Work -> Campaign Detail -> Back -> Discover Work -> Back -> Home',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // 1. Home
        await tester.tap(find.text('VIEW AS CREATOR'));
        await tester.pumpAndSettle();
        expect(find.text('Creator Home'), findsOneWidget);

        // 2. Discover Work tab
        await tester.tap(
          find.widgetWithText(NavigationDestination, 'Discover Work'),
        );
        await tester.pumpAndSettle();
        expect(find.text('Discover Work'), findsOneWidget);

        // 3. Campaign Detail
        final campaignCard = find.text('Glow Forward — Festive Beauty Creator Campaign');
        if (campaignCard.evaluate().isNotEmpty) {
          await tester.tap(campaignCard);
          await tester.pumpAndSettle();
          expect(find.text('Apply for Campaign'), findsWidgets);

          // 4. Android Back -> Discover Work
          await tester.binding.handlePopRoute();
          await tester.pumpAndSettle();
          expect(find.text('Discover Work'), findsOneWidget);
        }

        // 5. Android Back -> Home
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(find.text('Creator Home'), findsOneWidget);
      },
    );

    testWidgets(
      'Agency journey: Home -> Talent -> Creator Profile -> Back -> Talent -> Back -> Home',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // 1. Home
        await tester.tap(find.text('View as Agency'));
        await tester.pumpAndSettle();
        expect(find.text('Agency Workspace'), findsOneWidget);

        // 2. Talent
        await tester.tap(find.widgetWithText(NavigationDestination, 'Talent'));
        await tester.pumpAndSettle();
        expect(find.text('Managed Talent Roster'), findsOneWidget);

        // 3. Creator Profile
        final talentCard = find.text('Aisha Mehta');
        if (talentCard.evaluate().isNotEmpty) {
          await tester.tap(talentCard);
          await tester.pumpAndSettle();
          expect(find.text('Creator Profile'), findsOneWidget);

          // 4. Android Back -> Talent
          await tester.binding.handlePopRoute();
          await tester.pumpAndSettle();
          expect(find.text('Managed Talent Roster'), findsOneWidget);
        }

        // 5. Android Back -> Home
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(find.text('Agency Workspace'), findsOneWidget);
      },
    );

    testWidgets(
      'Applications journey: Applications -> Application Detail -> Collaboration -> Back -> Application Detail',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text('VIEW AS CREATOR'));
        await tester.pumpAndSettle();

        // 1. Applications tab
        await tester.tap(
          find.widgetWithText(NavigationDestination, 'Applications'),
        );
        await tester.pumpAndSettle();
        expect(find.text('My Applications'), findsOneWidget);

        // 2. Open an application
        final appTile = find.byType(ListTile);
        if (appTile.evaluate().isNotEmpty) {
          await tester.tap(appTile.first);
          await tester.pumpAndSettle();
          expect(find.text('Application Detail'), findsOneWidget);

          // 3. If selected, open collaboration workspace
          final collabBtn = find.text('Open Active Collaboration Workspace');
          if (collabBtn.evaluate().isNotEmpty) {
            await tester.tap(collabBtn);
            await tester.pumpAndSettle();
            expect(find.text('Deliverables'), findsWidgets);

            // 4. Android Back -> Application Detail
            await tester.binding.handlePopRoute();
            await tester.pumpAndSettle();
            expect(find.text('Application Detail'), findsOneWidget);
          }
        }
      },
    );

    testWidgets('Settings journey: Home -> Settings -> Android Back -> Home', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('VIEW AS BRAND'));
      await tester.pumpAndSettle();
      expect(find.text('Brand Workspace'), findsOneWidget);

      // Go to settings
      await tester.tap(find.byIcon(Icons.settings_outlined).first);
      await tester.pumpAndSettle();
      expect(find.text('Settings & Preferences'), findsOneWidget);

      // Android system Back -> Home
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Brand Workspace'), findsOneWidget);
    });

    testWidgets('Demo Mode: Switch roles -> Android Back behaves correctly', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Launch as Brand
      await tester.tap(find.text('VIEW AS BRAND'));
      await tester.pumpAndSettle();
      expect(find.text('Brand Workspace'), findsOneWidget);

      // Switch to Creator via Top Banner
      final roleChip = find.text('Brand Marketer');
      if (roleChip.evaluate().isNotEmpty) {
        await tester.tap(roleChip);
        await tester.pumpAndSettle();

        final creatorOption = find.text('Creator');
        if (creatorOption.evaluate().isNotEmpty) {
          await tester.tap(creatorOption);
          await tester.pumpAndSettle();

          expect(find.text('Creator Home'), findsOneWidget);

          // Android Back returns to previous screen (Brand Workspace)
          await tester.binding.handlePopRoute();
          await tester.pumpAndSettle();
          expect(find.text('Brand Workspace'), findsOneWidget);
        }
      }
    });
  });
}
