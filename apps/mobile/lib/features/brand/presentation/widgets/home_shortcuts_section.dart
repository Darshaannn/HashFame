import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';

class HomeShortcutsSection extends StatelessWidget {
  const HomeShortcutsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Shortlists Shortcut
          Expanded(
            child: _ShortcutCard(
              title: 'Shortlists',
              subtitle: 'Your saved creators',
              icon: Icons.bookmark_border,
              onTap: () => context.push('/shortlists'),
            ),
          ),
          const SizedBox(width: 12),

          // Profile Shortcut
          Expanded(
            child: _ShortcutCard(
              title: 'Profile',
              subtitle: 'Manage your brand',
              icon: Icons.person_outline,
              onTap: () => context.push('/profile'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  const _ShortcutCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderGray, width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.burgundy,
              size: 22,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppTypography.hindFont,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: AppTypography.hindFont,
                      fontSize: 10,
                      color: AppColors.secondaryGray,
                      height: 1.15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: AppColors.secondaryGray,
            ),
          ],
        ),
      ),
    );
  }
}

