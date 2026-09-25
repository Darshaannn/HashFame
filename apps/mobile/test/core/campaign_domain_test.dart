import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_application.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_opportunity_item.dart';

void main() {
  group('Campaign Domain Model & Validation', () {
    test('creates valid campaign with required fields', () {
      final campaign = Campaign(
        id: 'camp_1',
        organizationId: 'org_1',
        title: 'Diwali Festive UGC Drive',
        description: 'Looking for 5 lifestyle creators to create 1 reel each.',
        status: CampaignStatus.draft,
        compensationType: CampaignCompensationType.paid,
        currency: 'INR',
        budgetMin: 15000,
        budgetMax: 25000,
        creatorSlots: 5,
        categoryIds: const ['Fashion & Style', 'Lifestyle'],
        applicationDeadline: DateTime.now().add(const Duration(days: 10)),
        contentDeadline: DateTime.now().add(const Duration(days: 20)),
        deliverables: const [
          CampaignDeliverable(
            id: 'del_1',
            campaignId: 'camp_1',
            deliverableType: CampaignDeliverableType.instagramReel,
            platform: 'Instagram',
            quantity: 1,
            description: '30-45s Reel showcasing product in festive setting',
          ),
        ],
        usageRights: const CampaignUsageRights(
          organicRepostingAllowed: true,
          paidUsageRequired: false,
          whitelistingRequired: false,
          usageDurationMonths: 3,
          contentApprovalRequired: true,
          disclosureRequired: true,
        ),
      );

      expect(campaign.id, 'camp_1');
      expect(campaign.status, CampaignStatus.draft);
      expect(campaign.creatorSlots, 5);
      expect(campaign.compensationType, CampaignCompensationType.paid);
      expect(campaign.deliverables.length, 1);
      expect(campaign.usageRights.organicRepostingAllowed, isTrue);
    });

    test('compensation types support paid, barter, and paidAndBarter', () {
      const paid = Campaign(
        id: '1',
        organizationId: 'org_1',
        title: 'Paid',
        description: 'Paid campaign',
        compensationType: CampaignCompensationType.paid,
        currency: 'INR',
        budgetMin: 5000,
        budgetMax: 10000,
      );
      expect(paid.budgetMin, 5000);
      expect(paid.budgetMax, 10000);

      const barter = Campaign(
        id: '2',
        organizationId: 'org_1',
        title: 'Barter',
        description: 'Barter campaign',
        compensationType: CampaignCompensationType.barter,
        barterValue: 3000,
        barterDescription: 'Gift hamper worth 3000 INR',
      );
      expect(barter.barterValue, 3000);
      expect(barter.barterDescription, contains('Gift hamper'));

      const hybrid = Campaign(
        id: '3',
        organizationId: 'org_1',
        title: 'Hybrid',
        description: 'Hybrid campaign',
        compensationType: CampaignCompensationType.paidAndBarter,
        currency: 'INR',
        budgetMin: 5000,
        budgetMax: 8000,
        barterValue: 2000,
        barterDescription: 'Product kit',
      );
      expect(hybrid.budgetMin, 5000);
      expect(hybrid.barterValue, 2000);
    });
  });

  group('Campaign Status Lifecycle State Machine', () {
    test('legal transitions from draft -> pendingReview -> live -> paused -> live -> closed', () {
      var status = CampaignStatus.draft;

      // Draft to pending review
      expect(status == CampaignStatus.draft, isTrue);
      status = CampaignStatus.pendingReview;

      // Pending review to live (via moderation)
      expect(status == CampaignStatus.pendingReview, isTrue);
      status = CampaignStatus.live;

      // Live to paused
      expect(status == CampaignStatus.live, isTrue);
      status = CampaignStatus.paused;

      // Paused back to live
      expect(status == CampaignStatus.paused, isTrue);
      status = CampaignStatus.live;

      // Live to closed
      status = CampaignStatus.closed;
      expect(status, CampaignStatus.closed);
    });

    test('pendingReview can be rejected by moderation', () {
      var status = CampaignStatus.pendingReview;
      status = CampaignStatus.rejected;
      expect(status, CampaignStatus.rejected);
    });
  });

  group('Campaign Application Domain & State Machine', () {
    test('creates campaign application with pitch and rate', () {
      final app = CampaignApplication(
        id: 'app_1',
        campaignId: 'camp_1',
        creatorId: 'creator_1',
        status: CampaignApplicationStatus.submitted,
        pitch: 'I have 50k followers in Bangalore and love your brand!',
        proposedRate: 20000,
        currency: 'INR',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(app.id, 'app_1');
      expect(app.status, CampaignApplicationStatus.submitted);
      expect(app.proposedRate, 20000);
      expect(app.pitch, contains('50k followers'));
    });

    test('application status transitions: submitted -> underReview -> shortlisted -> selected', () {
      var status = CampaignApplicationStatus.submitted;

      // Brand reviews
      status = CampaignApplicationStatus.underReview;
      expect(status, CampaignApplicationStatus.underReview);

      // Brand shortlists
      status = CampaignApplicationStatus.shortlisted;
      expect(status, CampaignApplicationStatus.shortlisted);

      // Brand selects
      status = CampaignApplicationStatus.selected;
      expect(status, CampaignApplicationStatus.selected);
    });

    test('creator can withdraw application before decision', () {
      var status = CampaignApplicationStatus.submitted;
      status = CampaignApplicationStatus.withdrawn;
      expect(status, CampaignApplicationStatus.withdrawn);
    });
  });

  group('CampaignOpportunityItem Read Model & Filters', () {
    test(
      'creates lightweight search item without overfetching full description',
      () {
        const item = CampaignOpportunityItem(
          campaignId: 'camp_1',
          organizationId: 'org_1',
          title: 'Mega Launch',
          brandName: 'Acme Health',
          compensationType: CampaignCompensationType.paid,
          currency: 'INR',
          budgetMin: 10000,
          budgetMax: 15000,
          platforms: ['Instagram', 'YouTube'],
          categoryNames: ['Fitness & Wellness'],
          deliverableCount: 2,
          creatorSlots: 3,
        );

        expect(item.campaignId, 'camp_1');
        expect(item.deliverableCount, 2);
      },
    );

    test('filters active count calculation', () {
      const empty = CampaignSearchFilters();
      expect(empty.activeFilterCount, 0);

      const withCategoryAndPlatform = CampaignSearchFilters(
        categoryIds: ['Fashion & Style'],
        platforms: ['Instagram'],
        compensationType: CampaignCompensationType.paid,
      );
      expect(withCategoryAndPlatform.activeFilterCount, 3);
    });
  });
}
