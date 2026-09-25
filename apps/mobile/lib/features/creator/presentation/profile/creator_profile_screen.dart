import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/profile_common/presentation/widgets/unified_profile_widgets.dart';

import '../creator_shell.dart';
import 'creator_profile_controller.dart';
import 'widgets/creator_availability_card.dart';
import 'widgets/creator_bio_card.dart';
import 'widgets/creator_categories_languages_card.dart';
import 'widgets/creator_collaborations_list.dart';
import 'widgets/creator_completion_card.dart';
import 'widgets/creator_portfolio_grid.dart';
import 'widgets/creator_rate_card_view.dart';
import 'widgets/creator_social_accounts_card.dart';
import 'widgets/creator_verification_card.dart';

class CreatorProfileScreen extends ConsumerWidget {
  const CreatorProfileScreen({super.key, this.userId});

  final String? userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwn = userId == null;
    final isDemo = ref.watch(configProvider).name == 'GGs Demo';
    final profileAsync = isOwn
        ? ref.watch(currentCreatorProfileProvider)
        : ref.watch(creatorProfileProvider(userId));

    final content = profileAsync.when(
      loading: () =>
          const AppScaffold(title: 'Creator Profile', children: [AppLoader()]),
      error: (e, s) => AppScaffold(
        title: 'Creator Profile',
        children: [
          AppErrorState(
            message: mapFailure(e).message,
            onRetry: () => ref.invalidate(
              isOwn
                  ? currentCreatorProfileProvider
                  : creatorProfileProvider(userId),
            ),
          ),
        ],
      ),
      data: (CreatorProfile profile) => AppScaffold(
        title: isOwn ? 'My Creator Profile' : profile.displayName,
        actions: isOwn
            ? [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  tooltip: 'Settings',
                  onPressed: () => context.push('/settings'),
                ),
              ]
            : null,
        children: [
          // Header
          GGProfileHeader(
            name: profile.displayName,
            handle: profile.professionalName,
            roleOrTitle: profile.primaryCategories.isNotEmpty
                ? profile.primaryCategories.map((c) => c.name).join(' • ')
                : 'Digital Creator',
            organization:
                [profile.location.city, profile.location.state]
                    .whereType<String>()
                    .where((s) => s.isNotEmpty)
                    .join(', ')
                    .isNotEmpty
                ? [
                    profile.location.city,
                    profile.location.state,
                  ].whereType<String>().where((s) => s.isNotEmpty).join(', ')
                : 'India',
            isVerified:
                profile.verificationSummary.identityStatus.name == 'verified',
            onEditPressed: isOwn ? () => context.push('/profile/edit') : null,
          ),

          if (isOwn)
            CreatorCompletionCard(
              profile: profile,
              onRecommendationTap: (rec) => context.push(rec.actionRoute),
            ),

          CreatorBioCard(
            profile: profile,
            onEditPressed: isOwn ? () => context.push('/profile/edit') : null,
          ),

          CreatorCategoriesLanguagesCard(
            profile: profile,
            onEditPressed: isOwn ? () => context.push('/profile/edit') : null,
          ),

          if (isOwn)
            CreatorAvailabilityCard(
              profile: profile,
              onAvailabilityChanged: (newAvail) => ref
                  .read(creatorControllerProvider.notifier)
                  .updateAvailability(newAvail),
            ),

          CreatorSocialAccountsCard(
            profile: profile,
            onAddPressed: isOwn
                ? () => context.push('/profile/edit/socials')
                : null,
            onDeletePressed: isOwn
                ? (id) => ref
                      .read(creatorControllerProvider.notifier)
                      .deleteSocialAccount(id)
                : null,
          ),

          CreatorRateCardView(
            profile: profile,
            onAddPressed: isOwn
                ? () => context.push('/profile/edit/rates')
                : null,
            onDeleteItemPressed: isOwn
                ? (id) => ref
                      .read(creatorControllerProvider.notifier)
                      .deleteRateItem(id)
                : null,
          ),

          CreatorPortfolioGrid(
            profile: profile,
            onAddPressed: isOwn
                ? () => context.push('/profile/edit/portfolio')
                : null,
            onDeleteItemPressed: isOwn
                ? (id) => ref
                      .read(creatorControllerProvider.notifier)
                      .deletePortfolioItem(id)
                : null,
          ),

          CreatorCollaborationsList(
            profile: profile,
            onAddPressed: isOwn
                ? () => context.push('/profile/edit/collabs')
                : null,
            onDeleteItemPressed: isOwn
                ? (id) => ref
                      .read(creatorControllerProvider.notifier)
                      .deleteCollaboration(id)
                : null,
          ),

          CreatorVerificationCard(profile: profile),

          // Account Menu
          if (isOwn) ...[
            GGSettingsSection(
              title: 'Creator Account',
              children: [
                GGAccountActionTile(
                  title: 'Edit Basic Profile',
                  subtitle: 'Display name, bio, location, categories',
                  icon: Icons.person_outline,
                  onTap: () => context.push('/profile/edit'),
                ),
                GGAccountActionTile(
                  title: 'Manage Rate Card',
                  subtitle: 'Deliverable pricing, Reels, YouTube reviews',
                  icon: Icons.currency_rupee,
                  onTap: () => context.push('/profile/edit/rates'),
                ),
                GGAccountActionTile(
                  title: 'Portfolio & Work Samples',
                  subtitle: 'Showcase brand collaborations and videos',
                  icon: Icons.work_outline,
                  onTap: () => context.push('/profile/edit/portfolio'),
                ),
                GGAccountActionTile(
                  title: 'Social Accounts',
                  subtitle: 'Connect Instagram, YouTube & TikTok',
                  icon: Icons.share_outlined,
                  onTap: () => context.push('/profile/edit/socials'),
                ),
                GGAccountActionTile(
                  title: 'Account Settings',
                  subtitle: 'Notifications, email preferences and security',
                  icon: Icons.settings_outlined,
                  onTap: () => context.push('/settings'),
                ),
                GGAccountActionTile(
                  title: 'Help & Creator Support',
                  subtitle: 'Contact creator management team',
                  icon: Icons.help_outline,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Creator Support: creators@ggs.platform • Response within 2h.',
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
            if (isDemo) const GGDemoControlsCard(),
          ],
        ],
      ),
    );

    if (!isOwn) return content;

    return CreatorShell(
      currentIndex: 4,
      onNavigationIndexChanged: (idx) {
        if (idx == 0) context.go('/home/creator');
        if (idx == 1) context.go('/opportunities');
        if (idx == 2) context.go('/applications');
        if (idx == 3) context.go('/activity');
        if (idx == 4) return;
      },
      child: content,
    );
  }
}
