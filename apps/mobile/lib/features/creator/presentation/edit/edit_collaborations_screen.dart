import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import '../../domain/collaboration.dart';
import '../../domain/rate_card.dart';
import '../profile/creator_profile_controller.dart';

class EditCollaborationsScreen extends ConsumerStatefulWidget {
  const EditCollaborationsScreen({super.key});

  @override
  ConsumerState<EditCollaborationsScreen> createState() => _EditCollaborationsScreenState();
}

class _EditCollaborationsScreenState extends ConsumerState<EditCollaborationsScreen> {
  final _formKey = GlobalKey<FormState>();
  DeliverableType _selectedType = DeliverableType.instagramReel;
  final _brandNameController = TextEditingController();
  final _campaignController = TextEditingController();
  final _yearController = TextEditingController();
  final _proofUrlController = TextEditingController();

  @override
  void dispose() {
    _brandNameController.dispose();
    _campaignController.dispose();
    _yearController.dispose();
    _proofUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(creatorControllerProvider);
    final busy = controllerState.isLoading;

    return AppScaffold(
      title: 'Add Past Collaboration',
      children: [
        if (controllerState.hasError)
          AppErrorState(message: mapFailure(controllerState.error!).message),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                label: 'Brand Name (e.g. Nike, Samsung)',
                controller: _brandNameController,
                enabled: !busy,
                validator: (val) {
                  if (val == null || val.trim().length < 2) {
                    return 'Please enter a brand name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),

              AppTextField(
                label: 'Campaign / Project Name (Optional)',
                controller: _campaignController,
                enabled: !busy,
              ),
              const SizedBox(height: AppSpacing.sm),

              const Text('Deliverable Format', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: DeliverableType.values.map((type) {
                  return AppChip(
                    label: type.label,
                    selected: _selectedType == type,
                    onSelected: busy
                        ? null
                        : (_) => setState(() => _selectedType = type),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.md),

              AppTextField(
                label: 'Year of Collaboration (e.g. 2025)',
                controller: _yearController,
                enabled: !busy,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppSpacing.sm),

              AppTextField(
                label: 'Proof / Post Link (Optional)',
                controller: _proofUrlController,
                enabled: !busy,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: AppSpacing.lg),

              AppButton(
                label: 'Save Collaboration',
                busy: busy,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final year = int.tryParse(_yearController.text.trim());
                    final collab = PastCollaboration(
                      id: '',
                      userId: '',
                      brandName: _brandNameController.text.trim(),
                      campaignName: _campaignController.text.trim().isNotEmpty
                          ? _campaignController.text.trim()
                          : null,
                      deliverableType: _selectedType,
                      collaborationYear: year,
                      proofUrl: _proofUrlController.text.trim().isNotEmpty
                          ? _proofUrlController.text.trim()
                          : null,
                      proofType: CollaborationProofType.selfReported,
                    );
                    await ref
                        .read(creatorControllerProvider.notifier)
                        .addCollaboration(collab);

                    if (context.mounted && !ref.read(creatorControllerProvider).hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Collaboration added!')),
                      );
                      context.pop();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
