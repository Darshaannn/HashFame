import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_application.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_opportunity_item.dart';

import '../support/fakes.dart';

void main() {
  late FakeCampaignRepository campaignRepo;

  setUp(() {
    campaignRepo = FakeCampaignRepository();
  });

  group('Full Two-Sided Campaign Marketplace Flow Integration Test', () {
    test('Complete lifecycle: Brand draft -> Submit -> Moderation -> Creator Discovery -> Application -> Brand Review/Shortlist/Select -> Status Verification', () async {
      // 1. Brand creates draft campaign
      final draft = await campaignRepo.createDraft(
        organizationId: 'org_nike',
        title: 'Air Max Monsoon Campaign',
        objective: 'Drive awareness for monsoon waterproof sneaker line',
        description: 'Create engaging monsoon outdoor lifestyle reels.',
        compensationType: CampaignCompensationType.paid,
        currency: 'INR',
        budgetMin: 25000,
        budgetMax: 40000,
        creatorSlots: 2,
        categoryIds: ['Fitness & Wellness', 'Fashion & Style'],
        deliverables: const [
          CampaignDeliverable(
            id: 'del_1',
            campaignId: 'draft_camp',
            deliverableType: CampaignDeliverableType.instagramReel,
            platform: 'Instagram',
            quantity: 1,
            description: '30s dynamic reel in rain setting with shoes',
          ),
        ],
        usageRights: const CampaignUsageRights(
          organicRepostingAllowed: true,
          paidUsageRequired: false,
          usageDurationMonths: 3,
          contentApprovalRequired: true,
        ),
      );

      expect(draft.status, CampaignStatus.draft);
      expect(draft.creatorSlots, 2);

      // 2. Brand submits campaign for review
      final pendingCampaign = await campaignRepo.submitForReview(draft.id);
      expect(pendingCampaign.status, CampaignStatus.pendingReview);

      // 3. Trusted moderation approves campaign to LIVE
      final liveCampaign = await campaignRepo.moderateCampaign(
        campaignId: pendingCampaign.id,
        action: 'approve',
      );
      expect(liveCampaign.status, CampaignStatus.live);
      expect(liveCampaign.publishedAt, isNotNull);

      // 4. Creator A discovers live campaign in opportunity feed
      final searchResult = await campaignRepo.searchLiveCampaigns(
        filters: const CampaignSearchFilters(query: 'Air Max'),
      );
      expect(searchResult.items.length, 1);
      expect(searchResult.items.first.campaignId, liveCampaign.id);
      expect(searchResult.items.first.title, 'Air Max Monsoon Campaign');

      // 5. Creator A applies to the campaign
      final applicationA = await campaignRepo.submitApplication(
        campaignId: liveCampaign.id,
        creatorId: 'creator_arjun',
        pitch: 'Professional athlete with 100k engaged runners in Mumbai.',
        proposedRate: 35000,
      );
      expect(applicationA.status, CampaignApplicationStatus.submitted);

      // 6. Creator B applies to the campaign
      final applicationB = await campaignRepo.submitApplication(
        campaignId: liveCampaign.id,
        creatorId: 'creator_priya',
        pitch: 'Fashion influencer with monsoon styling aesthetic.',
        proposedRate: 30000,
      );
      expect(applicationB.status, CampaignApplicationStatus.submitted);

      // 7. Duplicate application prevention: Creator A cannot submit again
      expect(
        () async => await campaignRepo.submitApplication(
          campaignId: liveCampaign.id,
          creatorId: 'creator_arjun',
          pitch: 'Another pitch attempt',
        ),
        throwsA(isA<Exception>()),
      );

      // 8. Brand opens applicant dashboard and inspects applicants
      final applicants = await campaignRepo.getCampaignApplicants(
        campaignId: liveCampaign.id,
      );
      expect(applicants.length, 2);

      // 9. Brand marks Creator A as under review, then shortlists
      final underReviewA = await campaignRepo.transitionApplicationStatus(
        applicationId: applicationA.id,
        newStatus: CampaignApplicationStatus.underReview,
      );
      expect(underReviewA.status, CampaignApplicationStatus.underReview);

      final shortlistedA = await campaignRepo.transitionApplicationStatus(
        applicationId: applicationA.id,
        newStatus: CampaignApplicationStatus.shortlisted,
      );
      expect(shortlistedA.status, CampaignApplicationStatus.shortlisted);

      // 10. Brand selects Creator A and Creator B (filling all 2 slots)
      final selectedA = await campaignRepo.transitionApplicationStatus(
        applicationId: applicationA.id,
        newStatus: CampaignApplicationStatus.selected,
      );
      expect(selectedA.status, CampaignApplicationStatus.selected);

      final selectedB = await campaignRepo.transitionApplicationStatus(
        applicationId: applicationB.id,
        newStatus: CampaignApplicationStatus.selected,
      );
      expect(selectedB.status, CampaignApplicationStatus.selected);

      // 11. Creator slot capacity enforcement: 3rd creator cannot be selected
      final applicationC = await campaignRepo.submitApplication(
        campaignId: liveCampaign.id,
        creatorId: 'creator_rohit',
        pitch: 'Late applicant',
      );

      expect(
        () async => await campaignRepo.transitionApplicationStatus(
          applicationId: applicationC.id,
          newStatus: CampaignApplicationStatus.selected,
        ),
        throwsA(
          predicate((e) => e.toString().contains('slot capacity reached')),
        ),
      );

      // 12. Audit status history verification
      final historyA = await campaignRepo.getApplicationHistory(
        applicationA.id,
      );
      expect(
        historyA.length,
        4,
      ); // submitted -> underReview -> shortlisted -> selected
      expect(historyA.map((h) => h.toStatus).toList(), [
        CampaignApplicationStatus.submitted,
        CampaignApplicationStatus.underReview,
        CampaignApplicationStatus.shortlisted,
        CampaignApplicationStatus.selected,
      ]);

      // 13. Creator verifies final application status
      final creatorApps = await campaignRepo.getCreatorApplications(
        'creator_arjun',
      );
      expect(creatorApps.first.status, CampaignApplicationStatus.selected);
    });

    test('Late application deadline enforcement rejects creator application submission', () async {
      final expiredCampaign = await campaignRepo.createDraft(
        organizationId: 'org_1',
        title: 'Past Deadline Campaign',
        description: 'Expired test',
        applicationDeadline: DateTime.now().subtract(const Duration(days: 2)),
      );
      await campaignRepo.submitForReview(expiredCampaign.id);
      await campaignRepo.moderateCampaign(
        campaignId: expiredCampaign.id,
        action: 'approve',
      );

      expect(
        () async => await campaignRepo.submitApplication(
          campaignId: expiredCampaign.id,
          creatorId: 'creator_late',
          pitch: 'I am applying after deadline',
        ),
        throwsA(predicate((e) => e.toString().contains('deadline has passed'))),
      );
    });

    test('Creator withdrawal works before final decision and records audit history', () async {
      final campaign = await campaignRepo.createDraft(
        organizationId: 'org_1',
        title: 'Withdraw Test Campaign',
        description: 'Withdraw test',
      );
      await campaignRepo.submitForReview(campaign.id);
      await campaignRepo.moderateCampaign(
        campaignId: campaign.id,
        action: 'approve',
      );

      final app = await campaignRepo.submitApplication(
        campaignId: campaign.id,
        creatorId: 'creator_busy',
        pitch: 'I want to withdraw later',
      );
      expect(app.status, CampaignApplicationStatus.submitted);

      final withdrawn = await campaignRepo.withdrawApplication(app.id);
      expect(withdrawn.status, CampaignApplicationStatus.withdrawn);
      expect(withdrawn.withdrawnAt, isNotNull);

      final history = await campaignRepo.getApplicationHistory(app.id);
      expect(history.last.toStatus, CampaignApplicationStatus.withdrawn);
    });
  });
}
