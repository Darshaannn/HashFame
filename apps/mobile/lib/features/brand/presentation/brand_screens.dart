import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/features/account/presentation/account_controller.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';
import 'package:ggs_mobile/features/brand/domain/brand_profile.dart';

final brandProfileProvider = FutureProvider.autoDispose<BrandMarketerProfile>((ref) async {
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

    return AppScaffold(
      title: 'Brand & Marketer Home',
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
                  Text('Hello, ${account.displayName}', style: AppTypography.heading),
                  const Text('Marketer Workspace', style: TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        // Brand Organization Status Card
        brandAsync.when(
          loading: () => const AppSkeleton(),
          error: (e, _) => AppErrorState(message: mapFailure(e).message),
          data: (profile) => AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Company & Brand Profile', style: AppTypography.heading),
                const SizedBox(height: AppSpacing.sm),
                Text('Organization: ${profile.organizationName ?? 'Not yet linked to legal org'}'),
                if (profile.jobTitle != null && profile.jobTitle!.isNotEmpty)
                  Text('Role: ${profile.jobTitle}'),
                const SizedBox(height: AppSpacing.sm),
                Text('Managed Brands: ${profile.managedBrands.length} active'),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: () => context.go('/profile'),
                  icon: const Icon(Icons.business_outlined, size: 18),
                  label: const Text('Manage Brand Details'),
                ),
              ],
            ),
          ),
        ),

        // Quick Actions
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Marketer Actions', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppButton(
                    label: 'Discover Creators',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Creator search and discovery opens in Phase 2B.')),
                      );
                    },
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/profile'),
                    child: const Text('Company Profile'),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Campaigns Empty State
        const AppEmptyState(
          title: 'Campaigns & Collaboration Workspace',
          message: 'Campaign briefs, proposals, creator rosters, and deal workflows will be available in Phase 2C.',
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

class BrandProfileScreen extends ConsumerWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandAsync = ref.watch(brandProfileProvider);

    return AppScaffold(
      title: 'Company & Marketer Profile',
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
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.displayName, style: AppTypography.heading),
                    if (profile.jobTitle != null)
                      Text(profile.jobTitle!, style: const TextStyle(fontWeight: FontWeight.w500)),
                    if (profile.workEmail != null)
                      Text('Work Email: ${profile.workEmail}'),
                    if (profile.phone != null)
                      Text('Phone: ${profile.phone}'),
                    const SizedBox(height: AppSpacing.sm),
                    Text(profile.bio ?? 'No professional bio added.'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Organization / Brands', style: AppTypography.heading),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Organization Name: ${profile.organizationName ?? "Independent Marketer"}'),
                    const SizedBox(height: AppSpacing.sm),
                    if (profile.managedBrands.isEmpty)
                      const Text(
                        'No specific brands registered under this organization.',
                        style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.muted),
                      )
                    else
                      for (final b in profile.managedBrands)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(b.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text([b.industry, b.headquarters].whereType<String>().join(' • ')),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
