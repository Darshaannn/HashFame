import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';

import '../../domain/portfolio.dart';
import '../../domain/social_account.dart';
import '../profile/creator_profile_controller.dart';

class EditPortfolioScreen extends ConsumerStatefulWidget {
  const EditPortfolioScreen({super.key});

  @override
  ConsumerState<EditPortfolioScreen> createState() =>
      _EditPortfolioScreenState();
}

class _EditPortfolioScreenState extends ConsumerState<EditPortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  PortfolioContentType _selectedType = PortfolioContentType.video;
  final _selectedPlatform = SocialPlatform.instagram;
  final _titleController = TextEditingController();
  final _brandController = TextEditingController();
  final _urlController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _brandController.dispose();
    _urlController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(creatorControllerProvider);
    final busy = controllerState.isLoading;

    return AppScaffold(
      title: 'Add Portfolio Work',
      children: [
        if (controllerState.hasError)
          AppErrorState(message: mapFailure(controllerState.error!).message),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Content Format', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                children: PortfolioContentType.values.map((type) {
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
                label: 'Work Title (e.g. Viral Smartphone Review Reel)',
                controller: _titleController,
                enabled: !busy,
                validator: (val) {
                  if (val == null || val.trim().length < 2) {
                    return 'Please enter a title (at least 2 characters).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),

              AppTextField(
                label: 'Brand Name (Optional)',
                controller: _brandController,
                enabled: !busy,
              ),
              const SizedBox(height: AppSpacing.sm),

              AppTextField(
                label: 'Content / Video URL (Optional)',
                controller: _urlController,
                enabled: !busy,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: AppSpacing.sm),

              AppTextField(
                label: 'Description & Reach Highlights (Optional)',
                controller: _descController,
                enabled: !busy,
                maxLength: 1000,
              ),
              const SizedBox(height: AppSpacing.lg),

              AppButton(
                label: 'Save Portfolio Item',
                busy: busy,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final item = PortfolioItem(
                      id: '',
                      userId: '',
                      title: _titleController.text.trim(),
                      contentType: _selectedType,
                      platform: _selectedPlatform,
                      brandName: _brandController.text.trim().isNotEmpty
                          ? _brandController.text.trim()
                          : null,
                      contentUrl: _urlController.text.trim().isNotEmpty
                          ? _urlController.text.trim()
                          : null,
                      description: _descController.text.trim().isNotEmpty
                          ? _descController.text.trim()
                          : null,
                    );
                    await ref
                        .read(creatorControllerProvider.notifier)
                        .addPortfolioItem(item);

                    if (context.mounted &&
                        !ref.read(creatorControllerProvider).hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Portfolio work added!')),
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
