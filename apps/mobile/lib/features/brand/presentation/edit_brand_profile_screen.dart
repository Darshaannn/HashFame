import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../../core/errors/app_failure.dart';
import '../domain/brand_profile.dart';
import 'brand_screens.dart';

class EditBrandProfileScreen extends ConsumerStatefulWidget {
  const EditBrandProfileScreen({super.key});

  @override
  ConsumerState<EditBrandProfileScreen> createState() =>
      _EditBrandProfileScreenState();
}

class _EditBrandProfileScreenState
    extends ConsumerState<EditBrandProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _orgNameController = TextEditingController();
  final _bioController = TextEditingController();

  bool _initialized = false;
  bool _busy = false;

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _orgNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _initFields(BrandMarketerProfile profile) {
    if (!_initialized) {
      _nameController.text = profile.displayName;
      _jobTitleController.text = profile.jobTitle ?? '';
      _emailController.text = profile.workEmail ?? '';
      _phoneController.text = profile.phone ?? '';
      _orgNameController.text = profile.organizationName ?? '';
      _bioController.text = profile.bio ?? '';
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandAsync = ref.watch(brandProfileProvider);

    brandAsync.whenData((profile) => _initFields(profile));

    return AppScaffold(
      title: 'Edit Brand Profile',
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Marketer Information', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Full Name',
                controller: _nameController,
                enabled: !_busy,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Name cannot be empty'
                    : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Job Title / Role',
                controller: _jobTitleController,
                enabled: !_busy,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Work Email',
                controller: _emailController,
                enabled: !_busy,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Phone Number',
                controller: _phoneController,
                enabled: !_busy,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppSpacing.md),

              const Text(
                'Organization / Company',
                style: AppTypography.heading,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Company / Organization Name',
                controller: _orgNameController,
                enabled: !_busy,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Organization name is required'
                    : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Company Bio & Mission',
                controller: _bioController,
                enabled: !_busy,
                maxLength: 500,
                maxLines: 3,
              ),
              const SizedBox(height: AppSpacing.lg),

              AppButton(
                label: 'Save Changes',
                busy: _busy,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _busy = true);
                    try {
                      final current =
                          brandAsync.value ??
                          const BrandMarketerProfile(
                            userId: 'demo_brand_user_id',
                            displayName: '',
                          );
                      final updated = current.copyWith(
                        displayName: _nameController.text.trim(),
                        jobTitle: _jobTitleController.text.trim(),
                        workEmail: _emailController.text.trim(),
                        phone: _phoneController.text.trim(),
                        organizationName: _orgNameController.text.trim(),
                        bio: _bioController.text.trim(),
                      );
                      await ref
                          .read(brandRepositoryProvider)
                          .updateProfile(updated);
                      ref.invalidate(brandProfileProvider);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Brand profile updated successfully!',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        context.pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Update failed: ${mapFailure(e).message}',
                            ),
                          ),
                        );
                      }
                    } finally {
                      if (mounted) setState(() => _busy = false);
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
