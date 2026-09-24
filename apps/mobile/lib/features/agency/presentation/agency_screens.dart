import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/features/account/presentation/account_controller.dart';
import 'package:ggs_mobile/features/agency/domain/agency_profile.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';

final agencyProfileProvider = FutureProvider.autoDispose<AgencyProfile>((ref) async {
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

    if (snapshot == null) {
      return const AppScaffold(title: 'Agency Home', children: [AppSkeleton()]);
    }

    final account = snapshot.account;

    return AppScaffold(
      title: 'Agency Workspace',
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
                  Text('Agency: ${account.displayName}', style: AppTypography.heading),
                  const Text('Full-Service Creator Operations', style: TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        agencyAsync.when(
          loading: () => const AppSkeleton(),
          error: (e, _) => AppErrorState(message: mapFailure(e).message),
          data: (agency) => AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(agency.agencyName.isEmpty ? 'Agency Setup' : agency.agencyName, style: AppTypography.heading),
                const SizedBox(height: AppSpacing.sm),
                if (agency.location != null) Text('Location: ${agency.location}'),
                if (agency.website != null) Text('Website: ${agency.website}'),
                const SizedBox(height: AppSpacing.sm),
                Text(agency.description ?? 'Set up your agency capabilities and managed rosters.'),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton(
                  onPressed: () => context.go('/profile'),
                  child: const Text('View Agency Profile'),
                ),
              ],
            ),
          ),
        ),

        const AppEmptyState(
          title: 'Managed Creator Rosters & Client Campaigns',
          message: 'Multi-creator roster management and agency client billing workspaces will unlock in Phase 2C.',
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

class AgencyProfileScreen extends ConsumerWidget {
  const AgencyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agencyAsync = ref.watch(agencyProfileProvider);

    return AppScaffold(
      title: 'Agency Profile',
      children: [
        agencyAsync.when(
          loading: () => const AppSkeleton(),
          error: (e, _) => AppErrorState(
            message: mapFailure(e).message,
            onRetry: () => ref.invalidate(agencyProfileProvider),
          ),
          data: (agency) => AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(agency.agencyName, style: AppTypography.heading),
                if (agency.website != null) Text('Website: ${agency.website}'),
                if (agency.location != null) Text('Location: ${agency.location}'),
                const SizedBox(height: AppSpacing.sm),
                Text(agency.description ?? 'No agency description provided.'),
                const SizedBox(height: AppSpacing.md),
                if (agency.services.isNotEmpty) ...[
                  const Text('Services Offered:', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    children: agency.services.map((s) => AppBadge(label: s)).toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
