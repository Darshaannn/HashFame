import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';

import '../../domain/rate_card.dart';
import '../profile/creator_profile_controller.dart';

class EditRateCardScreen extends ConsumerStatefulWidget {
  const EditRateCardScreen({super.key});

  @override
  ConsumerState<EditRateCardScreen> createState() => _EditRateCardScreenState();
}

class _EditRateCardScreenState extends ConsumerState<EditRateCardScreen> {
  final _formKey = GlobalKey<FormState>();
  DeliverableType _selectedType = DeliverableType.instagramReel;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(creatorControllerProvider);
    final busy = controllerState.isLoading;

    return AppScaffold(
      title: 'Add Rate Card Item',
      children: [
        if (controllerState.hasError)
          AppErrorState(message: mapFailure(controllerState.error!).message),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                label: 'Custom Title (Optional)',
                controller: _titleController,
                enabled: !busy,
              ),
              const SizedBox(height: AppSpacing.sm),

              AppTextField(
                label: 'Price in INR (₹)',
                controller: _priceController,
                enabled: !busy,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a price amount.';
                  }
                  final amount = double.tryParse(val.trim());
                  if (amount == null || amount < 0) {
                    return 'Please enter a valid positive number.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),

              AppTextField(
                label: 'Description / Scope (Optional)',
                controller: _descController,
                enabled: !busy,
                maxLength: 500,
              ),
              const SizedBox(height: AppSpacing.lg),

              AppButton(
                label: 'Save Rate Item',
                busy: busy,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final price = double.parse(_priceController.text.trim());
                    final item = RateItem(
                      id: '',
                      userId: '',
                      deliverableType: _selectedType,
                      customTitle: _titleController.text.trim().isNotEmpty
                          ? _titleController.text.trim()
                          : null,
                      priceAmount: price,
                      currency: 'INR',
                      description: _descController.text.trim().isNotEmpty
                          ? _descController.text.trim()
                          : null,
                    );
                    await ref
                        .read(creatorControllerProvider.notifier)
                        .addRateItem(item);

                    if (context.mounted &&
                        !ref.read(creatorControllerProvider).hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Rate card item added!')),
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
