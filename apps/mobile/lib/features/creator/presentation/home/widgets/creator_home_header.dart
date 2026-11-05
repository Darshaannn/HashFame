import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/providers.dart';
import '../../../../../core/design_system/tokens.dart';
import '../../../../../demo/demo_repositories.dart';
import '../../../../../demo/demo_store.dart';
import '../../../../account/domain/account.dart';
import '../../../../auth/presentation/session_controller.dart';
import '../../profile/creator_profile_controller.dart';

class CreatorHomeHeader extends ConsumerWidget {
  const CreatorHomeHeader({
    super.key,
    this.onRoleSelected,
  });

  final ValueChanged<ProfessionalRole>? onRoleSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDemo = ref.watch(authRepositoryProvider) is DemoAuthRepository;

    return Container(
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // GGs Wordmark in White
            const Text(
              'GGs',
              style: TextStyle(
                fontFamily: AppTypography.khandFont,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                letterSpacing: -0.5,
                height: 1.0,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 18,
              width: 1,
              color: Colors.white24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Creator Home',
              style: TextStyle(
                fontFamily: AppTypography.hindFont,
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

            // Role Dropdown Pill in Demo Mode
            if (isDemo) ...[
              _buildRoleDropdown(context, ref),
              const SizedBox(width: 8),
            ],

            // Notification Bell with unread badge dot
            IconButton(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.white,
                    size: 24,
                  ),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.burgundy,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              tooltip: 'Notifications',
              onPressed: () => context.go('/activity'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleDropdown(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final currentRole = session.snapshot?.account.primaryRoleLabel ?? ProfessionalRole.creator;

    final roles = [
      (ProfessionalRole.brandMarketer, 'Brand Demo'),
      (ProfessionalRole.creator, 'Creator Demo'),
      (ProfessionalRole.agency, 'Agency Demo'),
    ];

    final currentLabel = roles
        .firstWhere(
          (r) => r.$1 == currentRole,
          orElse: () => (ProfessionalRole.creator, 'Creator Demo'),
        )
        .$2;

    return PopupMenuButton<ProfessionalRole>(
      tooltip: 'Switch Demo Persona',
      color: const Color(0xFF222222),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white24, width: 0.8),
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
                  color: role == currentRole ? AppColors.burgundy : Colors.white60,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: AppTypography.hindFont,
                    fontSize: 13,
                    fontWeight: role == currentRole ? FontWeight.w600 : FontWeight.w400,
                    color: role == currentRole ? AppColors.white : Colors.white70,
                  ),
                ),
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.burgundy,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentLabel,
              style: const TextStyle(
                fontFamily: AppTypography.hindFont,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
