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

class AgencyHomeHeader extends ConsumerWidget {
  const AgencyHomeHeader({
    super.key,
    this.onRoleSelected,
  });

  final ValueChanged<ProfessionalRole>? onRoleSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDemo = ref.watch(authRepositoryProvider) is DemoAuthRepository;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.borderGray, width: 0.8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // GGs Wordmark in Burgundy
            const Text(
              'GGs',
              style: TextStyle(
                fontFamily: AppTypography.khandFont,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.burgundy,
                letterSpacing: -0.5,
                height: 1.0,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 16,
              width: 1,
              color: AppColors.borderGray,
            ),
            const SizedBox(width: 8),

            // Agency Demo Dropdown Pill
            if (isDemo) _buildRoleDropdown(context, ref),

            const Spacer(),

            // Notification Bell with unread badge dot
            IconButton(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.black,
                    size: 22,
                  ),
                  Positioned(
                    top: -1,
                    right: -1,
                    child: Container(
                      width: 6.5,
                      height: 6.5,
                      decoration: const BoxDecoration(
                        color: AppColors.burgundy,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
              tooltip: 'Notifications / Activity',
              onPressed: () => context.push('/activity'),
            ),

            const SizedBox(width: 4),

            // Profile Icon
            IconButton(
              icon: const Icon(
                Icons.account_circle_outlined,
                color: AppColors.black,
                size: 23,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
              tooltip: 'Agency Profile',
              onPressed: () => context.go('/profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleDropdown(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final currentRole = session.snapshot?.account.primaryRoleLabel ?? ProfessionalRole.agency;

    final roles = [
      (ProfessionalRole.brandMarketer, 'Brand Demo'),
      (ProfessionalRole.creator, 'Creator Demo'),
      (ProfessionalRole.agency, 'Agency Demo'),
    ];

    final currentLabel = roles
        .firstWhere(
          (r) => r.$1 == currentRole,
          orElse: () => (ProfessionalRole.agency, 'Agency Demo'),
        )
        .$2;

    return PopupMenuButton<ProfessionalRole>(
      tooltip: 'Switch Demo Persona',
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.borderGray, width: 0.8),
      ),
      onSelected: (role) async {
        if (onRoleSelected != null) {
          onRoleSelected!(role);
          return;
        }

        DemoStore.instance.currentRole = role;
        final authRepo = ref.read(authRepositoryProvider);
        if (authRepo is DemoAuthRepository) {
          authRepo.notifyRoleChanged();
        }
        ref.read(sessionProvider.notifier).refresh();
        ref.invalidate(currentCreatorProfileProvider);

        if (!context.mounted) return;

        switch (role) {
          case ProfessionalRole.brandMarketer:
            context.go('/home/brand_marketer');
            break;
          case ProfessionalRole.creator:
            context.go('/home/creator');
            break;
          case ProfessionalRole.agency:
          case ProfessionalRole.talentManager:
            context.go('/home/agency');
            break;
          case ProfessionalRole.admin:
            break;
        }
      },
      itemBuilder: (context) => [
        for (final (role, label) in roles)
          PopupMenuItem<ProfessionalRole>(
            value: role,
            height: 40,
            child: Row(
              children: [
                Icon(
                  role == currentRole
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked,
                  size: 16,
                  color: role == currentRole ? AppColors.burgundy : AppColors.secondaryGray,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: AppTypography.hindFont,
                    fontSize: 13,
                    fontWeight: role == currentRole ? FontWeight.w600 : FontWeight.w400,
                    color: role == currentRole ? AppColors.burgundy : AppColors.black,
                  ),
                ),
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF9EBEB),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.burgundy.withValues(alpha: 0.2), width: 0.8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentLabel,
              style: const TextStyle(
                fontFamily: AppTypography.hindFont,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: AppColors.burgundy,
              ),
            ),
            const SizedBox(width: 3),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.burgundy,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

