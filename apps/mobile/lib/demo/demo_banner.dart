import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';
import 'package:ggs_mobile/features/campaign/presentation/campaign_controller.dart';
import 'package:ggs_mobile/features/creator/presentation/profile/creator_profile_controller.dart';
import 'package:ggs_mobile/features/discovery/presentation/discovery_controller.dart';
import 'package:ggs_mobile/features/shortlist/presentation/shortlist_controller.dart';

import 'package:go_router/go_router.dart';

import 'demo_repositories.dart';
import 'demo_store.dart';

/// Small, unobtrusive Demo Top Bar with role switcher & reset actions.
class DemoTopBanner extends ConsumerWidget implements PreferredSizeWidget {
  const DemoTopBanner({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(32);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRole = DemoStore.instance.currentRole;

    return Container(
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 3,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 0.8,
                ),
              ),
              child: const Text(
                'DEMO',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                  fontSize: 9.5,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Viewing as ${currentRole.label}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                size: 16,
                color: Colors.white70,
              ),
              tooltip: 'Switch Presentation Role',
              onSelected: (value) async {
                if (value == 'switch_brand') {
                  _switchRole(context, ref, ProfessionalRole.brandMarketer);
                } else if (value == 'switch_creator') {
                  _switchRole(context, ref, ProfessionalRole.creator);
                } else if (value == 'switch_agency') {
                  _switchRole(context, ref, ProfessionalRole.agency);
                } else if (value == 'reset_data') {
                  _resetDemoData(context, ref);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'switch_brand',
                  child: Row(
                    children: [
                      Icon(Icons.business, size: 16, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text('View as Brand Marketer'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'switch_creator',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 16, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text('View as Creator'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'switch_agency',
                  child: Row(
                    children: [
                      Icon(Icons.apartment, size: 16, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text('View as Agency'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'reset_data',
                  child: Row(
                    children: [
                      Icon(Icons.restart_alt, size: 16, color: AppColors.error),
                      SizedBox(width: 8),
                      Text(
                        'Reset Demo Data',
                        style: TextStyle(color: AppColors.error),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _switchRole(
    BuildContext context,
    WidgetRef ref,
    ProfessionalRole newRole,
  ) {
    DemoStore.instance.currentRole = newRole;
    final authRepo = ref.read(authRepositoryProvider);
    if (authRepo is DemoAuthRepository) {
      authRepo.notifyRoleChanged();
    }
    ref.read(sessionProvider.notifier).refresh();
    ref.invalidate(shortlistsListProvider);
    ref.invalidate(discoveryControllerProvider);
    ref.invalidate(currentCreatorProfileProvider);
    ref.invalidate(opportunitySearchControllerProvider);

    final path = switch (newRole) {
      ProfessionalRole.brandMarketer => '/home/brand_marketer',
      ProfessionalRole.creator => '/home/creator',
      ProfessionalRole.agency => '/home/agency',
      _ => '/home/brand_marketer',
    };
    context.go(path);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text('Switched view to ${newRole.label}'),
      ),
    );
  }

  void _resetDemoData(BuildContext context, WidgetRef ref) {
    DemoStore.instance.reset();
    final authRepo = ref.read(authRepositoryProvider);
    if (authRepo is DemoAuthRepository) {
      authRepo.notifyRoleChanged();
    }
    ref.read(sessionProvider.notifier).refresh();
    ref.invalidate(shortlistsListProvider);
    ref.invalidate(discoveryControllerProvider);
    ref.invalidate(currentCreatorProfileProvider);
    ref.invalidate(opportunitySearchControllerProvider);

    final path = switch (DemoStore.instance.currentRole) {
      ProfessionalRole.brandMarketer => '/home/brand_marketer',
      ProfessionalRole.creator => '/home/creator',
      ProfessionalRole.agency => '/home/agency',
      _ => '/home/brand_marketer',
    };
    context.go(path);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Demo data reset to initial clean seed!'),
      ),
    );
  }
}
