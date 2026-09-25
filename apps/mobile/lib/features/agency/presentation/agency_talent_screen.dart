import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../../demo/demo_store.dart';
import '../../discovery/presentation/widgets/creator_discovery_card.dart';
import '../../profile_common/presentation/generic_role_shell.dart';

class AgencyTalentScreen extends ConsumerWidget {
  const AgencyTalentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Curated represented talent from DemoStore
    final talentList = DemoStore.instance.discoveryItems
        .where((c) => c.isRepresented)
        .toList();

    return GenericRoleShell(
      currentIndex: 3,
      onNavigationIndexChanged: (idx) {
        if (idx == 0) context.go('/home/agency');
        if (idx == 1) context.go('/discover');
        if (idx == 2) context.go('/campaigns');
        if (idx == 3) return;
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
        title: 'Managed Talent Roster',
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            tooltip: 'Add Talent',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Creator invitation & manager authorization flow opens in Phase 3.',
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Represented Roster (${talentList.length})',
                  style: AppTypography.heading,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              const AppBadge(
                label: 'Pulse Talent Agency',
                backgroundColor: AppColors.accentLight,
                textColor: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Creators with active agency representation and management contracts.',
            style: TextStyle(color: AppColors.muted, fontSize: 13),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (talentList.isEmpty)
            const AppEmptyState(
              title: 'No managed talent',
              message: 'Add creators to your agency roster to manage their campaigns and deliverables.',
            )
          else
            for (final creator in talentList)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: CreatorDiscoveryCard(
                  creator: creator,
                  onTap: () =>
                      context.push('/discover/creator/${creator.creatorId}'),
                ),
              ),
        ],
      ),
    );
  }
}
