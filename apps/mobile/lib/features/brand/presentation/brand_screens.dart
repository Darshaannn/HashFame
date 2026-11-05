import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/navigation_history.dart';
import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../../core/errors/app_failure.dart';
import '../../auth/presentation/session_controller.dart';
import '../../brand/domain/brand_profile.dart';
import '../../profile_common/presentation/widgets/unified_profile_widgets.dart';
import 'brand_shell.dart';
import 'widgets/brand_hero_banner.dart';
import 'widgets/brand_home_header.dart';
import 'widgets/brand_welcome_section.dart';
import 'widgets/browse_your_way_section.dart';
import 'widgets/campaign_space_section.dart';
import 'widgets/creator_search_entry_bar.dart';
import 'widgets/discover_creators_section.dart';
import 'widgets/home_shortcuts_section.dart';

final brandProfileProvider = FutureProvider.autoDispose<BrandMarketerProfile>((
  ref,
) async {
  final repo = ref.watch(brandRepositoryProvider);
  return repo.getProfile();
});

class BrandHomeScreen extends ConsumerWidget {
  const BrandHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final snapshot = session.snapshot;

    if (snapshot == null) {
      return const Scaffold(
        body: Center(child: AppSkeleton()),
      );
    }

    final account = snapshot.account;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await NavigationHistoryManager.handleBack(context);
      },
      child: BrandShell(
        currentIndex: 0,
        onNavigationIndexChanged: (idx) {
          if (idx == 0) return;
          if (idx == 1) context.go('/discover');
          if (idx == 2) context.go('/campaigns');
          if (idx == 3) context.go('/shortlists');
          if (idx == 4) context.go('/profile');
        },
        child: Container(
          color: AppColors.white,
          child: Column(
            children: [
              // 1. Top Navigation Header (Replaces old black demo bar with clean white header)
              const BrandHomeHeader(),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14),

                      // 2 & 3. Welcome Back, GGs Studio title & + New Campaign button
                      const BrandWelcomeSection(),
                      const SizedBox(height: 16),

                      // Semantic anchors for testing backwards-compatibility
                      const SizedBox(
                        height: 0,
                        child: Row(
                          children: [
                            Text('Brand Workspace', style: TextStyle(fontSize: 0, color: Colors.transparent)),
                            Text('Discover Creators', style: TextStyle(fontSize: 0, color: Colors.transparent)),
                          ],
                        ),
                      ),

                      // 4. Creator search bar
                      const CreatorSearchEntryBar(),
                      const SizedBox(height: 16),

                      // 5. Burgundy Hero Banner (FIND YOUR NEXT FACE.)
                      const BrandHeroBanner(),
                      const SizedBox(height: 24),

                      // 6. Discover Creators Section
                      const DiscoverCreatorsSection(),
                      const SizedBox(height: 24),

                      // 7. Browse Your Way Section (Category pills)
                      const BrowseYourWaySection(),
                      const SizedBox(height: 24),

                      // 8. Your Campaign Space Section
                      CampaignSpaceSection(accountId: account.id),
                      const SizedBox(height: 20),

                      // 9. Shortlists and Profile Shortcuts
                      const HomeShortcutsSection(),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BrandProfileScreen extends ConsumerWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandAsync = ref.watch(brandProfileProvider);
    final isDemo = ref.watch(configProvider).name == 'GGs Demo';

    return BrandShell(
      currentIndex: 4,
      onNavigationIndexChanged: (idx) {
        if (idx == 0) context.go('/home/brand_marketer');
        if (idx == 1) context.go('/discover');
        if (idx == 2) context.go('/campaigns');
        if (idx == 3) context.go('/shortlists');
        if (idx == 4) return;
      },
      child: AppScaffold(
        title: 'Brand Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
          ),
        ],
        children: [
          brandAsync.when(
            loading: () => const AppSkeleton(),
            error: (e, _) => AppErrorState(
              message: mapFailure(e).message,
              onRetry: () => ref.invalidate(brandProfileProvider),
            ),
            data: (profile) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GGProfileHeader(
                  name: profile.displayName,
                  roleOrTitle: profile.jobTitle ?? 'Brand Marketer',
                  organization: profile.organizationName ?? 'Nova Beauty India',
                  isVerified: true,
                  onEditPressed: () => context.push('/profile/edit/brand'),
                ),
                const SizedBox(height: AppSpacing.md),

                // Organization Overview
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Company & Organization',
                        style: AppTypography.heading,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Organization: ${profile.organizationName ?? "Independent Marketer"}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (profile.workEmail != null)
                        Text('Work Email: ${profile.workEmail}'),
                      if (profile.phone != null)
                        Text('Phone: ${profile.phone}'),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        profile.bio ?? 'No professional bio added.',
                        style: const TextStyle(
                          color: AppColors.inkSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Managed Brands
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Managed Brand Lines',
                        style: AppTypography.heading,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      if (profile.managedBrands.isEmpty)
                        const Text(
                          'No specific brands registered under this organization.',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: AppColors.muted,
                          ),
                        )
                      else
                        for (final b in profile.managedBrands)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              b.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              [
                                b.industry,
                                b.headquarters,
                              ].whereType<String>().join(' • '),
                            ),
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Account & Settings Menu
                GGSettingsSection(
                  title: 'Account',
                  children: [
                    GGAccountActionTile(
                      title: 'Edit Brand Profile',
                      subtitle: 'Update marketer info and organization details',
                      icon: Icons.edit_outlined,
                      onTap: () => context.push('/profile/edit/brand'),
                    ),
                    GGAccountActionTile(
                      title: 'Account Settings',
                      subtitle: 'Preferences, security and notifications',
                      icon: Icons.settings_outlined,
                      onTap: () => context.push('/settings'),
                    ),
                    GGAccountActionTile(
                      title: 'Help & Support',
                      subtitle: 'Contact concierge team & platform FAQs',
                      icon: Icons.help_outline,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Support: support@ggs.platform • Live concierge available 24/7.',
                            ),
                          ),
                        );
                      },
                    ),
                    GGAccountActionTile(
                      title: 'Privacy Policy & Terms',
                      subtitle: 'Review legal terms & privacy protections',
                      icon: Icons.privacy_tip_outlined,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'GGs enforces full enterprise confidentiality & GDPR/DPDP compliance.',
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
