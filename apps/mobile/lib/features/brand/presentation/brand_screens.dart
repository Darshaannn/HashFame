import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../../core/errors/app_failure.dart';
import '../../auth/presentation/session_controller.dart';
import '../../brand/domain/brand_profile.dart';
import '../../campaign/domain/campaign.dart';
import '../../campaign/presentation/campaign_controller.dart';
import '../../collaboration/domain/active_collaboration.dart';
import '../../collaboration/presentation/collaboration_controller.dart';
import '../../profile_common/presentation/widgets/unified_profile_widgets.dart';
import 'brand_shell.dart';

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
    final brandAsync = ref.watch(brandProfileProvider);

    if (snapshot == null) {
      return const AppScaffold(title: 'Brand Home', children: [AppSkeleton()]);
    }

    final account = snapshot.account;
    final brand = brandAsync.value;
    final orgName = brand?.organizationName ?? 'Nova Beauty India';
    final campaignsAsync = ref.watch(organizationCampaignsProvider(account.id));
    final collabsAsync = ref.watch(
      organizationCollaborationsProvider(account.id),
    );

    return BrandShell(
      currentIndex: 0,
      onNavigationIndexChanged: (idx) {
        if (idx == 0) return;
        if (idx == 1) context.go('/discover');
        if (idx == 2) context.go('/campaigns');
        if (idx == 3) context.go('/shortlists');
        if (idx == 4) context.go('/profile');
      },
      child: AppScaffold(
        title: 'Brand Workspace',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
          ),
        ],
        children: [
          // Navy Dashboard Hero Section
          GGHeroBanner(
            tag: 'BRAND WORKSPACE',
            title: orgName,
            subtitle: 'Campaign management, creator discovery, and active collaboration hub.',
            ctaLabel: 'Post New Campaign',
            onCtaPressed: () => context.push('/campaigns/new'),
            icon: Icons.storefront,
          ),

          // Header Profile Identity
          GGProfileHeader(
            name: brand?.displayName ?? account.displayName,
            roleOrTitle: brand?.jobTitle ?? 'Head of Brand Marketing',
            organization: orgName,
            isVerified: true,
            onEditPressed: () => context.push('/profile/edit/brand'),
          ),

          // Live Marketplace Metrics
          Row(
            children: [
              Expanded(
                child: AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Campaigns',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${campaignsAsync.value?.where((c) => c.status == CampaignStatus.live).length ?? 0}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Collabs',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${collabsAsync.value?.where((c) => c.status != ActiveCollaborationStatus.completed && c.status != ActiveCollaborationStatus.cancelled).length ?? 0}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.burgundy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'In Review',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${collabsAsync.value?.where((c) => c.status == ActiveCollaborationStatus.submitted).length ?? 0}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.burgundy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Featured Creators Horizontal Visual Preview
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GGSectionHeader(
                title: 'Featured Creators',
                subtitle: 'Verified talent ready for campaign collaboration',
                actionLabel: 'See All',
                onAction: () => context.go('/discover'),
              ),
              const SizedBox(height: AppSpacing.xs),
              SizedBox(
                height: 124,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFeaturedCreatorThumbnail(
                      context,
                      name: 'Aisha Mehta',
                      category: 'Fashion & Style',
                      followers: '142K',
                      photoUrl: AppImages.creatorAisha,
                    ),
                    _buildFeaturedCreatorThumbnail(
                      context,
                      name: 'Riya Kapoor',
                      category: 'Beauty & Skincare',
                      followers: '280K',
                      photoUrl: AppImages.creatorRiya,
                    ),
                    _buildFeaturedCreatorThumbnail(
                      context,
                      name: 'Rohan Sharma',
                      category: 'Tech Reviewer',
                      followers: '410K',
                      photoUrl: AppImages.creatorRohan,
                    ),
                    _buildFeaturedCreatorThumbnail(
                      context,
                      name: 'Neha Rao',
                      category: 'Health & Fitness',
                      followers: '95K',
                      photoUrl: AppImages.creatorNeha,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Quick Actions
          GGSettingsSection(
            title: 'Quick Actions',
            children: [
              GGAccountActionTile(
                title: 'Discover Creators',
                subtitle: 'Filter by niche, followers, city & rates',
                icon: Icons.search,
                onTap: () => context.go('/discover'),
              ),
              GGAccountActionTile(
                title: 'Create Campaign',
                subtitle: 'Post a new campaign brief for creators',
                icon: Icons.add_circle_outline,
                onTap: () => context.push('/campaigns/new'),
              ),
              GGAccountActionTile(
                title: 'Manage Campaigns',
                subtitle: 'Review applicants and live campaigns',
                icon: Icons.campaign_outlined,
                onTap: () => context.go('/campaigns'),
              ),
              GGAccountActionTile(
                title: 'Saved Shortlists',
                subtitle: 'View curated creator rosters',
                icon: Icons.bookmark_border,
                onTap: () => context.go('/shortlists'),
              ),
            ],
          ),

          // Brand Organization Summary Card
          brandAsync.when(
            loading: () => const AppSkeleton(count: 1),
            error: (e, _) => AppErrorState(message: mapFailure(e).message),
            data: (profile) => AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Managed Brands & Portfolio',
                          style: AppTypography.heading,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      AppBadge(label: '${profile.managedBrands.length} Active'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    profile.bio ??
                        'Leading brand partnerships and digital campaigns.',
                    style: const TextStyle(
                      color: AppColors.inkSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  for (final b in profile.managedBrands)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${b.name} • ${b.industry}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: AppSpacing.sm),
                  OutlinedButton(
                    onPressed: () => context.go('/profile'),
                    child: const Text('View Full Profile'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCreatorThumbnail(
    BuildContext context, {
    required String name,
    required String category,
    required String followers,
    required String photoUrl,
  }) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: AppSpacing.sm),
      child: InkWell(
        onTap: () => context.go('/discover'),
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Column(
          children: [
            AppAvatar(label: name, imageUrl: photoUrl, radius: 30),
            const SizedBox(height: 6),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: AppColors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Text(
              followers,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.burgundy,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
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
