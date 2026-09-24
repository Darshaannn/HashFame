import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import 'shortlist_controller.dart';

class ShortlistsScreen extends ConsumerWidget {
  const ShortlistsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortlistsAsync = ref.watch(shortlistsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shortlists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create Shortlist',
            onPressed: () => _showCreateDialog(context, ref),
          ),
        ],
      ),
      body: SafeArea(
        child: shortlistsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: AppSkeleton(),
          ),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading shortlists: $e'),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  label: 'Retry',
                  onPressed: () => ref.invalidate(shortlistsListProvider),
                ),
              ],
            ),
          ),
          data: (lists) {
            if (lists.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bookmark_border, size: 48, color: AppColors.outline),
                      const SizedBox(height: AppSpacing.sm),
                      Text('No shortlists yet', style: AppTypography.heading),
                      const SizedBox(height: AppSpacing.xs),
                      const Text('Create shortlists to organize creators for your brand or agency.'),
                      const SizedBox(height: AppSpacing.md),
                      AppButton(
                        label: 'Create First Shortlist',
                        onPressed: () => _showCreateDialog(context, ref),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: lists.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final list = lists[index];
                return InkWell(
                  onTap: () => context.push('/shortlists/${list.id}'),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  child: AppCard(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(Icons.folder_outlined, color: Theme.of(context).colorScheme.onPrimaryContainer),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(list.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              if (list.description != null && list.description!.isNotEmpty)
                                Text(
                                  list.description!,
                                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              Text(
                                '${list.memberCount} creator${list.memberCount == 1 ? '' : 's'}',
                                style: const TextStyle(fontSize: 12, color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Create Shortlist'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(label: 'Name', controller: nameCtrl),
            const SizedBox(height: AppSpacing.sm),
            AppTextField(label: 'Description (Optional)', controller: descCtrl),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('Cancel')),
          AppButton(
            label: 'Create',
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isNotEmpty) {
                await ref.read(shortlistControllerProvider.notifier).createShortlist(
                      name: name,
                      description: descCtrl.text.trim().isNotEmpty ? descCtrl.text.trim() : null,
                    );
                if (dialogCtx.mounted) Navigator.pop(dialogCtx);
              }
            },
          ),
        ],
      ),
    );
  }
}
