import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';

class AgencyShortcutGrid extends StatelessWidget {
  const AgencyShortcutGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Row 1
          Row(
            children: [
              Expanded(
                child: _buildTile(
                  context,
                  label: 'Discover\nCreators',
                  icon: Icons.search_rounded,
                  onTap: () => context.go('/discover'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTile(
                  context,
                  label: 'Client\nCampaigns',
                  icon: Icons.campaign_outlined,
                  onTap: () => context.go('/campaigns'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTile(
                  context,
                  label: 'Managed\nTalent',
                  icon: Icons.groups_outlined,
                  onTap: () => context.go('/talent'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Row 2
          Row(
            children: [
              Expanded(
                child: _buildTile(
                  context,
                  label: 'Agency\nProfile / Services',
                  icon: Icons.business_outlined,
                  onTap: () => context.go('/profile'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTile(
                  context,
                  label: 'Settings',
                  icon: Icons.settings_outlined,
                  onTap: () => context.push('/settings'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTile(
                  context,
                  label: 'Notifications /\nActivity',
                  icon: Icons.notifications_none_rounded,
                  onTap: () => context.push('/activity'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderGray, width: 0.6),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: AppColors.burgundy,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: AppTypography.hindFont,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  height: 1.15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 2),
            const Text(
              '→',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.burgundy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

