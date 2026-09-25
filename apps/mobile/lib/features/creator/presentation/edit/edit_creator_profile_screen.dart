import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';

import '../profile/creator_profile_controller.dart';

class EditCreatorProfileScreen extends ConsumerStatefulWidget {
  const EditCreatorProfileScreen({super.key});

  @override
  ConsumerState<EditCreatorProfileScreen> createState() =>
      _EditCreatorProfileScreenState();
}

class _EditCreatorProfileScreenState
    extends ConsumerState<EditCreatorProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _selectedCategoryIds = <String>{};
  final _selectedLanguageCodes = <String>{};

  bool _initialized = false;

  @override
  void dispose() {
    _profNameController.dispose();
    _bioController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _initFields() {
    final profileAsync = ref.read(currentCreatorProfileProvider);
    final profile = profileAsync.value;
    if (profile != null && !_initialized) {
      _profNameController.text = profile.professionalName ?? '';
      _bioController.text = profile.bio ?? '';
      _cityController.text = profile.location.city ?? '';
      _stateController.text = profile.location.state ?? '';
      _selectedCategoryIds.addAll(profile.primaryCategories.map((c) => c.id));
      _selectedCategoryIds.addAll(
        profile.additionalCategories.map((c) => c.id),
      );
      _selectedLanguageCodes.addAll(profile.languages.map((l) => l.code));
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(currentCreatorProfileProvider);
    final categoriesAsync = ref.watch(referenceCategoriesProvider);
    final languagesAsync = ref.watch(referenceLanguagesProvider);
    final controllerState = ref.watch(creatorControllerProvider);
    final busy = controllerState.isLoading;

    if (profileAsync.hasValue && !_initialized) {
      _initFields();
    }

    return AppScaffold(
      title: 'Edit Creator Profile',
      children: [
        if (controllerState.hasError)
          AppErrorState(message: mapFailure(controllerState.error!).message),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Identity & Bio', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Professional / Stage Name (Optional)',
                controller: _profNameController,
                enabled: !busy,
                maxLength: 80,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Professional Bio',
                controller: _bioController,
                enabled: !busy,
                maxLength: 1000,
                validator: (val) {
                  if (val != null && val.isNotEmpty && val.trim().length < 10) {
                    return 'Bio should be at least 10 characters long.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              const Text('Location', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'City',
                      controller: _cityController,
                      enabled: !busy,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: AppTextField(
                      label: 'State',
                      controller: _stateController,
                      enabled: !busy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              const Text('Categories & Niches', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              categoriesAsync.when(
                loading: () => const AppSkeleton(),
                error: (e, _) =>
                    Text('Could not load categories: ${mapFailure(e).message}'),
                data: (cats) => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: cats.map((cat) {
                    final isSelected = _selectedCategoryIds.contains(cat.id);
                    return AppChip(
                      label: cat.name,
                      selected: isSelected,
                      onSelected: busy
                          ? null
                          : (sel) {
                              setState(() {
                                if (sel) {
                                  _selectedCategoryIds.add(cat.id);
                                } else {
                                  _selectedCategoryIds.remove(cat.id);
                                }
                              });
                            },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              const Text('Content Languages', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              languagesAsync.when(
                loading: () => const AppSkeleton(),
                error: (e, _) =>
                    Text('Could not load languages: ${mapFailure(e).message}'),
                data: (langs) => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: langs.map((lang) {
                    final isSelected = _selectedLanguageCodes.contains(
                      lang.code,
                    );
                    return AppChip(
                      label: '${lang.name} (${lang.nativeName})',
                      selected: isSelected,
                      onSelected: busy
                          ? null
                          : (sel) {
                              setState(() {
                                if (sel) {
                                  _selectedLanguageCodes.add(lang.code);
                                } else {
                                  _selectedLanguageCodes.remove(lang.code);
                                }
                              });
                            },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              AppButton(
                label: 'Save Profile Changes',
                busy: busy,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final notifier = ref.read(
                      creatorControllerProvider.notifier,
                    );
                    await notifier.updateBasicProfile(
                      professionalName: _profNameController.text.trim(),
                      bio: _bioController.text.trim(),
                      city: _cityController.text.trim(),
                      state: _stateController.text.trim(),
                    );
                    await notifier.saveCategories(
                      categoryIds: _selectedCategoryIds.toList(),
                      primaryId: _selectedCategoryIds.isNotEmpty
                          ? _selectedCategoryIds.first
                          : null,
                    );
                    await notifier.saveLanguages(
                      languageCodes: _selectedLanguageCodes.toList(),
                      primaryCode: _selectedLanguageCodes.isNotEmpty
                          ? _selectedLanguageCodes.first
                          : null,
                    );
                    if (context.mounted &&
                        !ref.read(creatorControllerProvider).hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile updated successfully!'),
                        ),
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
