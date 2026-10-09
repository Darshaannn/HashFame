import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/config/app_config.dart';
import 'package:ggs_mobile/demo/demo_repositories.dart';
import 'package:ggs_mobile/demo/demo_store.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/activity/presentation/activity_screen.dart';
import 'package:ggs_mobile/features/campaign/presentation/campaign_applicant_dashboard_screen.dart';
import 'package:ggs_mobile/features/collaboration/presentation/collaboration_workspace_screen.dart';

void main() {
  late DemoStore store;
  late DemoAuthRepository authRepo;
  late DemoAccountRepository accountRepo;
  late DemoCampaignRepository campaignRepo;
  late DemoCollaborationRepository collabRepo;
  late DemoActivityRepository activityRepo;

  setUp(() {
    store = DemoStore.instance;
    store.reset();
    authRepo = DemoAuthRepository(store);
    accountRepo = DemoAccountRepository(store);
    campaignRepo = DemoCampaignRepository(store);
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
        campaignRepositoryProvider.overrideWithValue(campaignRepo),
        collaborationRepositoryProvider.overrideWithValue(collabRepo),
        activityRepositoryProvider.overrideWithValue(activityRepo),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('End-to-End Marketplace Journey Tests', () {
    testWidgets(
      'Brand selects applicant -> Collaboration workspace created -> Creator submits deliverable -> Brand approves -> Completed',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        // 1. Brand Flow: Review and Select Creator
        store.currentRole = ProfessionalRole.brandMarketer;

        await tester.pumpWidget(
          buildTestApp(
            const CampaignApplicantDashboardScreen(
              campaignId: 'camp_glow_forward',
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          find.text(
            'Glow Forward — Festive Beauty Creator Campaign • Applicants',
          ),
          findsOneWidget,
        );
        expect(find.text('Slots Filled: 1 / 5'), findsOneWidget);

        // Select Aisha Mehta
        final selectBtn = find.widgetWithText(FilledButton, 'Select').first;
        await tester.tap(selectBtn);
        await tester.pumpAndSettle();

        // Verify status changed to Selected and Collaboration Workspace button appears
        expect(find.text('Slots Filled: 2 / 5'), findsOneWidget);
        expect(find.text('Collaboration Workspace'), findsWidgets);

        // 2. Creator Flow: Creator opens Active Collaboration
        store.currentRole = ProfessionalRole.creator;

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
        expect(find.text('In Progress'), findsOneWidget);

        // Creator submits revision/content in Deliverables Tab
        await tester.tap(find.text('Deliverables'));
        await tester.pumpAndSettle();

        expect(find.text('Submit Work'), findsOneWidget);
        await tester.tap(find.text('Submit Work'));
        await tester.pumpAndSettle();

        // Fill dialog
        await tester.enterText(
          find.widgetWithText(
            TextField,
            'Content Link (Drive / Dropbox / Unlisted)',
          ),
          'https://drive.google.com/file/d/final-approved-v2/view',
        );
        await tester.tap(find.text('Submit Content'));
        await tester.pumpAndSettle();

        expect(find.text('Under Review'), findsWidgets);

        // 3. Brand Flow: Review and Approve Deliverable
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

        expect(find.text('Approve Content'), findsWidgets);
        await tester.tap(find.text('Approve Content').first);
        await tester.pumpAndSettle();

        expect(find.text('Approved'), findsWidgets);

        // 4. Brand completes collaboration
        await tester.tap(find.text('Workspace'));
        await tester.pumpAndSettle();

        expect(find.text('Complete'), findsOneWidget);
        await tester.tap(find.text('Complete'));
        await tester.pumpAndSettle();

        // Confirm dialog
        await tester.tap(find.widgetWithText(FilledButton, 'Complete').last);
        await tester.pumpAndSettle();

        expect(find.text('Completed'), findsWidgets);
        expect(
          find.text(
            'This collaboration has been fully completed and approved! 🎉',
          ),
          findsOneWidget,
        );

        // 5. Creator Activity Feed: Live updates recorded
        await tester.pumpWidget(buildTestApp(const ActivityScreen()));
        await tester.pumpAndSettle();

        expect(find.text('Activity Feed'), findsOneWidget);
        expect(find.textContaining('Collaboration Completed'), findsOneWidget);
      },
    );
  });
}
