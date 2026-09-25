import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign.dart';
import 'package:ggs_mobile/features/campaign/presentation/brand_campaigns_screen.dart';
import 'package:ggs_mobile/features/campaign/presentation/campaign_applicant_dashboard_screen.dart';
import 'package:ggs_mobile/features/campaign/presentation/campaign_creation_screen.dart';
import 'package:ggs_mobile/features/campaign/presentation/campaign_detail_screen.dart';
import 'package:ggs_mobile/features/campaign/presentation/creator_applications_screen.dart';
import 'package:ggs_mobile/features/campaign/presentation/creator_opportunities_screen.dart';

import '../support/fakes.dart';

void main() {
  late FakeCampaignRepository campaignRepo;
  late FakeReferenceDataRepository refDataRepo;

  setUp(() {
    campaignRepo = FakeCampaignRepository();
    refDataRepo = FakeReferenceDataRepository();
  });

  Widget buildTestWidget(Widget child) {
    final auth = FakeAuth()..id = '11111111-1111-4111-8111-111111111111';
    final accounts = FakeAccounts()..account = sampleAccount();
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(auth),
        accountRepositoryProvider.overrideWithValue(accounts),
        campaignRepositoryProvider.overrideWithValue(campaignRepo),
        referenceDataRepositoryProvider.overrideWithValue(refDataRepo),
        creatorRepositoryProvider.overrideWithValue(FakeCreatorRepository()),
        brandRepositoryProvider.overrideWithValue(FakeBrandRepository()),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('Campaign Marketplace Widget Tests', () {
    testWidgets(
      'CreatorOpportunitiesScreen displays live campaigns and filter button',
      (tester) async {
        final draft = await campaignRepo.createDraft(
          organizationId: 'org_1',
          title: 'Summer Fashion Lookbook',
          description: 'Create 2 reels showcasing summer collection',
          compensationType: CampaignCompensationType.paid,
          currency: 'INR',
          budgetMin: 12000,
          budgetMax: 18000,
          creatorSlots: 4,
          categoryIds: const ['Fashion & Style'],
          applicationDeadline: DateTime.now().add(const Duration(days: 5)),
        );

        // Moderate to live in fake repo
        await campaignRepo.submitForReview(draft.id);
        await campaignRepo.moderateCampaign(
          campaignId: draft.id,
          action: 'approve',
        );

        await tester.pumpWidget(
          buildTestWidget(const CreatorOpportunitiesScreen()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Discover Work'), findsOneWidget);
        expect(find.text('Summer Fashion Lookbook'), findsOneWidget);
        expect(find.byIcon(Icons.filter_list), findsOneWidget);
      },
    );

    testWidgets(
      'CampaignDetailScreen renders campaign brief, deliverables, usage rights, and apply button',
      (tester) async {
        final campaign = await campaignRepo.createDraft(
          organizationId: 'org_1',
          title: 'Tech Unboxing Campaign',
          objective: 'Promote new flagship smartphone launch',
          description: 'Looking for 3 tech reviewers for comprehensive unboxing & first impressions.',
          compensationType: CampaignCompensationType.paid,
          currency: 'INR',
          budgetMin: 20000,
          budgetMax: 35000,
          creatorSlots: 3,
          categoryIds: const ['Technology & Gadgets'],
          applicationDeadline: DateTime.now().add(const Duration(days: 7)),
          contentDeadline: DateTime.now().add(const Duration(days: 14)),
          deliverables: const [
            CampaignDeliverable(
              id: 'del_1',
              campaignId: 'camp_detail_1',
              deliverableType: CampaignDeliverableType.youtubeVideo,
              platform: 'YouTube',
              quantity: 1,
              description: 'Dedicated 8-10 min review video with buy links in description',
            ),
          ],
          usageRights: const CampaignUsageRights(
            organicRepostingAllowed: true,
            paidUsageRequired: true,
            usageDurationMonths: 6,
            contentApprovalRequired: true,
            disclosureRequired: true,
          ),
        );
        await campaignRepo.submitForReview(campaign.id);
        await campaignRepo.moderateCampaign(
          campaignId: campaign.id,
          action: 'approve',
        );

        await tester.pumpWidget(
          buildTestWidget(CampaignDetailScreen(campaignId: campaign.id)),
        );
        await tester.pumpAndSettle();

        expect(find.text('Tech Unboxing Campaign'), findsAtLeastNWidgets(1));
        expect(find.text('₹20000 - ₹35000'), findsOneWidget);
        expect(find.text('YouTube Dedicated Video (x1)'), findsOneWidget);
        expect(find.text('Paid Ad Usage Required'), findsOneWidget);
        expect(find.text('Apply for Campaign'), findsOneWidget);
      },
    );

    testWidgets(
      'CreatorApplicationsScreen displays submitted application with status tag',
      (tester) async {
        final camp = await campaignRepo.createDraft(
          organizationId: 'org_1',
          title: 'Skincare Routine Video',
          description: 'Skincare review',
        );
        await campaignRepo.submitForReview(camp.id);
        await campaignRepo.moderateCampaign(
          campaignId: camp.id,
          action: 'approve',
        );

        await campaignRepo.submitApplication(
          campaignId: camp.id,
          creatorId: '11111111-1111-4111-8111-111111111111',
          pitch: 'I have tested your brand for 2 years and my audience loves beauty tips!',
          proposedRate: 15000,
        );

        await tester.pumpWidget(
          buildTestWidget(const CreatorApplicationsScreen()),
        );
        await tester.pumpAndSettle();

        expect(find.text('My Applications'), findsOneWidget);
        expect(find.text('Skincare Routine Video'), findsOneWidget);
        expect(find.text('Submitted'), findsOneWidget);
      },
    );

    testWidgets(
      'CampaignCreationScreen renders multi-step creation form with steps and navigation',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(const CampaignCreationScreen()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Create Campaign'), findsOneWidget);
        expect(find.text('Step 1 of 7: Campaign Basics'), findsOneWidget);
        expect(find.text('Campaign Title *'), findsOneWidget);
        expect(find.text('Save Draft'), findsOneWidget);
      },
    );

    testWidgets('BrandCampaignsScreen renders campaign listings and tabs', (
      tester,
    ) async {
      await campaignRepo.createDraft(
        organizationId: '11111111-1111-4111-8111-111111111111',
        title: 'Brand Showcase Q3',
        description: 'Brand showcase',
      );

      await tester.pumpWidget(buildTestWidget(const BrandCampaignsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Brand Campaigns'), findsOneWidget);
      expect(find.text('Brand Showcase Q3'), findsOneWidget);
      expect(find.text('New Campaign'), findsAtLeastNWidgets(1));
    });

    testWidgets(
      'CampaignApplicantDashboardScreen renders applicant cards and review actions',
      (tester) async {
        final campaign = await campaignRepo.createDraft(
          organizationId: 'org_1',
          title: 'Organic Food Launch',
          description: 'Organic food launch',
          creatorSlots: 2,
        );
        await campaignRepo.submitForReview(campaign.id);
        await campaignRepo.moderateCampaign(
          campaignId: campaign.id,
          action: 'approve',
        );

        await campaignRepo.submitApplication(
          campaignId: campaign.id,
          creatorId: 'creator_99',
          pitch: 'Experienced health foodie influencer.',
          proposedRate: 10000,
        );

        await tester.pumpWidget(
          buildTestWidget(
            CampaignApplicantDashboardScreen(campaignId: campaign.id),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('Applicants'), findsAtLeastNWidgets(1));
        expect(find.text('Slots Filled: 0 / 2'), findsOneWidget);
        expect(find.text('Creator creator_99'), findsOneWidget);
        expect(find.text('Shortlist'), findsOneWidget);
        expect(find.text('Select'), findsOneWidget);
      },
    );
  });
}
