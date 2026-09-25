import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';

import 'creator_profile_controller.dart';
import 'widgets/creator_availability_card.dart';
import 'widgets/creator_bio_card.dart';
import 'widgets/creator_categories_languages_card.dart';
import 'widgets/creator_collaborations_list.dart';
import 'widgets/creator_completion_card.dart';
import 'widgets/creator_header_card.dart';
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
    final profileAsync = isOwn
        ? ref.watch(currentCreatorProfileProvider)
        : ref.watch(creatorProfileProvider(userId));

    return profileAsync.when(
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
                  onPressed: () => context.go('/settings'),
                ),
              ]
            : null,
        children: [
          if (isOwn)
            CreatorCompletionCard(
              profile: profile,
              onRecommendationTap: (rec) => context.go(rec.actionRoute),
            ),
          CreatorHeaderCard(
            profile: profile,
            onEditPressed: isOwn ? () => context.go('/profile/edit') : null,
          ),
          CreatorBioCard(
            profile: profile,
            onEditPressed: isOwn ? () => context.go('/profile/edit') : null,
          ),
          CreatorCategoriesLanguagesCard(
            profile: profile,
            onEditPressed: isOwn ? () => context.go('/profile/edit') : null,
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
                ? () => context.go('/profile/edit/socials')
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
                ? () => context.go('/profile/edit/rates')
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
                ? () => context.go('/profile/edit/portfolio')
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
                ? () => context.go('/profile/edit/collabs')
                : null,
            onDeleteItemPressed: isOwn
                ? (id) => ref
                      .read(creatorControllerProvider.notifier)
                      .deleteCollaboration(id)
                : null,
          ),
          CreatorVerificationCard(profile: profile),
        ],
      ),
    );
  }
}
