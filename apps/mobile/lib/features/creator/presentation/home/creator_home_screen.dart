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
import 'package:ggs_mobile/features/profile_common/presentation/widgets/unified_profile_widgets.dart';

import '../creator_shell.dart';

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

    return CreatorShell(
      currentIndex: 0,
      onNavigationIndexChanged: (idx) {
        if (idx == 0) return;
        if (idx == 1) context.go('/opportunities');
        if (idx == 2) context.go('/applications');
        if (idx == 3) context.go('/activity');
        if (idx == 4) context.go('/profile');
      },
      child: AppScaffold(
        title: 'Creator Home',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
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
                    Text(
                      'Welcome, ${account.displayName}',
                      style: AppTypography.heading,
                    ),
                    const Text(
                      'Creator Studio',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                tooltip: 'Edit Profile',
                onPressed: () => context.push('/profile/edit'),
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
            loading: () => const AppSkeleton(count: 1),
            error: (e, _) => AppErrorState(message: mapFailure(e).message),
            data: (p) => CreatorCompletionCard(
              profile: p,
              onRecommendationTap: (rec) => context.push(rec.actionRoute),
            ),
          ),

          // Quick Actions
          GGSettingsSection(
            title: 'Creator Quick Actions',
            children: [
              GGAccountActionTile(
                title: 'Discover Brand Opportunities',
                subtitle: 'Browse live casting calls and creator briefs',
                icon: Icons.explore_outlined,
                onTap: () => context.go('/opportunities'),
              ),
              GGAccountActionTile(
                title: 'My Campaign Applications',
                subtitle: 'Track review status, pitches and offers',
                icon: Icons.assignment_outlined,
                onTap: () => context.go('/applications'),
              ),
              GGAccountActionTile(
                title: 'Manage Rate Card',
                subtitle: 'Set deliverable prices for Reels & YouTube',
                icon: Icons.currency_rupee,
                onTap: () => context.push('/profile/edit/rates'),
              ),
              GGAccountActionTile(
                title: 'Add Portfolio Samples',
                subtitle: 'Upload past video collabs & brand lookbooks',
                icon: Icons.work_outline,
                onTap: () => context.push('/profile/edit/portfolio'),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: ref.watch(accountActionProvider).isLoading
                ? null
                : () => ref.read(accountActionProvider.notifier).logout(),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
