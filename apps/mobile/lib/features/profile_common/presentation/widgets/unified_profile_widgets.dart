import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers.dart';
import '../../../../core/design_system/components.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../account/domain/account.dart';
import '../../../account/presentation/account_controller.dart';
import '../../../auth/presentation/session_controller.dart';
import '../../../../demo/demo_repositories.dart';
import '../../../../demo/demo_store.dart';

/// Top profile card with user avatar, display name, handle/role, optional organization and verification badge.
class GGProfileHeader extends StatelessWidget {
  const GGProfileHeader({
    super.key,
    required this.name,
    required this.roleOrTitle,
    this.handle,
    this.organization,
    this.isVerified = false,
    this.onEditPressed,
    this.avatarLabel,
  });

  final String name;
  final String roleOrTitle;
  final String? handle;
  final String? organization;
  final bool isVerified;
  final VoidCallback? onEditPressed;
  final String? avatarLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                label: avatarLabel ?? (name.isNotEmpty ? name : 'User'),
                radius: 30,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name.isEmpty ? 'GGs User' : name,
                            style: AppTypography.heading,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.verified,
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ],
                      ],
                    ),
                    if (handle != null && handle!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        '@$handle',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    const SizedBox(height: 2),
                    Text(
                      roleOrTitle,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (organization != null && organization!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      GGOrganizationBadge(organization: organization!),
                    ],
                  ],
                ),
              ),
              if (onEditPressed != null)
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  tooltip: 'Edit Profile',
                  onPressed: onEditPressed,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Subtle organization chip showing current operational context
class GGOrganizationBadge extends StatelessWidget {
  const GGOrganizationBadge({super.key, required this.organization});

  final String organization;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubtle,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.outlineLight, width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.business_outlined,
            size: 13,
            color: AppColors.inkSecondary,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              organization,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.inkSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Settings / Menu Section container with title and grouped tiles
class GGSettingsSection extends StatelessWidget {
  const GGSettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: AppSpacing.xs),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: AppColors.muted,
            ),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
                  const Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppColors.outlineLight,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Standardized tappable action tile for profile menus and settings
class GGAccountActionTile extends StatelessWidget {
  const GGAccountActionTile({
    super.key,
    required this.title,
    required this.icon,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
  });

  final String title;
  final IconData icon;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isDestructive ? AppColors.error : AppColors.ink;
    final effectiveIconColor = isDestructive
        ? AppColors.error
        : AppColors.primary;

    return ListTile(
      onTap:
          onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title: Coming soon in upcoming phase.'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive ? AppColors.errorLight : AppColors.surfaceSubtle,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(icon, size: 20, color: effectiveIconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: effectiveColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(fontSize: 12, color: AppColors.muted),
            )
          : null,
      trailing:
          trailing ??
          Icon(
            Icons.chevron_right,
            size: 20,
            color: isDestructive ? AppColors.error : AppColors.muted,
          ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 4,
      ),
    );
  }
}

/// Standardized Sign Out confirmation dialog for Production & Demo
class GGSignOutDialog {
  static Future<void> show(BuildContext context, WidgetRef ref) async {
    final isDemo = DemoStore.instance.currentRole != ProfessionalRole.admin;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        title: const Text('Sign out?', style: AppTypography.heading),
        content: const Text(
          'You\'ll need to sign in again to access your account.',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      if (isDemo) {
        // Return to demo launcher in demo mode
        context.go('/demo');
      } else {
        await ref.read(accountActionProvider.notifier).logout();
        if (context.mounted) {
          context.go('/welcome');
        }
      }
    }
  }
}

/// Demo mode specific controls card (Role switcher, Reset data, Exit demo)
class GGDemoControlsCard extends ConsumerWidget {
  const GGDemoControlsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GGSettingsSection(
      title: 'Demo Environment',
      children: [
        GGAccountActionTile(
          title: 'Switch Demo Role',
          subtitle: 'Experience Brand, Creator, or Agency flows',
          icon: Icons.swap_horiz,
          onTap: () => _showRoleSwitchSheet(context, ref),
        ),
        GGAccountActionTile(
          title: 'Reset Demo Data',
          subtitle: 'Restore in-memory creators, shortlists & campaigns',
          icon: Icons.restart_alt,
          onTap: () => _confirmReset(context, ref),
        ),
        GGAccountActionTile(
          title: 'Exit Demo Mode',
          subtitle: 'Return to presentation landing screen',
          icon: Icons.logout,
          onTap: () => context.go('/demo'),
        ),
      ],
    );
  }

  void _showRoleSwitchSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Switch Demo Role', style: AppTypography.heading),
              const SizedBox(height: 4),
              const Text(
                'Select a presentation perspective to test its specific navigation flow.',
                style: TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              const SizedBox(height: AppSpacing.md),
              ListTile(
                leading: const Icon(
                  Icons.business_center,
                  color: AppColors.primary,
                ),
                title: const Text('Brand Marketer (Nova Beauty)'),
                subtitle: const Text(
                  'Discover creators, campaigns, shortlists',
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _switchRole(context, ref, ProfessionalRole.brandMarketer);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: AppColors.primary),
                title: const Text('Creator (Aisha Mehta)'),
                subtitle: const Text(
                  'Opportunities, applications, rate card, portfolio',
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _switchRole(context, ref, ProfessionalRole.creator);
                },
              ),
              ListTile(
                leading: const Icon(Icons.apartment, color: AppColors.primary),
                title: const Text('Agency (Pulse Talent)'),
                subtitle: const Text(
                  'Talent roster, discovery, campaign management',
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _switchRole(context, ref, ProfessionalRole.agency);
                },
              ),
            ],
          ),
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

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppDialog.confirm(
      context,
      title: 'Reset Demo Data?',
      message: 'This will restore all creators, shortlists, campaigns, and applications back to their clean initial seed.',
    );
    if (confirmed && context.mounted) {
      DemoStore.instance.reset();
      final authRepo = ref.read(authRepositoryProvider);
      if (authRepo is DemoAuthRepository) {
        authRepo.notifyRoleChanged();
      }
      ref.read(sessionProvider.notifier).refresh();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Demo data restored to initial clean seed!'),
        ),
      );
    }
  }
}
