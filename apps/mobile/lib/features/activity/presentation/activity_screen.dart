import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../creator/presentation/creator_shell.dart';

class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    this.route,
  });

  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  final Color iconColor;
  final String? route;
}

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDemo = ref.watch(configProvider).name == 'GGs Demo';

    final demoActivities = [
      const ActivityItem(
        id: 'act_1',
        title: 'Application Selected',
        subtitle: 'Nova Beauty India selected your application for Glow Forward — Festive Beauty!',
        timeAgo: '2 hours ago',
        icon: Icons.check_circle_outline,
        iconColor: AppColors.success,
        route: '/applications',
      ),
      const ActivityItem(
        id: 'act_2',
        title: 'Shortlisted by Brand',
        subtitle: 'You were added to "Summer Beauty Launch" shortlist by Nova Consumer Brands.',
        timeAgo: '1 day ago',
        icon: Icons.bookmark_added_outlined,
        iconColor: AppColors.primary,
        route: '/profile',
      ),
      const ActivityItem(
        id: 'act_3',
        title: 'New Campaign Matched',
        subtitle: 'Nova Active posted a new campaign matching your Health & Fitness category.',
        timeAgo: '2 days ago',
        icon: Icons.campaign_outlined,
        iconColor: AppColors.accent,
        route: '/opportunities',
      ),
      const ActivityItem(
        id: 'act_4',
        title: 'Profile Updated',
        subtitle: 'Your rate card and deliverable pricing were successfully synchronized.',
        timeAgo: '3 days ago',
        icon: Icons.person_outline,
        iconColor: AppColors.inkSecondary,
        route: '/profile/edit/rates',
      ),
    ];

    return CreatorShell(
      currentIndex: 3,
      onNavigationIndexChanged: (idx) {
        if (idx == 0) context.go('/home/creator');
        if (idx == 1) context.go('/opportunities');
        if (idx == 2) context.go('/applications');
        if (idx == 3) return;
        if (idx == 4) context.go('/profile');
      },
      child: AppScaffold(
        title: 'Activity Feed',
        children: [
          if (!isDemo)
            const AppEmptyState(
              title: 'No activity yet',
              message: 'Live notifications and campaign activity updates will appear here in Phase 2D.',
            )
          else ...[
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.notifications_active_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Recent Updates & Alerts',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inkSecondary,
                    ),
                  ),
                ],
              ),
            ),
            for (final act in demoActivities)
              AppCard(
                onTap: act.route != null ? () => context.go(act.route!) : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: act.iconColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(act.icon, size: 20, color: act.iconColor),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                act.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: AppColors.ink,
                                ),
                              ),
                              Text(
                                act.timeAgo,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            act.subtitle,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.inkSecondary,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
