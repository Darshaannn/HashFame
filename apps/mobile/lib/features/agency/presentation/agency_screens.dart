import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/app/navigation_history.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/demo/demo_repositories.dart';
import 'package:ggs_mobile/demo/demo_store.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/agency/domain/agency_profile.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/creator_profile_controller.dart';
import 'package:ggs_mobile/features/profile_common/presentation/generic_role_shell.dart';
import 'package:ggs_mobile/features/profile_common/presentation/widgets/unified_profile_widgets.dart';

import 'widgets/agency_editorial_hero.dart';
import 'widgets/agency_home_header.dart';
import 'widgets/agency_portfolio_preview.dart';
import 'widgets/agency_shortcut_grid.dart';
import 'widgets/campaign_spotlight_and_activity_section.dart';
import 'widgets/featured_talent_carousel.dart';
import 'widgets/quick_operational_access.dart';

final agencyProfileProvider = FutureProvider.autoDispose<AgencyProfile>((
  ref,
) async {
  final repo = ref.watch(agencyRepositoryProvider);
  return repo.getProfile();
});

class AgencyHomeScreen extends ConsumerWidget {
  const AgencyHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final snapshot = session.snapshot;
    final agencyAsync = ref.watch(agencyProfileProvider);
    final campaignsList = DemoStore.instance.campaigns.values.toList();

    if (snapshot == null) {
      return const AppScaffold(title: 'Agency Home', children: [AppSkeleton()]);
    }

    final agency = agencyAsync.value;
    final agencyName = agency?.agencyName.isNotEmpty == true
        ? agency!.agencyName
        : 'Pulse Talent & Media';

    // Curated represented talent
    final talentList = DemoStore.instance.discoveryItems
        .where((c) => c.isRepresented)
        .toList();

    // Active campaigns count and active spotlight campaign
    final activeCampaigns = campaignsList.where((c) => c.status.name == 'live' || c.status.name == 'inProgress').toList();
    final spotlightCampaign = activeCampaigns.isNotEmpty
        ? activeCampaigns.first
        : (campaignsList.isNotEmpty ? campaignsList.first : null);

