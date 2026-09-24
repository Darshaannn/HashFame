import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/features/account/presentation/account_controller.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/creator_profile_controller.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/widgets/creator_completion_card.dart';

class CreatorHomeScreen extends ConsumerWidget {
  const CreatorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final snapshot = session.snapshot;
    final profileAsync = ref.watch(currentCreatorProfileProvider);

    if (snapshot == null) {
      return const AppScaffold(title: 'Creator Home', children: [AppSkeleton()]);
    }

    final account = snapshot.account;

    return AppScaffold(
      title: 'Creator Home',
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          tooltip: 'Settings',
          onPressed: () => context.go('/settings'),
        ),
      ],
      children: [
        // Header
        Row(
          children: [
            AppAvatar(label: account.displayName),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome, ${account.displayName}', style: AppTypography.heading),
                  const Text('Creator Studio', style: TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
          ],
        ),

        if (snapshot.offline)
          AppCard(
            child: Text(
              'Offline • Last updated ${snapshot.fetchedAt.toLocal()}\nShowing saved creator profile.',
            ),
          ),

        // Profile Completion Widget
        profileAsync.when(
          loading: () => const AppSkeleton(),
          error: (e, _) => AppErrorState(message: mapFailure(e).message),
          data: (profile) => CreatorCompletionCard(
            profile: profile,
            onRecommendationTap: (rec) => context.go(rec.actionRoute),
          ),
        ),

        // Quick Actions Card
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Quick Actions', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => context.go('/profile'),
                    icon: const Icon(Icons.person_outline, size: 18),
                    label: const Text('View Profile'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/profile/edit/rates'),
                    icon: const Icon(Icons.currency_rupee, size: 18),
                    label: const Text('Edit Rates'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/profile/edit/portfolio'),
                    icon: const Icon(Icons.work_outline, size: 18),
                    label: const Text('Add Work'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/profile/edit/socials'),
                    icon: const Icon(Icons.share_outlined, size: 18),
                    label: const Text('Connect Socials'),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Opportunities & Marketplace Intentional Empty State
        const AppEmptyState(
          title: 'Brand Opportunities & Campaigns',
          message: 'Direct brand briefs, campaign invites, and open marketplace casting calls will appear here in Phase 2B.',
        ),

        // Sign Out
        const SizedBox(height: AppSpacing.md),
        TextButton(
          onPressed: ref.watch(accountActionProvider).isLoading
              ? null
              : () => ref.read(accountActionProvider.notifier).logout(),
          child: const Text('Sign Out'),
        ),
      ],
    );
  }
}
