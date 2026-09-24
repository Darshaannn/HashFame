import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import '../../domain/social_account.dart';
import '../profile/creator_profile_controller.dart';

class EditSocialsScreen extends ConsumerStatefulWidget {
  const EditSocialsScreen({super.key});

  @override
  ConsumerState<EditSocialsScreen> createState() => _EditSocialsScreenState();
}

class _EditSocialsScreenState extends ConsumerState<EditSocialsScreen> {
  final _formKey = GlobalKey<FormState>();
  SocialPlatform _selectedPlatform = SocialPlatform.instagram;
  final _handleController = TextEditingController();
  final _urlController = TextEditingController();
  final _followersController = TextEditingController();

  @override
  void dispose() {
    _handleController.dispose();
    _urlController.dispose();
    _followersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(creatorControllerProvider);
    final busy = controllerState.isLoading;

    return AppScaffold(
      title: 'Add Social Account',
      children: [
        if (controllerState.hasError)
          AppErrorState(message: mapFailure(controllerState.error!).message),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Platform', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                children: SocialPlatform.values.map((p) {
                  return AppChip(
                    label: p.label,
                    selected: _selectedPlatform == p,
                    onSelected: busy
                        ? null
                        : (_) => setState(() => _selectedPlatform = p),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.md),

              AppTextField(
                label: 'Handle / Username (e.g. johndoe)',
                controller: _handleController,
                enabled: !busy,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your username/handle';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),

              AppTextField(
                label: 'Profile URL (Optional)',
                controller: _urlController,
                enabled: !busy,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: AppSpacing.sm),

              AppTextField(
                label: 'Self-Reported Follower Count (Optional)',
                controller: _followersController,
                enabled: !busy,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppSpacing.lg),

              AppButton(
                label: 'Add Social Account',
                busy: busy,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final count = int.tryParse(_followersController.text.trim());
                    final newAcc = SocialAccount(
                      id: '',
                      userId: '',
                      platform: _selectedPlatform,
                      handle: _handleController.text.trim().replaceAll('@', ''),
                      profileUrl: _urlController.text.trim().isNotEmpty
                          ? _urlController.text.trim()
                          : null,
                      userProvidedFollowerCount: count,
                    );
                    await ref
                        .read(creatorControllerProvider.notifier)
                        .addSocialAccount(newAcc);

                    if (context.mounted && !ref.read(creatorControllerProvider).hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Social account added!')),
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
