import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/config/app_config.dart';
import 'package:ggs_mobile/demo/demo_repositories.dart';
import 'package:ggs_mobile/demo/demo_store.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/collaboration/presentation/collaboration_workspace_screen.dart';

void main() {
  late DemoStore store;
  late DemoAuthRepository authRepo;
  late DemoAccountRepository accountRepo;
  late DemoCollaborationRepository collabRepo;
  late DemoActivityRepository activityRepo;

  setUp(() {
    store = DemoStore.instance;
    store.reset();
    authRepo = DemoAuthRepository(store);
    accountRepo = DemoAccountRepository(store);
    collabRepo = DemoCollaborationRepository(store);
    activityRepo = DemoActivityRepository(store);
  });

  Widget buildTestApp(Widget child) {
    return ProviderScope(
      overrides: [
        configProvider.overrideWithValue(
          const AppConfig(
            environment: AppEnvironment.local,
            name: 'GGs Demo',
            supabaseUrl: 'http://127.0.0.1:54321',
            publishableKey: 'sb_publishable_demo_mode',
            redirectUrl: 'com.ggs.mobile.local://auth/callback',
            supportUrl: 'https://support.hashfame.com',
          ),
        ),
        authRepositoryProvider.overrideWithValue(authRepo),
        accountRepositoryProvider.overrideWithValue(accountRepo),
        collaborationRepositoryProvider.overrideWithValue(collabRepo),
        activityRepositoryProvider.overrideWithValue(activityRepo),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('Collaboration & Messaging Integration Tests', () {
    testWidgets('Workspace renders tabs, requirements and overview', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          const CollaborationWorkspaceScreen(
            collaborationId: 'collab_aisha_glow',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Glow Forward — Festive Beauty Creator Campaign'),
        findsWidgets,
      );
      expect(find.text('Workspace'), findsOneWidget);
      expect(find.text('Deliverables'), findsOneWidget);
      expect(find.text('Messages'), findsOneWidget);
      expect(find.text('Deliverable Requirements'), findsOneWidget);
      expect(find.textContaining('Compensation: ₹25000 INR'), findsOneWidget);
    });

    testWidgets(
      'Deliverables tab renders submissions and supports submission',
      (tester) async {
        await tester.pumpWidget(
          buildTestApp(
            const CollaborationWorkspaceScreen(
              collaborationId: 'collab_aisha_glow',
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Switch to Deliverables Tab
        await tester.tap(find.text('Deliverables'));
        await tester.pumpAndSettle();

        expect(find.text('Submission History'), findsOneWidget);
        expect(find.textContaining('Instagram Reel Draft 1'), findsOneWidget);
        expect(find.text('Under Review'), findsOneWidget);
      },
    );

    testWidgets('Messages tab renders conversation and sends message', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          const CollaborationWorkspaceScreen(
            collaborationId: 'collab_aisha_glow',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Switch to Messages Tab
      await tester.tap(find.text('Messages'));
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Hi Aisha! Thrilled to have you on board'),
        findsOneWidget,
      );
      expect(find.textContaining('Just uploaded Draft 1'), findsOneWidget);

      // Type and send a new message
      await tester.enterText(
        find.byType(TextField),
        'Looks amazing, approved for publishing!',
      );
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      expect(
        find.text('Looks amazing, approved for publishing!'),
        findsOneWidget,
      );
    });

    testWidgets('Brand Review & Approval workflow updates deliverable status', (
      tester,
    ) async {
      // Set role to Brand
      store.currentRole = ProfessionalRole.brandMarketer;

      await tester.pumpWidget(
        buildTestApp(
          const CollaborationWorkspaceScreen(
            collaborationId: 'collab_aisha_glow',
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Deliverables'));
      await tester.pumpAndSettle();

      expect(find.text('Approve Content'), findsOneWidget);
      expect(find.text('Request Revision'), findsOneWidget);

      // Approve content
      await tester.tap(find.text('Approve Content'));
      await tester.pumpAndSettle();

      expect(find.text('Approved'), findsWidgets);
    });
  });
}
