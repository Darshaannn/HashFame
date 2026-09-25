import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/core/telemetry/analytics_service.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/account/presentation/account_controller.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';
import 'package:ggs_mobile/features/creator/domain/creator_profile.dart';
import 'package:ggs_mobile/features/creator/domain/rate_card.dart';
import 'package:ggs_mobile/features/creator/domain/social_account.dart';

import '../../../profile_common/presentation/widgets/category_multi_select_picker.dart';
import '../../../profile_common/presentation/widgets/language_multi_select_picker.dart';
import '../profile/creator_profile_controller.dart';

class CreatorOnboardingScreen extends ConsumerStatefulWidget {
  const CreatorOnboardingScreen({super.key});

  @override
  ConsumerState<CreatorOnboardingScreen> createState() =>
      _CreatorOnboardingScreenState();
}

class _CreatorOnboardingScreenState
    extends ConsumerState<CreatorOnboardingScreen> {
  int _currentStep = 0;
  final _displayNameController = TextEditingController();
  final _profNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _selectedCategoryIds = <String>{};
  final _selectedLanguageCodes = <String>{'en', 'hi'};
  final _socialHandleController = TextEditingController();
  SocialPlatform _socialPlatform = SocialPlatform.instagram;
  DeliverableType _rateDeliverable = DeliverableType.instagramReel;
  final _ratePriceController = TextEditingController(text: '15000');
  AvailabilityStatus _availabilityStatus = AvailabilityStatus.open;

  bool _initialized = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _profNameController.dispose();
    _bioController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _socialHandleController.dispose();
    _ratePriceController.dispose();
    super.dispose();
  }

  void _initDefaults() {
    final accountSnapshot = ref.read(sessionProvider).snapshot;
    if (accountSnapshot != null && !_initialized) {
      _displayNameController.text = accountSnapshot.account.displayName;
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) _initDefaults();

    final categoriesAsync = ref.watch(referenceCategoriesProvider);
    final languagesAsync = ref.watch(referenceLanguagesProvider);
    final controllerState = ref.watch(creatorControllerProvider);
    final accountAction = ref.watch(accountActionProvider);
    final busy = controllerState.isLoading || accountAction.isLoading;

    final steps = [
      'Basic Identity',
      'Professional Details',
      'Categories',
      'Location & Languages',
      'Social Platforms',
      'Rate Card',
      'Availability',
      'Review & Launch',
    ];

    return AppScaffold(
      title: 'Creator Setup (${_currentStep + 1}/${steps.length})',
      children: [
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.control),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / steps.length,
            minHeight: 6,
            backgroundColor: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(steps[_currentStep], style: AppTypography.heading),

        if (controllerState.hasError)
          AppErrorState(message: mapFailure(controllerState.error!).message),
        if (accountAction.hasError)
          AppErrorState(message: mapFailure(accountAction.error!).message),

        // Step Contents
        if (_currentStep == 0) ...[
          const Text('Let us start with how you are known on GGs.'),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            label: 'Display Name (Required)',
            controller: _displayNameController,
            validator: validateName,
            enabled: !busy,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            label: 'Stage / Brand Name (Optional)',
            controller: _profNameController,
            enabled: !busy,
          ),
        ] else if (_currentStep == 1) ...[
          const Text('Write a short bio describing your content and audience.'),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            label: 'Professional Bio',
            controller: _bioController,
            maxLength: 1000,
            enabled: !busy,
          ),
        ] else if (_currentStep == 2) ...[
          const Text('Select your main content niches (Recommended).'),
          const SizedBox(height: AppSpacing.sm),
          categoriesAsync.when(
            loading: () => const AppSkeleton(),
            error: (e, _) =>
                Text('Error loading categories: ${mapFailure(e).message}'),
            data: (cats) => CategoryMultiSelectPicker(
              categories: cats,
              selectedCategoryIds: _selectedCategoryIds,
              onChanged: busy
                  ? (_) {}
                  : (updated) => setState(() {
                      _selectedCategoryIds.clear();
                      _selectedCategoryIds.addAll(updated);
                    }),
            ),
          ),
        ] else if (_currentStep == 3) ...[
          const Text('Where are you based?'),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'City (e.g. Mumbai)',
                  controller: _cityController,
                  enabled: !busy,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppTextField(
                  label: 'State (e.g. Maharashtra)',
                  controller: _stateController,
                  enabled: !busy,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Content Languages:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.sm),
          languagesAsync.when(
            loading: () => const AppSkeleton(),
            error: (e, _) =>
                Text('Error loading languages: ${mapFailure(e).message}'),
            data: (langs) => LanguageMultiSelectPicker(
              languages: langs,
              selectedLanguageCodes: _selectedLanguageCodes,
              onChanged: busy
                  ? (_) {}
                  : (updated) => setState(() {
                      _selectedLanguageCodes.clear();
                      _selectedLanguageCodes.addAll(updated);
                    }),
            ),
          ),
        ] else if (_currentStep == 4) ...[
          const Text('Add your main social handle (Instagram / YouTube).'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            children:
                [
                  SocialPlatform.instagram,
                  SocialPlatform.youtube,
                  SocialPlatform.linkedin,
                ].map((p) {
                  return AppChip(
                    label: p.label,
                    selected: _socialPlatform == p,
                    onSelected: busy
                        ? null
                        : (_) => setState(() => _socialPlatform = p),
                  );
                }).toList(),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            label: 'Username / Handle (e.g. yourhandle)',
            controller: _socialHandleController,
            enabled: !busy,
          ),
        ] else if (_currentStep == 5) ...[
          const Text(
            'Set an initial starting rate for your primary deliverable.',
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            children:
                [
                  DeliverableType.instagramReel,
                  DeliverableType.youtubeVideo,
                  DeliverableType.ugcVideo,
                ].map((t) {
                  return AppChip(
                    label: t.label,
                    selected: _rateDeliverable == t,
                    onSelected: busy
                        ? null
                        : (_) => setState(() => _rateDeliverable = t),
                  );
                }).toList(),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            label: 'Starting Price (INR ₹)',
            controller: _ratePriceController,
            keyboardType: TextInputType.number,
            enabled: !busy,
          ),
        ] else if (_currentStep == 6) ...[
          const Text('What is your current availability for new brand deals?'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            children: AvailabilityStatus.values.map((s) {
              return AppChip(
                label: s.label,
                selected: _availabilityStatus == s,
                onSelected: busy
                    ? null
                    : (_) => setState(() => _availabilityStatus = s),
              );
            }).toList(),
          ),
        ] else if (_currentStep == 7) ...[
          const Text('Almost done! Review your creator profile summary.'),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${_displayNameController.text}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (_profNameController.text.isNotEmpty)
                  Text('Professional Name: ${_profNameController.text}'),
                if (_cityController.text.isNotEmpty)
                  Text(
                    'Location: ${_cityController.text}, ${_stateController.text}',
                  ),
                if (_socialHandleController.text.isNotEmpty)
                  Text(
                    'Primary Social: ${_socialPlatform.label} (@${_socialHandleController.text})',
                  ),
                if (_ratePriceController.text.isNotEmpty)
                  Text(
                    'Starting Rate: ₹${_ratePriceController.text} (${_rateDeliverable.label})',
                  ),
                Text('Availability: ${_availabilityStatus.label}'),
              ],
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.lg),

        // Bottom Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentStep > 0)
              OutlinedButton(
                onPressed: busy ? null : () => setState(() => _currentStep--),
                child: const Text('Back'),
              )
            else
              const SizedBox.shrink(),

            AppButton(
              label: _currentStep == steps.length - 1
                  ? 'Complete Setup'
                  : 'Continue',
              busy: busy,
              onPressed: () async {
                if (_currentStep < steps.length - 1) {
                  setState(() => _currentStep++);
                } else {
                  // Finish onboarding transaction
                  final name = _displayNameController.text.trim();
                  if (validateName(name) != null) {
                    setState(() => _currentStep = 0);
                    return;
                  }

                  // 1. Complete base account onboarding
                  await ref
                      .read(accountActionProvider.notifier)
                      .onboard(name, ProfessionalRole.creator);

                  // 2. Save creator profile details
                  final creatorNotifier = ref.read(
                    creatorControllerProvider.notifier,
                  );
                  await creatorNotifier.updateBasicProfile(
                    professionalName: _profNameController.text.trim(),
                    bio: _bioController.text.trim(),
                    city: _cityController.text.trim(),
                    state: _stateController.text.trim(),
                  );
                  if (_selectedCategoryIds.isNotEmpty) {
                    await creatorNotifier.saveCategories(
                      categoryIds: _selectedCategoryIds.toList(),
                      primaryId: _selectedCategoryIds.first,
                    );
                  }
                  if (_selectedLanguageCodes.isNotEmpty) {
                    await creatorNotifier.saveLanguages(
                      languageCodes: _selectedLanguageCodes.toList(),
                      primaryCode: _selectedLanguageCodes.first,
                    );
                  }
                  if (_socialHandleController.text.trim().isNotEmpty) {
                    await creatorNotifier.addSocialAccount(
                      SocialAccount(
                        id: '',
                        userId: '',
                        platform: _socialPlatform,
                        handle: _socialHandleController.text.trim().replaceAll(
                          '@',
                          '',
                        ),
                      ),
                    );
                  }
                  final price = double.tryParse(
                    _ratePriceController.text.trim(),
                  );
                  if (price != null && price > 0) {
                    await creatorNotifier.addRateItem(
                      RateItem(
                        id: '',
                        userId: '',
                        deliverableType: _rateDeliverable,
                        priceAmount: price,
                      ),
                    );
                  }
                  await creatorNotifier.updateAvailability(
                    CreatorAvailability(status: _availabilityStatus),
                  );

                  await ref
                      .read(analyticsProvider)
                      .event(AnalyticsEvent.creatorOnboardingCompleted);

                  if (context.mounted) {
                    context.go('/home/creator');
                  }
                }
              },
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),
        Center(
          child: TextButton(
            onPressed: busy
                ? null
                : () => ref.read(accountActionProvider.notifier).logout(),
            child: const Text('Save & Sign Out'),
          ),
        ),
      ],
    );
  }
}
