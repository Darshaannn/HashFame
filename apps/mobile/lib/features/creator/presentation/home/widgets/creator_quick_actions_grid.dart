import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/design_system/tokens.dart';

class CreatorQuickActionsGrid extends StatelessWidget {
  const CreatorQuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          // Row 1 (5 items)
          Row(
            children: [
              Expanded(
                child: _QuickActionTile(
                  label: 'Discover\nWork',
                  icon: Icons.search,
                  onTap: () => context.go('/opportunities'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuickActionTile(
                  label: 'My\nApplications',
                  icon: Icons.assignment_outlined,
                  onTap: () => context.go('/applications'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuickActionTile(
                  label: 'My\nCollaborations',
                  icon: Icons.handshake_outlined,
                  onTap: () => context.push('/collaborations'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuickActionTile(
                  label: 'Edit\nProfile',
                  icon: Icons.edit_outlined,
                  onTap: () => context.push('/profile/edit'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuickActionTile(
                  label: 'Rate\nCard',
                  icon: Icons.payments_outlined,
                  onTap: () => context.push('/profile/edit/rates'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Row 2 (4 items)
          Row(
            children: [
              Expanded(
                child: _QuickActionTile(
                  label: 'Portfolio',
                  icon: Icons.photo_size_select_actual_outlined,
                  onTap: () => context.push('/profile/edit/portfolio'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuickActionTile(
                  label: 'Pending\nRevisions',
                  icon: Icons.sync,
                  onTap: () => context.push('/collaborations'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuickActionTile(
                  label: 'Activity /\nNotifications',
                  icon: Icons.notifications_none_outlined,
                  onTap: () => context.push('/activity'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuickActionTile(
                  label: 'Settings',
                  icon: Icons.settings_outlined,
                  onTap: () => context.push('/settings'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGray, width: 0.8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: AppColors.burgundy,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppTypography.hindFont,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                height: 1.15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