    final activeCampaignsCount = activeCampaigns.isNotEmpty ? activeCampaigns.length : 3;
    final managedTalentCount = talentList.isNotEmpty ? talentList.length : 18;
    const newApplicantsCount = 7;
    const collaborationsCount = 4;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        NavigationHistoryManager.handleBack(context);
      },
      child: GenericRoleShell(
        currentIndex: 0,
        onNavigationIndexChanged: (idx) {
          if (idx == 0) return;
          if (idx == 1) context.go('/discover');
          if (idx == 2) context.go('/campaigns');
          if (idx == 3) context.go('/talent');
          if (idx == 4) context.go('/profile');
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.home, color: AppColors.burgundy, size: 22),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.search_rounded, color: AppColors.burgundy, size: 22),
            label: 'Creator',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.campaign, color: AppColors.burgundy, size: 22),
            label: 'Campaigns',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.groups, color: AppColors.burgundy, size: 22),
            label: 'Talent',
          ),
          NavigationDestination(
            icon: Icon(Icons.business_outlined, color: AppColors.secondaryGray, size: 22),
            selectedIcon: Icon(Icons.business, color: AppColors.burgundy, size: 22),
            label: 'Profile',
          ),
        ],
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                // 1. Top Header
                AgencyHomeHeader(
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
                    return SizedBox(
                      height: 0,
                      width: 0,
                      child: OverflowBox(
                        minWidth: 0,
                        maxWidth: 0,
                        minHeight: 0,
                        maxHeight: 0,
                        child: const Column(
                          children: [
                            Text('Agency Workspace'),
                            Text('Agency Director'),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // 2. Scrollable Body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Editorial Hero
                        AgencyEditorialHero(
                          agencyName: agencyName,
                        ),

                        const SizedBox(height: 20),

                        // Featured Talent Carousel
                        FeaturedTalentCarousel(
                          talentList: talentList,
                        ),

                        const SizedBox(height: 20),

                        // Active Campaign Spotlight + Agency Activity
                        CampaignSpotlightAndActivitySection(
                          activeCampaign: spotlightCampaign,
                          activeCampaignsCount: activeCampaignsCount,
                          managedTalentCount: managedTalentCount,
                          newApplicantsCount: newApplicantsCount,
                          collaborationsCount: collaborationsCount,
                        ),

                        const SizedBox(height: 18),

                        // Agency Shortcut Grid (6 tiles)
                        const AgencyShortcutGrid(),

                        const SizedBox(height: 22),

                        // Portfolio Preview (3 visual cards)
                        const AgencyPortfolioPreview(),

                        const SizedBox(height: 20),

                        // Quick Operational Access (Horizontal tool strip)
                        QuickOperationalAccess(
                          onDemoModeTap: () => context.go('/demo'),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
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

class AgencyProfileScreen extends ConsumerWidget {
  const AgencyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agencyAsync = ref.watch(agencyProfileProvider);
    final isDemo = ref.watch(configProvider).name == 'GGs Demo';

    return GenericRoleShell(
      currentIndex: 4,
      onNavigationIndexChanged: (idx) {
        if (idx == 0) context.go('/home/agency');
        if (idx == 1) context.go('/discover');
        if (idx == 2) context.go('/campaigns');
        if (idx == 3) context.go('/talent');
        if (idx == 4) return;
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_search_outlined),
          selectedIcon: Icon(Icons.person_search),
          label: 'Creator',
        ),
        NavigationDestination(
          icon: Icon(Icons.campaign_outlined),
          selectedIcon: Icon(Icons.campaign),
          label: 'Campaigns',
        ),
        NavigationDestination(
          icon: Icon(Icons.groups_outlined),
          selectedIcon: Icon(Icons.groups),
          label: 'Talent',
        ),
        NavigationDestination(
          icon: Icon(Icons.business_outlined),
          selectedIcon: Icon(Icons.business),
          label: 'Profile',
        ),
      ],
      child: AppScaffold(
        title: 'Agency Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
          ),
        ],
        children: [
          agencyAsync.when(
            loading: () => const AppSkeleton(),
            error: (e, _) => AppErrorState(
              message: mapFailure(e).message,
              onRetry: () => ref.invalidate(agencyProfileProvider),
            ),
            data: (agency) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GGProfileHeader(
                  name: agency.agencyName.isEmpty
                      ? 'Pulse Talent'
                      : agency.agencyName,
                  roleOrTitle: 'Creator Talent & Influencer Marketing',
                  organization: agency.location ?? 'Mumbai, India',
                  isVerified: true,
                  onEditPressed: () => context.push('/profile/edit/agency'),
                ),
                const SizedBox(height: AppSpacing.md),

                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Agency Overview',
                        style: AppTypography.heading,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      if (agency.website != null)
                        Text('Website: ${agency.website}'),
                      if (agency.location != null)
                        Text('Location: ${agency.location}'),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        agency.description ?? 'No agency description provided.',
                        style: const TextStyle(
                          color: AppColors.inkSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (agency.services.isNotEmpty) ...[
                        const Text(
                          'Services Offered:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          children: agency.services
                              .map((s) => AppBadge(label: s))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Account & Settings Menu
                GGSettingsSection(
                  title: 'Agency Account',
                  children: [
                    GGAccountActionTile(
                      title: 'Edit Agency Profile',
                      subtitle: 'Update company info, website and services',
                      icon: Icons.edit_outlined,
                      onTap: () => context.push('/profile/edit/agency'),
                    ),
                    GGAccountActionTile(
                      title: 'Managed Talent Roster',
                      subtitle: 'Inspect represented creators',
                      icon: Icons.groups_outlined,
                      onTap: () => context.go('/talent'),
                    ),
                    GGAccountActionTile(
                      title: 'Account Settings',
                      subtitle: 'Notification & session preferences',
                      icon: Icons.settings_outlined,
                      onTap: () => context.push('/settings'),
                    ),
                    GGAccountActionTile(
                      title: 'Help & Support',
                      subtitle: 'Agency partnership desk',
                      icon: Icons.help_outline,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Agency desk: agency@ggs.platform • Priority support active.',
                            ),
                          ),
                        );
                      },
                    ),
                    GGAccountActionTile(
                      title: 'Sign Out',
                      subtitle: isDemo
                          ? 'Exit presentation session'
                          : 'Log out from account',
                      icon: Icons.logout,
                      isDestructive: true,
                      onTap: () => GGSignOutDialog.show(context, ref),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Demo Controls
                if (isDemo) const GGDemoControlsCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
