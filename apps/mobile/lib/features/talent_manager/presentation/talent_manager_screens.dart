import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/features/account/presentation/account_controller.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';
import 'package:ggs_mobile/features/talent_manager/domain/talent_manager_profile.dart';

final talentManagerProfileProvider = FutureProvider.autoDispose<TalentManagerProfile>((ref) async {
  final repo = ref.watch(talentManagerRepositoryProvider);
  return repo.getProfile();
});

class TalentManagerHomeScreen extends ConsumerWidget {
  const TalentManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final snapshot = session.snapshot;
    final mgrAsync = ref.watch(talentManagerProfileProvider);

    if (snapshot == null) {
      return const AppScaffold(title: 'Manager Home', children: [AppSkeleton()]);
    }

    final account = snapshot.account;

    return AppScaffold(
      title: 'Talent Manager Home',
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          tooltip: 'Settings',
          onPressed: () => context.go('/settings'),
        ),
      ],
      children: [
        Row(
          children: [
            AppAvatar(label: account.displayName),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Manager: ${account.displayName}', style: AppTypography.heading),
                  const Text('Talent Representation Studio', style: TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        mgrAsync.when(
          loading: () => const AppSkeleton(),
          error: (e, _) => AppErrorState(message: mapFailure(e).message),
          data: (mgr) => AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Roster Overview', style: AppTypography.heading),
                const SizedBox(height: AppSpacing.sm),
                Text('Company: ${mgr.companyName ?? "Independent Manager"}'),
                Text('Represented Creators: ${mgr.representedCreatorsCount} verified active'),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton(
                  onPressed: () => context.go('/profile'),
                  child: const Text('View Manager Profile'),
                ),
              ],
            ),
          ),
        ),

        const AppEmptyState(
          title: 'Creator Representation Requests',
          message: 'Creator invitations, contract approvals, and verified creator-manager linkings will appear here in Phase 2C.',
        ),

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

class TalentManagerProfileScreen extends ConsumerWidget {
  const TalentManagerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mgrAsync = ref.watch(talentManagerProfileProvider);

    return AppScaffold(
      title: 'Talent Manager Profile',
      children: [
        mgrAsync.when(
          loading: () => const AppSkeleton(),
          error: (e, _) => AppErrorState(
            message: mapFailure(e).message,
            onRetry: () => ref.invalidate(talentManagerProfileProvider),
          ),
          data: (mgr) => AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mgr.displayName, style: AppTypography.heading),
                if (mgr.companyName != null) Text('Company: ${mgr.companyName}'),
                const SizedBox(height: AppSpacing.sm),
                Text(mgr.bio ?? 'No management bio added.'),
                const SizedBox(height: AppSpacing.md),
                Text('Represented Creators Count: ${mgr.representedCreatorsCount}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
