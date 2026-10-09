import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../../creator/presentation/creator_shell.dart';
import 'activity_controller.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final userId = session.snapshot?.account.id ?? '';
    final activityAsync = ref.watch(userActivityProvider(userId));

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
                const Expanded(
                  child: Text(
                    'Recent Updates & Collaboration Alerts',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inkSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          activityAsync.when(
            loading: () => const AppSkeleton(count: 3),
            error: (e, _) => AppErrorState(
              message: e.toString(),
              onRetry: () => ref.invalidate(userActivityProvider(userId)),
            ),
            data: (activities) {
              if (activities.isEmpty) {
                return const AppEmptyState(
                  title: 'No activity yet',
                  message: 'Updates on your applications, deliverable reviews, and brand messages will appear here.',
                );
              }

              return Column(
                children: [
                  for (final act in activities)
                    AppCard(
                      onTap: () {
                        if (!act.isRead) {
                          ref
                              .read(activityActionControllerProvider.notifier)
                              .markAsRead(act.id, userId);
                        }
                        if (act.route != null && act.route!.isNotEmpty) {
                          context.push(act.route!);
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _iconColorFor(act.activityType)
                                  .withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _iconFor(act.activityType),
                              size: 20,
                              color: _iconColorFor(act.activityType),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        act.title,
                                        style: TextStyle(
                                          fontWeight: act.isRead
                                              ? FontWeight.w600
                                              : FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.ink,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _formatTimeAgo(act.createdAt),
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
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String type) {
    return switch (type) {
      'application_selected' => Icons.check_circle_outline,
      'deliverable_approved' => Icons.verified_outlined,
      'revision_requested' => Icons.edit_note_outlined,
      'collaboration_completed' => Icons.emoji_events_outlined,
      'shortlisted' => Icons.bookmark_added_outlined,
      'new_message' => Icons.chat_bubble_outline,
      _ => Icons.notifications_none,
    };
  }

  Color _iconColorFor(String type) {
    return switch (type) {
      'application_selected' ||
      'deliverable_approved' ||
      'collaboration_completed' => AppColors.success,
      'revision_requested' => AppColors.accent,
      'shortlisted' || 'new_message' => AppColors.primary,
      _ => AppColors.inkSecondary,
    };
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
