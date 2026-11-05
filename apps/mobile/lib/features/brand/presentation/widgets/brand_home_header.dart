import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../demo/demo_repositories.dart';
import '../../../../demo/demo_store.dart';
import '../../../account/domain/account.dart';
import '../../../auth/presentation/session_controller.dart';
import '../../../creator/presentation/profile/creator_profile_controller.dart';
import '../../../discovery/presentation/discovery_controller.dart';
import '../../../shortlist/presentation/shortlist_controller.dart';

class BrandHomeHeader extends ConsumerWidget {
  const BrandHomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDemo = ref.watch(authRepositoryProvider) is DemoAuthRepository;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.borderGray, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // GGs. Wordmark in burgundy
            const Text(
              'GGs.',
              style: TextStyle(
                fontFamily: AppTypography.khandFont,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.burgundy,
                letterSpacing: -0.5,
                height: 1.0,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              height: 18,
              width: 1,
              color: AppColors.borderGray,
            ),
            const SizedBox(width: 6),

            // Role Selector Pill (Brand / Marketer with dropdown)
            Flexible(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _showRoleSwitchSheet(context, ref),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderGray, width: 1),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.swap_horiz,
                        size: 14,
                        color: AppColors.black,
                      ),
                      SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          'BRAND / MARKETER',
                          style: TextStyle(
                            fontFamily: AppTypography.hindFont,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                            color: AppColors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 14,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (isDemo) ...[
              const SizedBox(width: 6),
              Container(
                height: 18,
                width: 1,
                color: AppColors.borderGray,
              ),
              const SizedBox(width: 6),
              const Text(
                'PREVIEW',
                style: TextStyle(
                  fontFamily: AppTypography.hindFont,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.secondaryGray,
                ),
              ),
            ],

            const Spacer(),

            // Notification Icon
            IconButton(
              icon: const Icon(Icons.notifications_none, size: 20),
              color: AppColors.black,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              tooltip: 'Activity & Notifications',
              onPressed: () => context.push('/activity'),
            ),

            // Settings Icon
            IconButton(
              icon: const Icon(Icons.settings_outlined, size: 20),
              color: AppColors.black,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              tooltip: 'Settings',
              onPressed: () => context.push('/settings'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRoleSwitchSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'SWITCH VIEWING ROLE',
                    style: TextStyle(
                      fontFamily: AppTypography.khandFont,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.business, color: AppColors.burgundy),
                  title: const Text('Brand / Marketer (Current)'),
                  trailing: const Icon(Icons.check, color: AppColors.burgundy),
                  onTap: () => Navigator.pop(sheetContext),
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: AppColors.black),
                  title: const Text('Creator Workspace'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _switchRole(context, ref, ProfessionalRole.creator);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.apartment, color: AppColors.black),
                  title: const Text('Agency Talent Manager'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _switchRole(context, ref, ProfessionalRole.agency);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _switchRole(
    BuildContext context,
    WidgetRef ref,
    ProfessionalRole role,
  ) {
    DemoStore.instance.currentRole = role;
    final authRepo = ref.read(authRepositoryProvider);
    if (authRepo is DemoAuthRepository) {
      authRepo.notifyRoleChanged();
    }
    ref.read(sessionProvider.notifier).refresh();
    ref.invalidate(shortlistsListProvider);
    ref.invalidate(discoveryControllerProvider);
    ref.invalidate(currentCreatorProfileProvider);

    if (context.mounted) {
      final path = switch (role) {
        ProfessionalRole.creator => '/home/creator',
        ProfessionalRole.agency => '/home/agency',
        _ => '/home/brand_marketer',
      };
      context.go(path);
    }
  }
}
