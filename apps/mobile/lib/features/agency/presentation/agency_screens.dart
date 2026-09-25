import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/features/agency/domain/agency_profile.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';
import 'package:ggs_mobile/features/profile_common/presentation/generic_role_shell.dart';
import 'package:ggs_mobile/features/profile_common/presentation/widgets/unified_profile_widgets.dart';

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

    if (snapshot == null) {
      return const AppScaffold(title: 'Agency Home', children: [AppSkeleton()]);
    }

    final account = snapshot.account;
    final agency = agencyAsync.value;
    final agencyName = agency?.agencyName.isNotEmpty == true
        ? agency!.agencyName
        : 'Pulse Talent Agency';

    return GenericRoleShell(
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
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Discover',
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
        title: 'Agency Workspace',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
          ),
        ],
        children: [
          // Header
          GGProfileHeader(
            name: account.displayName,
            roleOrTitle: 'Agency Director',
            organization: agencyName,
            isVerified: true,
            onEditPressed: () => context.push('/profile/edit/agency'),
          ),

          // Quick Actions
          GGSettingsSection(
            title: 'Agency Actions',
            children: [
              GGAccountActionTile(
                title: 'Discover & Search Creators',
                subtitle: 'Find new talent to scout or represent',
                icon: Icons.search,
                onTap: () => context.go('/discover'),
              ),
              GGAccountActionTile(
                title: 'Client Campaigns',
                subtitle: 'Manage active pitches and brand proposals',
                icon: Icons.campaign_outlined,
                onTap: () => context.go('/campaigns'),
              ),
              GGAccountActionTile(
                title: 'Managed Talent Roster',
                subtitle: 'View represented creators and contracts',
                icon: Icons.groups_outlined,
                onTap: () => context.go('/talent'),
              ),
              GGAccountActionTile(
                title: 'Agency Profile & Services',
                subtitle: 'Configure agency portfolio and contact terms',
                icon: Icons.business_outlined,
                onTap: () => context.go('/profile'),
              ),
            ],
          ),

          // Agency Organization Card
          agencyAsync.when(
            loading: () => const AppSkeleton(count: 1),
            error: (e, _) => AppErrorState(message: mapFailure(e).message),
            data: (ag) => AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ag.agencyName.isEmpty
                              ? 'Agency Overview'
                              : ag.agencyName,
                          style: AppTypography.heading,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const AppBadge(label: 'Verified Agency'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (ag.location != null)
                    Text(
                      'Headquarters: ${ag.location}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  if (ag.website != null) Text('Website: ${ag.website}'),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    ag.description ?? 'Premier creator talent representation & digital media strategy.',
                    style: const TextStyle(
                      color: AppColors.inkSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  OutlinedButton(
                    onPressed: () => context.go('/profile'),
                    child: const Text('View Agency Profile'),
                  ),
                ],
              ),
            ),
          ),
        ],
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
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Discover',
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
