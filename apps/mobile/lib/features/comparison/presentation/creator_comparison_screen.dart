import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/tokens.dart';
import '../../discovery/domain/creator_discovery_item.dart';
import 'comparison_controller.dart';

class CreatorComparisonScreen extends ConsumerWidget {
  const CreatorComparisonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(comparisonControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Creators'),
        actions: [
          if (state.creators.isNotEmpty)
            TextButton(
              onPressed: () =>
                  ref.read(comparisonControllerProvider.notifier).clear(),
              child: const Text('Clear'),
            ),
        ],
      ),
      body: SafeArea(
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.creators.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.compare_arrows,
                        size: 48,
                        color: AppColors.outline,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'No creators selected',
                        style: AppTypography.heading,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const Text(
                        'Select up to 4 creators from a shortlist or discovery to compare them side-by-side.',
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: DataTable(
                    columnSpacing: 24,
                    columns: [
                      const DataColumn(
                        label: Text(
                          'Attribute',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...state.creators.map(
                        (c) => DataColumn(
                          label: Row(
                            children: [
                              Text(
                                c.displayName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 16),
                                onPressed: () => ref
                                    .read(comparisonControllerProvider.notifier)
                                    .removeCreator(c.creatorId),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      _buildRow(
                        'Professional Alias',
                        state.creators,
                        (c) => c.professionalName ?? 'Unavailable',
                      ),
                      _buildRow(
                        'Location',
                        state.creators,
                        (c) => c.city != null
                            ? '${c.city}, ${c.state ?? c.country}'
                            : 'Unavailable',
                      ),
                      _buildRow(
                        'Categories',
                        state.creators,
                        (c) => c.primaryCategoryNames.isNotEmpty
                            ? c.primaryCategoryNames.join(', ')
                            : 'Unavailable',
                      ),
                      _buildRow(
                        'Languages',
                        state.creators,
                        (c) => c.languageNames.isNotEmpty
                            ? c.languageNames.join(', ')
                            : 'Unavailable',
                      ),
                      _buildRow(
                        'Primary Platform',
                        state.creators,
                        (c) => c.primaryPlatform?.label ?? 'Unavailable',
                      ),
                      _buildRow(
                        'Reported Followers',
                        state.creators,
                        (c) => c.totalFollowers != null
                            ? c.totalFollowers.toString()
                            : 'Unavailable',
                      ),
                      _buildRow(
                        'Starting Rate',
                        state.creators,
                        (c) => c.startingRate != null
                            ? '₹${c.startingRate!.toStringAsFixed(0)}'
                            : 'Unavailable',
                      ),
                      _buildRow(
                        'Availability',
                        state.creators,
                        (c) => c.availabilityStatus.label,
                      ),
                      _buildRow(
                        'Representation',
                        state.creators,
                        (c) => c.isRepresented
                            ? 'Agency/Manager Represented'
                            : 'Self Managed',
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  DataRow _buildRow(
    String label,
    List<CreatorDiscoveryItem> creators,
    String Function(CreatorDiscoveryItem) extractor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        ...creators.map((c) => DataCell(Text(extractor(c)))),
      ],
    );
  }
}
