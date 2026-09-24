import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/components.dart';
import '../../../../core/design_system/tokens.dart';
import '../../domain/shortlist_member.dart';
import '../shortlist_controller.dart';

class AddToShortlistDialog extends ConsumerStatefulWidget {
  const AddToShortlistDialog({
    super.key,
    required this.creatorId,
    required this.creatorName,
  });

  final String creatorId;
  final String creatorName;

  @override
  ConsumerState<AddToShortlistDialog> createState() => _AddToShortlistDialogState();
}

class _AddToShortlistDialogState extends ConsumerState<AddToShortlistDialog> {
  String? _selectedShortlistId;
  ShortlistMemberStatus _selectedStatus = ShortlistMemberStatus.potential;
  final _notesController = TextEditingController();
  final _newListController = TextEditingController();
  bool _creatingNew = false;

  @override
  void dispose() {
    _notesController.dispose();
    _newListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shortlistsAsync = ref.watch(shortlistsListProvider);
    final controllerState = ref.watch(shortlistControllerProvider);
    final busy = controllerState.isLoading;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.card)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Save to Shortlist', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.xs),
              Text('Add ${widget.creatorName} to an organization shortlist.'),
              const SizedBox(height: AppSpacing.md),
              if (_creatingNew) ...[
                AppTextField(
                  label: 'New Shortlist Name',
                  controller: _newListController,
                  enabled: !busy,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    TextButton(
                      onPressed: busy ? null : () => setState(() => _creatingNew = false),
                      child: const Text('Choose Existing'),
                    ),
                  ],
                ),
              ] else ...[
                shortlistsAsync.when(
                  loading: () => const AppSkeleton(),
                  error: (e, _) => Text('Error loading lists: $e'),
                  data: (lists) {
                    if (lists.isEmpty) {
                      return Column(
                        children: [
                          const Text('No shortlists yet. Create one now.'),
                          const SizedBox(height: AppSpacing.sm),
                          AppButton(
                            label: 'Create Shortlist',
                            onPressed: () => setState(() => _creatingNew = true),
                          ),
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          value: _selectedShortlistId ?? lists.first.id,
                          decoration: const InputDecoration(labelText: 'Select Shortlist'),
                          items: lists.map((l) {
                            return DropdownMenuItem(
                              value: l.id,
                              child: Text('${l.name} (${l.memberCount})'),
                            );
                          }).toList(),
                          onChanged: busy ? null : (val) => setState(() => _selectedShortlistId = val),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text('Create New List'),
                            onPressed: busy ? null : () => setState(() => _creatingNew = true),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              DropdownButtonFormField<ShortlistMemberStatus>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Workflow Status'),
                items: ShortlistMemberStatus.values.map((s) {
                  return DropdownMenuItem(value: s, child: Text(s.label));
                }).toList(),
                onChanged: busy ? null : (val) => setState(() => _selectedStatus = val ?? ShortlistMemberStatus.potential),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Private Note (Marketers only)',
                controller: _notesController,
                maxLength: 1000,
                enabled: !busy,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: busy ? null : () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  AppButton(
                    label: 'Save',
                    busy: busy,
                    onPressed: () async {
                      final controller = ref.read(shortlistControllerProvider.notifier);
                      var targetListId = _selectedShortlistId;

                      if (_creatingNew) {
                        final newName = _newListController.text.trim();
                        if (newName.isEmpty) return;
                        await controller.createShortlist(name: newName);
                        final updatedLists = await ref.read(shortlistsListProvider.future);
                        targetListId = updatedLists.where((l) => l.name == newName).firstOrNull?.id;
                      } else if (targetListId == null) {
                        final currentLists = shortlistsAsync.asData?.value ?? [];
                        if (currentLists.isNotEmpty) {
                          targetListId = currentLists.first.id;
                        }
                      }

                      if (targetListId != null) {
                        await controller.addCreatorToShortlist(
                          shortlistId: targetListId,
                          creatorId: widget.creatorId,
                          status: _selectedStatus,
                          notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
                        );
                        if (context.mounted) {
                          Navigator.of(context).pop(true);
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
