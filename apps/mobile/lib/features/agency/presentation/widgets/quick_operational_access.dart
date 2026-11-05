import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/tokens.dart';

class QuickOperationalAccess extends StatelessWidget {
  const QuickOperationalAccess({
    super.key,
    this.onDemoModeTap,
  });

  final VoidCallback? onDemoModeTap;

  @override
  Widget build(BuildContext context) {
    final actions = [
      _OperationalAction(
        label: 'Creator\nDiscovery',
        icon: Icons.search_rounded,
        onTap: () => context.go('/discover'),
      ),
      _OperationalAction(
        label: 'Talent\nRoster',
        icon: Icons.groups_outlined,
        onTap: () => context.go('/talent'),
      ),
      _OperationalAction(
        label: 'Campaign\nManagement',
        icon: Icons.campaign_outlined,
        onTap: () => context.go('/campaigns'),
      ),
      _OperationalAction(
        label: 'Applicant\nReview',
        icon: Icons.assignment_outlined,
        onTap: () => context.go('/campaigns'),
      ),
      _OperationalAction(
        label: 'Org.\nCollaborations',
        icon: Icons.handshake_outlined,
        onTap: () => context.push('/collaborations'),
      ),
      _OperationalAction(
        label: 'Agency\nProfile',
        icon: Icons.business_outlined,
        onTap: () => context.go('/profile'),
      ),
      _OperationalAction(
        label: 'Agency\nServices',
        icon: Icons.layers_outlined,
        onTap: () => context.push('/profile/edit/agency'),
      ),
      _OperationalAction(
        label: 'Settings',
        icon: Icons.settings_outlined,
        onTap: () => context.push('/settings'),
      ),
      _OperationalAction(
        label: 'Demo\nMode',
        icon: Icons.swap_horiz_rounded,
        onTap: () {
          if (onDemoModeTap != null) {
            onDemoModeTap!();
          } else {
            context.go('/demo');
          }
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text(
                'QUICK OPERATIONAL ACCESS',
                style: TextStyle(
                  fontFamily: AppTypography.khandFont,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: AppColors.black,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 1.5,
                color: AppColors.burgundy,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Horizontally scrollable strip of tool icons
        SizedBox(
          height: 70,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: actions.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final action = actions[index];
              return InkWell(
                onTap: action.onTap,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 58,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        action.icon,
                        size: 22,
                        color: AppColors.burgundy,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        action.label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTypography.hindFont,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OperationalAction {
  const _OperationalAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
}

