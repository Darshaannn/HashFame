import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/campaign_application.dart';
import 'campaign_controller.dart';

class CreatorApplicationsScreen extends ConsumerWidget {
  const CreatorApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(sessionProvider).snapshot?.account.id;
    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text('Please sign in to view applications')),
      );
    }

    final appsAsync = ref.watch(creatorApplicationsProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('My Applications')),
      body: appsAsync.when(
        loading: () => const Center(child: AppLoader()),
        error: (e, _) => Center(
          child: AppErrorState(
            message: e.toString(),
            onRetry: () => ref.invalidate(creatorApplicationsProvider(userId)),
          ),
        ),
        data: (apps) {
          if (apps.isEmpty) {
            return const Center(
              child: AppEmptyState(
                title: 'No Applications Yet',
                message: 'You have not applied to any campaigns yet.',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(creatorApplicationsProvider(userId));
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: apps.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final app = apps[index];
                return AppCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      app.campaignTitle ?? 'Campaign',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.xs),
                        Text('Brand: ${app.brandName ?? 'Direct Brand'}'),
                        Text(
                          'Applied: ${app.createdAt.day}/${app.createdAt.month}/${app.createdAt.year}',
                        ),
                        if (app.proposedRate != null)
                          Text(
                            'Proposed: ₹${app.proposedRate!.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                      ],
                    ),
                    trailing: AppBadge(label: app.status.label),
                    onTap: () => context.push('/applications/${app.id}'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
