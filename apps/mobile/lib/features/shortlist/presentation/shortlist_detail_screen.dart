import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../comparison/presentation/comparison_controller.dart';
import '../domain/shortlist_member.dart';
import 'shortlist_controller.dart';

class ShortlistDetailScreen extends ConsumerWidget {
  const ShortlistDetailScreen({super.key, required this.shortlistId});

  final String shortlistId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortlistAsync = ref.watch(shortlistDetailProvider(shortlistId));
    final controllerState = ref.watch(shortlistControllerProvider);
    final busy = controllerState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(shortlistAsync.asData?.value.name ?? 'Shortlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            tooltip: 'Compare in this list',
            onPressed: () {
              final list = shortlistAsync.asData?.value;
              if (list != null && list.members.isNotEmpty) {
                final creatorIds = list.members
                    .take(4)
                    .map((m) => m.creatorId)
                    .toList();
                ref
                    .read(comparisonControllerProvider.notifier)
                    .setCreators(creatorIds);
                context.push('/compare');
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete List',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Shortlist?'),
                  content: const Text('This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await ref
                    .read(shortlistControllerProvider.notifier)
                    .deleteShortlist(shortlistId: shortlistId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: shortlistAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading shortlist: $e'),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  label: 'Retry',
                  onPressed: () =>
                      ref.invalidate(shortlistDetailProvider(shortlistId)),
                ),
              ],
            ),
          ),
          data: (shortlist) {
            if (shortlist.members.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.people_outline,
                        size: 48,
                        color: AppColors.outline,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'No creators added yet',
                        style: AppTypography.heading,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const Text(
                        'Search creators in Discover and add them to this shortlist.',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppButton(
                        label: 'Discover Creators',
                        onPressed: () => context.push('/discover'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: shortlist.members.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final member = shortlist.members[index];
                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primaryContainer,
                            child: Text(
                              member.creatorDisplayName?.isNotEmpty == true
                                  ? member.creatorDisplayName![0].toUpperCase()
                                  : 'C',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.creatorDisplayName ?? 'Creator',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                if (member.creatorCity != null)
                                  Text(
                                    member.creatorCity!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: AppColors.error,
                            ),
                            tooltip: 'Remove',
                            onPressed: busy
                                ? null
                                : () => ref
                                      .read(
                                        shortlistControllerProvider.notifier,
                                      )
                                      .removeCreatorFromShortlist(
                                        shortlistId: shortlistId,
                                        creatorId: member.creatorId,
                                      ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Status Selector
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          DropdownButton<ShortlistMemberStatus>(
                            value: member.status,
                            isDense: true,
                            items: ShortlistMemberStatus.values.map((s) {
                              return DropdownMenuItem(
                                value: s,
                                child: Text(s.label),
                              );
                            }).toList(),
                            onChanged: busy
                                ? null
                                : (newStatus) {
                                    if (newStatus != null) {
                                      ref
                                          .read(
                                            shortlistControllerProvider
                                                .notifier,
                                          )
                                          .updateMemberStatus(
                                            shortlistId: shortlistId,
                                            memberId: member.id,
                                            status: newStatus,
                                          );
                                    }
                                  },
                          ),
                        ],
                      ),

                      // Private Notes
                      if (member.notes != null && member.notes!.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Note: ${member.notes}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                        ),
                      ],

                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () =>
                                _showNotesDialog(context, ref, member),
                            child: Text(
                              member.notes != null ? 'Edit Note' : 'Add Note',
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.push(
                              '/discover/creator/${member.creatorId}',
                            ),
                            child: const Text('View Profile'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showNotesDialog(
    BuildContext context,
    WidgetRef ref,
    ShortlistMember member,
  ) {
    final notesCtrl = TextEditingController(text: member.notes ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Private Marketer Note'),
        content: AppTextField(
          label: 'Notes (Internal only)',
          controller: notesCtrl,
          maxLength: 1000,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          AppButton(
            label: 'Save',
            onPressed: () async {
              await ref
                  .read(shortlistControllerProvider.notifier)
                  .updateMemberNotes(
                    shortlistId: shortlistId,
                    memberId: member.id,
                    notes: notesCtrl.text.trim(),
                  );
              if (ctx.mounted) Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }
}
