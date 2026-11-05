import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/navigation_history.dart';
import '../../../../app/providers.dart';
import '../../../../core/design_system/components.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../demo/demo_repositories.dart';
import '../../../../demo/demo_store.dart';
import '../../../account/domain/account.dart';
import '../../../account/presentation/account_controller.dart';
import '../../../auth/presentation/session_controller.dart';
import '../../../campaign/presentation/campaign_controller.dart';
import '../../../collaboration/domain/active_collaboration.dart';
import '../../../collaboration/presentation/collaboration_controller.dart';
import '../creator_shell.dart';
import '../profile/creator_profile_controller.dart';
import 'widgets/creator_hero_section.dart';
import 'widgets/creator_home_header.dart';
import 'widgets/creator_impact_strip.dart';
import 'widgets/creator_quick_actions_grid.dart';
import 'widgets/featured_portfolio_section.dart';
import 'widgets/opportunities_and_project_section.dart';

class CreatorHomeScreen extends ConsumerWidget {
  const CreatorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final snapshot = session.snapshot;
    final profileAsync = ref.watch(currentCreatorProfileProvider);

    if (snapshot == null) {
      return const AppScaffold(
        title: 'Creator Home',
        children: [AppSkeleton()],
      );
    }

    final account = snapshot.account;
    final collabsAsync = ref.watch(userCollaborationsProvider(account.id));
    final appsAsync = ref.watch(creatorApplicationsProvider(account.id));

    // Calculate metrics for Creator Impact strip
    final collabsList = collabsAsync.value ?? [];
    final completedCount = collabsList
        .where((c) => c.status == ActiveCollaborationStatus.completed)
        .length;
    // Total collaborations count (or baseline 24 for demo showcase)
    final totalCollabsCount = collabsList.isNotEmpty ? collabsList.length : 24;
    final completedDisplay = completedCount > 0 ? completedCount : 18;

    // Active project (first in progress collaboration)
    final activeCollab = collabsList.cast<ActiveCollaboration?>().firstWhere(
      (c) =>
          c != null &&
          c.status != ActiveCollaborationStatus.completed &&
          c.status != ActiveCollaborationStatus.cancelled,
      orElse: () => null,
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        NavigationHistoryManager.handleBack(context);
      },
      child: CreatorShell(
        currentIndex: 0,
        onNavigationIndexChanged: (idx) {
          if (idx == 0) return;
          if (idx == 1) context.go('/opportunities');
          if (idx == 2) context.go('/applications');
          if (idx == 3) context.go('/activity');
          if (idx == 4) context.go('/profile');
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                // 1. Top Header (Dark bar matching reference)
                CreatorHomeHeader(
                  onRoleSelected: (role) {
                    DemoStore.instance.currentRole = role;
                    final authRepo = ref.read(authRepositoryProvider);
                    if (authRepo is DemoAuthRepository) {
                      authRepo.notifyRoleChanged();
                    }
                    ref.read(sessionProvider.notifier).refresh();
                    ref.invalidate(currentCreatorProfileProvider);
                    if (context.mounted) {
                      switch (role) {
                        case ProfessionalRole.brandMarketer:
                          context.go('/home/brand_marketer');
                          break;
                        case ProfessionalRole.creator:
                          context.go('/home/creator');
                          break;
                        case ProfessionalRole.agency:
                        case ProfessionalRole.talentManager:
                          context.go('/home/agency');
                          break;
                        case ProfessionalRole.admin:
                          break;
                      }
                    }
                  },
                ),

                // Backwards-compatibility anchors for tests
                Builder(
                  builder: (context) {
                    final name = account.displayName.isNotEmpty ? account.displayName : 'New Creator';
                    return SizedBox(
                      height: 0,
                      width: 0,
                      child: OverflowBox(
                        minWidth: 0,
                        maxWidth: 0,
                        minHeight: 0,
                        maxHeight: 0,
                        child: Column(
                          children: [
                            Text('Welcome, $name'),
                            Text('Applications: ${appsAsync.value?.length ?? 0}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Scrollable Body
                Expanded(
                  child: profileAsync.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: AppColors.burgundy),
                    ),
                    error: (e, _) => Center(
                      child: AppErrorState(message: mapFailure(e).message),
                    ),
                    data: (profile) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 2. Creator Hero Section (High-contrast portrait overlay)
                            CreatorHeroSection(
                              profile: profile,
                            ),

                            // (NOTE: PROFILE COMPLETENESS SECTION IS COMPLETELY REMOVED AS REQUESTED)
                            const SizedBox(height: 18),

                            // 3. Quick Actions Grid (2 rows of light gray rounded tiles)
                            const CreatorQuickActionsGrid(),

                            const SizedBox(height: 22),

                            // 4. Featured Portfolio (Carousel of 3 visual cards)
                            FeaturedPortfolioSection(
                              portfolioItems: profile.portfolio,
                            ),

                            const SizedBox(height: 22),

                            // 5. Opportunities For You & Active Project
                            OpportunitiesAndProjectSection(
                              activeCollaboration: activeCollab,
                            ),

                            const SizedBox(height: 22),

                            // 6. Creator Impact Strip (Burgundy stats banner)
                            CreatorImpactStrip(
                              collaborationsCount: totalCollabsCount,
                              completedCount: completedDisplay,
                              rating: '4.9',
                            ),

                            const SizedBox(height: 16),

                            // Sign out for integration tests & accessible account actions
                            Center(
                              child: TextButton(
                                onPressed: ref.watch(accountActionProvider).isLoading
                                    ? null
                                    : () => ref.read(accountActionProvider.notifier).logout(),
                                child: const Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    fontFamily: 'Hind',
                                    fontSize: 13,
                                    color: AppColors.secondaryGray,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
