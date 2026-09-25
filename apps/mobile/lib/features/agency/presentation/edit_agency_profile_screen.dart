import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../../core/errors/app_failure.dart';
import '../domain/agency_profile.dart';
import 'agency_screens.dart';

class EditAgencyProfileScreen extends ConsumerStatefulWidget {
  const EditAgencyProfileScreen({super.key});

  @override
  ConsumerState<EditAgencyProfileScreen> createState() =>
      _EditAgencyProfileScreenState();
}

class _EditAgencyProfileScreenState
    extends ConsumerState<EditAgencyProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _agencyNameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _initialized = false;
  bool _busy = false;

  @override
  void dispose() {
    _agencyNameController.dispose();
    _websiteController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _initFields(AgencyProfile profile) {
    if (!_initialized) {
      _agencyNameController.text = profile.agencyName;
      _websiteController.text = profile.website ?? '';
      _locationController.text = profile.location ?? '';
      _descriptionController.text = profile.description ?? '';
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final agencyAsync = ref.watch(agencyProfileProvider);

    agencyAsync.whenData((profile) => _initFields(profile));

    return AppScaffold(
      title: 'Edit Agency Profile',
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Agency Details', style: AppTypography.heading),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Agency Name',
                controller: _agencyNameController,
                enabled: !_busy,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Agency name cannot be empty'
                    : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Official Website',
                controller: _websiteController,
                enabled: !_busy,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Location / Headquarters',
                controller: _locationController,
                enabled: !_busy,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: 'Agency Description & Services',
                controller: _descriptionController,
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
                          agencyAsync.value ??
                          const AgencyProfile(
                            userId: 'demo_agency_user_id',
                            agencyName: '',
                          );
                      final updated = current.copyWith(
                        agencyName: _agencyNameController.text.trim(),
                        website: _websiteController.text.trim(),
                        location: _locationController.text.trim(),
                        description: _descriptionController.text.trim(),
                      );
                      await ref
                          .read(agencyRepositoryProvider)
                          .updateProfile(updated);
                      ref.invalidate(agencyProfileProvider);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Agency profile updated successfully!',
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
