import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_application.dart';
import 'package:ggs_mobile/features/campaign/domain/campaign_opportunity_item.dart';
import 'package:ggs_mobile/features/discovery/domain/creator_search_filters.dart';
import 'package:ggs_mobile/demo/demo_repositories.dart';
import 'package:ggs_mobile/demo/demo_store.dart';

void main() {
  late DemoStore store;
  late DemoAuthRepository authRepo;
  late DemoCreatorRepository creatorRepo;
  late DemoDiscoveryRepository discoveryRepo;
  late DemoShortlistRepository shortlistRepo;
  late DemoCampaignRepository campaignRepo;

  setUp(() {
    store = DemoStore.instance;
    store.reset();
    authRepo = DemoAuthRepository(store);
    creatorRepo = DemoCreatorRepository(store);
    discoveryRepo = DemoDiscoveryRepository(store);
    shortlistRepo = DemoShortlistRepository(store);
    campaignRepo = DemoCampaignRepository(store);
  });

  group('Demo Showcase Full Lifecycle & Storyline Tests', () {
    test('Initial Seed Data Verification', () async {
      // 1. Check creators count >= 12
      final searchResult = await discoveryRepo.searchCreators(
        filters: const CreatorSearchFilters(),
      );
      expect(searchResult.items.length, greaterThanOrEqualTo(12));

      // 2. Check initial shortlists >= 3
      final shortlists = await shortlistRepo.listShortlists();
      expect(shortlists.length, greaterThanOrEqualTo(3));

      // 3. Check live campaigns >= 4
      final campaignResults = await campaignRepo.searchLiveCampaigns(
        filters: const CampaignSearchFilters(),
      );
      expect(campaignResults.items.length, greaterThanOrEqualTo(4));
    });

    test(
      'DEMO STORY A: Brand Search, Filter, Shortlist & Compare Creators',
      () async {
        // Switch to Brand role
        store.currentRole = ProfessionalRole.brandMarketer;
        expect(authRepo.userId, equals(store.brandAccount.id));

        final profile = await creatorRepo.getProfile();
        expect(profile.displayName, equals('Aisha Mehta'));

        // 1. Search Fashion creators
        final fashionResult = await discoveryRepo.searchCreators(
          filters: const CreatorSearchFilters(query: 'Fashion'),
        );
        expect(fashionResult.items.isNotEmpty, isTrue);
        expect(
          fashionResult.items.any(
            (c) => c.primaryCategoryNames.contains('Fashion & Style'),
          ),
          isTrue,
        );

        // 2. Filter by Mumbai city
        final mumbaiResult = await discoveryRepo.searchCreators(
          filters: const CreatorSearchFilters(city: 'Mumbai'),
        );
        expect(mumbaiResult.items.isNotEmpty, isTrue);
        for (final item in mumbaiResult.items) {
          expect(item.city, equals('Mumbai'));
        }

        // 3. Add Creator to Shortlist
        final shortlists = await shortlistRepo.listShortlists();
        final targetShortlist = shortlists.first;
        final creatorToAdd = mumbaiResult.items.first;

        await shortlistRepo.addCreatorToShortlist(
          shortlistId: targetShortlist.id,
          creatorId: creatorToAdd.creatorId,
        );

        final updatedShortlist = await shortlistRepo.getShortlist(
          shortlistId: targetShortlist.id,
        );
        expect(
          updatedShortlist.members.any(
            (m) => m.creatorId == creatorToAdd.creatorId,
          ),
          isTrue,
        );

        // 4. Multi-Creator Comparison
        final compCreators = await discoveryRepo.getCreatorsForComparison(
          creatorIds: mumbaiResult.items
              .take(3)
              .map((c) => c.creatorId)
              .toList(),
        );
        expect(compCreators.length, equals(3));
      },
    );

    test('DEMO STORY B: Creator Discovers Work, Views Details, & Applies to Campaign', () async {
      // Switch to Creator role
      store.currentRole = ProfessionalRole.creator;
      expect(authRepo.userId, equals(store.creatorAccount.id));

      // 1. Creator searches opportunities
      final opportunities = await campaignRepo.searchLiveCampaigns(
        filters: const CampaignSearchFilters(),
      );
      expect(opportunities.items.isNotEmpty, isTrue);
      final opp = opportunities.items.first;

      // 2. Creator gets campaign details
      final campaign = await campaignRepo.getCampaign(opp.campaignId);
      expect(campaign.title, equals(opp.title));
      expect(campaign.deliverables.isNotEmpty, isTrue);

      // 3. Creator applies to campaign
      final application = await campaignRepo.submitApplication(
        campaignId: opp.campaignId,
        creatorId: store.creatorAccount.id,
        pitch: 'I have deep experience creating high-conversion festive reels with 100K+ reach.',
        proposedRate: 25000,
        currency: 'INR',
      );

      expect(application.status, equals(CampaignApplicationStatus.submitted));
      expect(application.campaignId, equals(opp.campaignId));

      // 4. My Applications contains the new application
      final myApps = await campaignRepo.getCreatorApplications(
        store.creatorAccount.id,
      );
      expect(myApps.any((a) => a.id == application.id), isTrue);
    });

    test('DEMO STORY C & D: Brand Reviews Applicant and Creator Sees State Transition', () async {
      // 1. Creator applies to Glow Forward campaign
      final campaigns = await campaignRepo.searchLiveCampaigns(
        filters: const CampaignSearchFilters(),
      );
      final targetCampaign = campaigns.items.firstWhere(
        (c) => c.title.contains('Glow Forward'),
      );

      final application = await campaignRepo.submitApplication(
        campaignId: targetCampaign.campaignId,
        creatorId: store.creatorAccount.id,
        pitch: 'Boss demo verification pitch.',
        proposedRate: 22000,
        currency: 'INR',
      );
      expect(application.status, equals(CampaignApplicationStatus.submitted));

      // 2. Switch to Brand role
      store.currentRole = ProfessionalRole.brandMarketer;
      final brandApplicants = await campaignRepo.getCampaignApplicants(
        campaignId: targetCampaign.campaignId,
      );
      expect(brandApplicants.any((a) => a.id == application.id), isTrue);

      // 3. Brand transitions status: underReview -> shortlisted -> selected
      await campaignRepo.transitionApplicationStatus(
        applicationId: application.id,
        newStatus: CampaignApplicationStatus.underReview,
      );
      var appState = await campaignRepo.getApplication(application.id);
      expect(appState.status, equals(CampaignApplicationStatus.underReview));

      await campaignRepo.transitionApplicationStatus(
        applicationId: application.id,
        newStatus: CampaignApplicationStatus.shortlisted,
      );
      appState = await campaignRepo.getApplication(application.id);
      expect(appState.status, equals(CampaignApplicationStatus.shortlisted));

      await campaignRepo.transitionApplicationStatus(
        applicationId: application.id,
        newStatus: CampaignApplicationStatus.selected,
      );
      appState = await campaignRepo.getApplication(application.id);
      expect(appState.status, equals(CampaignApplicationStatus.selected));

      // 4. Switch back to Creator role
      store.currentRole = ProfessionalRole.creator;
      final creatorApp = await campaignRepo.getApplication(application.id);
      expect(creatorApp.status, equals(CampaignApplicationStatus.selected));
    });

    test('Reset Demo Data cleanly restores baseline state', () async {
      // Modify store state
      final shortlists = await shortlistRepo.listShortlists();
      await shortlistRepo.deleteShortlist(shortlistId: shortlists.first.id);

      var shortlistsAfterDelete = await shortlistRepo.listShortlists();
      expect(shortlistsAfterDelete.length, equals(shortlists.length - 1));

      // Reset
      store.reset();

      final restoredShortlists = await shortlistRepo.listShortlists();
      expect(restoredShortlists.length, equals(3));
    });
  });
}
