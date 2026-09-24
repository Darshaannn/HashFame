import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/components.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../creator/domain/creator_profile.dart';
import '../../../creator/domain/social_account.dart';
import '../../../creator/presentation/profile/creator_profile_controller.dart';
import '../../domain/creator_search_filters.dart';
import '../discovery_controller.dart';

class DiscoverFilterSheet extends ConsumerStatefulWidget {
  const DiscoverFilterSheet({super.key});

  @override
  ConsumerState<DiscoverFilterSheet> createState() => _DiscoverFilterSheetState();
}

class _DiscoverFilterSheetState extends ConsumerState<DiscoverFilterSheet> {
  late CreatorSearchFilters _filters;
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _minFollowersController = TextEditingController();
  final _maxFollowersController = TextEditingController();
  final _minRateController = TextEditingController();
  final _maxRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filters = ref.read(creatorSearchFiltersProvider);
    _cityController.text = _filters.city ?? '';
    _stateController.text = _filters.state ?? '';
    if (_filters.minFollowers != null) _minFollowersController.text = _filters.minFollowers.toString();
    if (_filters.maxFollowers != null) _maxFollowersController.text = _filters.maxFollowers.toString();
    if (_filters.minRate != null) _minRateController.text = _filters.minRate!.toStringAsFixed(0);
    if (_filters.maxRate != null) _maxRateController.text = _filters.maxRate!.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _cityController.dispose();
    _stateController.dispose();
    _minFollowersController.dispose();
    _maxFollowersController.dispose();
    _minRateController.dispose();
    _maxRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(referenceCategoriesProvider);
    final languagesAsync = ref.watch(referenceLanguagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Creators'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _filters = const CreatorSearchFilters();
                _cityController.clear();
                _stateController.clear();
                _minFollowersController.clear();
                _maxFollowersController.clear();
                _minRateController.clear();
                _maxRateController.clear();
              });
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            // Availability
            Text('Availability', style: AppTypography.heading),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: 8,
              children: AvailabilityStatus.values.map((s) {
                final selected = _filters.availability == s;
                return AppChip(
                  label: s.label,
                  selected: selected,
                  onSelected: (sel) => setState(() {
                    _filters = _filters.copyWith(availability: sel ? s : null);
                  }),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),

            // Platforms
            Text('Platforms', style: AppTypography.heading),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: 8,
              children: [SocialPlatform.instagram, SocialPlatform.youtube, SocialPlatform.linkedin].map((p) {
                final selected = _filters.platforms.contains(p);
                return AppChip(
                  label: p.label,
                  selected: selected,
                  onSelected: (sel) {
                    final updated = List<SocialPlatform>.from(_filters.platforms);
                    if (sel) {
                      updated.add(p);
                    } else {
                      updated.remove(p);
                    }
                    setState(() => _filters = _filters.copyWith(platforms: updated));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),

            // Categories
            Text('Categories', style: AppTypography.heading),
            const SizedBox(height: AppSpacing.xs),
            categoriesAsync.when(
              loading: () => const AppSkeleton(),
              error: (e, _) => Text('Error loading categories: $e'),
              data: (cats) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: cats.take(12).map((c) {
                    final selected = _filters.categoryIds.contains(c.id);
                    return AppChip(
                      label: c.name,
                      selected: selected,
                      onSelected: (sel) {
                        final updated = List<String>.from(_filters.categoryIds);
                        if (sel) {
                          updated.add(c.id);
                        } else {
                          updated.remove(c.id);
                        }
                        setState(() => _filters = _filters.copyWith(categoryIds: updated));
                      },
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),

            // Location
            Text('Location', style: AppTypography.heading),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'City',
                    controller: _cityController,
                    onChanged: (v) => _filters = _filters.copyWith(city: v.trim().isNotEmpty ? v.trim() : null),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppTextField(
                    label: 'State',
                    controller: _stateController,
                    onChanged: (v) => _filters = _filters.copyWith(state: v.trim().isNotEmpty ? v.trim() : null),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Rates Range
            Text('Starting Rate (INR ₹)', style: AppTypography.heading),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'Min Price',
                    controller: _minRateController,
                    keyboardType: TextInputType.number,
                    onChanged: (v) => _filters = _filters.copyWith(minRate: double.tryParse(v.trim())),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppTextField(
                    label: 'Max Price',
                    controller: _maxRateController,
                    keyboardType: TextInputType.number,
                    onChanged: (v) => _filters = _filters.copyWith(maxRate: double.tryParse(v.trim())),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Management Status
            Text('Management', style: AppTypography.heading),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: 8,
              children: [
                AppChip(
                  label: 'Agency/Manager Represented',
                  selected: _filters.isRepresented == true,
                  onSelected: (sel) => setState(() {
                    _filters = _filters.copyWith(isRepresented: sel ? true : null);
                  }),
                ),
                AppChip(
                  label: 'Self Managed',
                  selected: _filters.isRepresented == false,
                  onSelected: (sel) => setState(() {
                    _filters = _filters.copyWith(isRepresented: sel ? false : null);
                  }),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Apply Button
            AppButton(
              label: 'Apply Filters (${_filters.activeFilterCount})',
              onPressed: () {
                ref.read(creatorSearchFiltersProvider.notifier).state = _filters;
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
