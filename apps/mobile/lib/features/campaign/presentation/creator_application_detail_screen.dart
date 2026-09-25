import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/campaign_application.dart';
import 'campaign_controller.dart';

class CreatorApplicationDetailScreen extends ConsumerWidget {
  const CreatorApplicationDetailScreen({
    super.key,
    required this.applicationId,
  });

  final String applicationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appAsync = ref.watch(applicationDetailProvider(applicationId));
    final userId = ref.watch(sessionProvider).snapshot?.account.id;

    return appAsync.when(
      loading: () => const Scaffold(body: Center(child: AppLoader())),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Application Detail')),
        body: Center(
          child: AppErrorState(
            message: e.toString(),
            onRetry: () =>
                ref.invalidate(applicationDetailProvider(applicationId)),
          ),
        ),
      ),
      data: (app) {
        final canWithdraw =
            app.status != CampaignApplicationStatus.selected &&
            app.status != CampaignApplicationStatus.rejected &&
            app.status != CampaignApplicationStatus.withdrawn;

        return Scaffold(
          appBar: AppBar(title: const Text('Application Detail')),
          bottomNavigationBar: canWithdraw && userId != null
              ? Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: OutlinedButton(
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Withdraw Application?'),
                          content: const Text(
                            'Are you sure you want to withdraw your application? This action cannot be undone.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              child: const Text('Withdraw'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true) {
                        final success = await ref
                            .read(campaignActionControllerProvider.notifier)
                            .withdrawApplication(app.id, userId);
                        if (context.mounted && success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Application withdrawn.'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Withdraw Application',
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),
                )
              : null,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Application Status Header
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            app.brandName ?? 'Brand',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.muted,
                            ),
                          ),
                          AppBadge(label: app.status.label),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        app.campaignTitle ?? 'Campaign',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Applied on: ${app.createdAt.day}/${app.createdAt.month}/${app.createdAt.year}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // My Pitch
                const Text(
                  'My Pitch',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: AppSpacing.xs),
                AppCard(
                  child: Text(
                    app.pitch,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Proposed Rate
                if (app.proposedRate != null) ...[
                  const Text(
                    'Proposed Rate',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  AppCard(
                    child: Text(
                      '₹${app.proposedRate!.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // Status Timeline
                const Text(
                  'Status History & Transparency',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: AppSpacing.xs),
                AppCard(
                  child: app.statusHistory.isEmpty
                      ? const Text(
                          'No transition history recorded yet.',
                          style: TextStyle(color: AppColors.muted),
                        )
                      : Column(
                          children: app.statusHistory
                              .map(
                                (h) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppSpacing.xs,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: AppSpacing.sm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              h.toStatus.label,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            if (h.reason != null)
                                              Text(
                                                h.reason!,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.muted,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${h.createdAt.day}/${h.createdAt.month} ${h.createdAt.hour}:${h.createdAt.minute.toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        );
      },
    );
  }
}
