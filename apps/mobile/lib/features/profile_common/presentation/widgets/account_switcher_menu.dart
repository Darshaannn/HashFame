import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../demo/demo_repositories.dart';
import '../../../../demo/demo_store.dart';
import '../../../account/domain/account.dart';
import '../../../account/presentation/account_controller.dart';
import '../../../auth/presentation/session_controller.dart';
import '../../../creator/presentation/profile/creator_profile_controller.dart';
import 'unified_profile_widgets.dart';

/// Consistent top-right account avatar button for Brand, Creator, and Agency Home screens.
class GGAccountAvatarButton extends ConsumerWidget {
  const GGAccountAvatarButton({super.key, this.darkBackground = false});

  final bool darkBackground;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final displayName = session.snapshot?.account.displayName ?? 'GG';
    final initials = _initialsFor(displayName);

    return IconButton(
      key: const Key('gg_account_switcher_button'),
      tooltip: 'Account Menu',
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
      onPressed: () => GGAccountSwitcherMenu.show(context),
      icon: CircleAvatar(
        radius: 14,
        backgroundColor: darkBackground
            ? AppColors.burgundy
            : AppColors.burgundy.withValues(alpha: 0.12),
        child: Text(
          initials,
          style: TextStyle(
            fontFamily: AppTypography.khandFont,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: darkBackground ? AppColors.white : AppColors.burgundy,
          ),
        ),
      ),
    );
  }

  String _initialsFor(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'GG';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

/// Shared account management menu opened from the top-right account button.
class GGAccountSwitcherMenu extends ConsumerWidget {
  const GGAccountSwitcherMenu({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const GGAccountSwitcherMenu(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final account = session.snapshot?.account;
    final authRepo = ref.watch(authRepositoryProvider);
    final isDemo = authRepo is DemoAuthRepository;
    final role = account?.primaryRoleLabel;
    final isServerAdmin = !isDemo && role == ProfessionalRole.admin;
    final email = isDemo ? 'Offline Demo Persona' : 'Authenticated Session';
    final displayName = account?.displayName ?? 'GGs Account';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Identity Header
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.burgundy.withValues(alpha: 0.12),
                  child: Text(
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : 'G',
                    style: const TextStyle(
                      fontFamily: AppTypography.khandFont,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.burgundy,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontFamily: AppTypography.khandFont,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (email.isNotEmpty)
                        Text(
                          email,
                          style: const TextStyle(
                            fontFamily: AppTypography.hindFont,
                            fontSize: 12,
                            color: AppColors.secondaryGray,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                if (role != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.burgundy.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      role.label,
                      style: const TextStyle(
                        fontFamily: AppTypography.hindFont,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.burgundy,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.borderGray),
            const SizedBox(height: 8),

            // Demo-only quick switcher
            if (isDemo) ...[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  'Demo Account Switcher',
                  style: TextStyle(
                    fontFamily: AppTypography.khandFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.burgundy,
                  ),
                ),
              ),
              _demoRoleTile(
                context,
                ref,
                role: ProfessionalRole.brandMarketer,
                label: 'Brand Demo',
                icon: Icons.storefront_outlined,
                selected: role == ProfessionalRole.brandMarketer,
              ),
              _demoRoleTile(
                context,
                ref,
                role: ProfessionalRole.creator,
                label: 'Creator Demo',
                icon: Icons.camera_alt_outlined,
                selected: role == ProfessionalRole.creator,
              ),
              _demoRoleTile(
                context,
                ref,
                role: ProfessionalRole.agency,
                label: 'Agency Demo',
                icon: Icons.business_center_outlined,
                selected: role == ProfessionalRole.agency,
              ),
              const Divider(height: 16, color: AppColors.borderGray),
            ],

            // Switch Account (Real Supabase OTP flow)
            if (!isDemo)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.switch_account_outlined,
                  color: AppColors.black,
                ),
                title: const Text(
                  'Switch Account',
                  style: TextStyle(
                    fontFamily: AppTypography.hindFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Sign out and authenticate with another email',
                  style: TextStyle(
                    fontFamily: AppTypography.hindFont,
                    fontSize: 12,
                    color: AppColors.secondaryGray,
                  ),
                ),
                onTap: () => _confirmSwitchRealAccount(context, ref),
              ),

            // My Profile
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person_outline, color: AppColors.black),
              title: const Text(
                'My Profile',
                style: TextStyle(
                  fontFamily: AppTypography.hindFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                context.go('/profile');
              },
            ),

            // Settings
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.settings_outlined,
                color: AppColors.black,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontFamily: AppTypography.hindFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                context.push('/settings');
              },
            ),

            // Admin Dashboard (strictly for server-authorized admins)
            if (isServerAdmin)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: AppColors.burgundy,
                ),
                title: const Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    fontFamily: AppTypography.hindFont,
                    fontWeight: FontWeight.w700,
                    color: AppColors.burgundy,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/home/admin');
                },
              ),

            const Divider(height: 16, color: AppColors.borderGray),

            // Sign Out
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: const Text(
                'Sign Out',
                style: TextStyle(
                  fontFamily: AppTypography.hindFont,
                  fontWeight: FontWeight.w700,
                  color: AppColors.error,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                GGSignOutDialog.show(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _demoRoleTile(
    BuildContext context,
    WidgetRef ref, {
    required ProfessionalRole role,
    required String label,
    required IconData icon,
    required bool selected,
  }) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: selected ? AppColors.burgundy : AppColors.black,
        size: 20,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: AppTypography.hindFont,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.burgundy : AppColors.black,
        ),
      ),
      trailing: selected
          ? const Icon(Icons.check_circle, color: AppColors.burgundy, size: 18)
          : null,
      onTap: () {
        Navigator.of(context).pop();
        switchDemoRole(context, ref, role);
      },
    );
  }

  /// Switches the active persona in offline Demo Mode only.
  static void switchDemoRole(
    BuildContext context,
    WidgetRef ref,
    ProfessionalRole role,
  ) {
    final authRepo = ref.read(authRepositoryProvider);
    if (authRepo is! DemoAuthRepository) return;

    DemoStore.instance.currentRole = role;
    authRepo.notifyRoleChanged();
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
  }

  Future<void> _confirmSwitchRealAccount(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        title: const Text('Switch account?', style: AppTypography.heading),
        content: const Text(
          'You will be signed out of your current account and taken to sign in with a different email.',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.burgundy,
              foregroundColor: AppColors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Switch Account'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      Navigator.of(context).pop();
      ref.read(selectedRoleProvider.notifier).clear();
      await ref.read(accountActionProvider.notifier).logout();
      if (context.mounted) {
        context.go('/welcome');
      }
    }
  }
}
