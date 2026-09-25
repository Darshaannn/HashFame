import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../creator/presentation/profile/creator_profile_controller.dart';
import '../domain/creator_search_filters.dart';
import 'discovery_controller.dart';
import 'widgets/creator_discovery_card.dart';
import 'widgets/discover_filter_sheet.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(discoveryControllerProvider.notifier).search(initial: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discoveryControllerProvider);
    final filters = ref.watch(creatorSearchFiltersProvider);
    final categoriesAsync = ref.watch(referenceCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Creators'),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: filters.activeFilterCount > 0,
              label: Text(filters.activeFilterCount.toString()),
              child: const Icon(Icons.filter_list),
            ),
            tooltip: 'Filter',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DiscoverFilterSheet()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: AppSearchField(
                onChanged: (val) {
                  ref
                      .read(creatorSearchFiltersProvider.notifier)
                      .set(filters.copyWith(query: val.trim()));
                },
              ),
            ),

            // Category shortcuts row
            SizedBox(
              height: 42,
              child: categoriesAsync.when(
                loading: () => const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                error: (err, stack) => const SizedBox.shrink(),
                data: (cats) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: cats.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 6),
                    itemBuilder: (context, idx) {
                      final cat = cats[idx];
                      final isSelected = filters.categoryIds.contains(cat.id);
                      return ChoiceChip(
                        label: Text(cat.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          final updated = List<String>.from(
                            filters.categoryIds,
                          );
                          if (selected) {
                            updated.add(cat.id);
                          } else {
                            updated.remove(cat.id);
                          }
                          ref
                              .read(creatorSearchFiltersProvider.notifier)
                              .set(filters.copyWith(categoryIds: updated));
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // Content List
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.isLoading && state.items.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(AppSpacing.lg),
                      child: AppSkeleton(),
                    );
                  }

                  if (state.error != null && state.items.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.error!, textAlign: TextAlign.center),
                            const SizedBox(height: AppSpacing.md),
                            AppButton(
                              label: 'Retry',
                              onPressed: () => ref
                                  .read(discoveryControllerProvider.notifier)
                                  .retry(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state.items.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off,
                              size: 48,
                              color: AppColors.outline,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'No creators found',
                              style: AppTypography.heading,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            const Text(
                              'Try adjusting your search or clearing filters.',
                            ),
                            if (filters.activeFilterCount > 0) ...[
                              const SizedBox(height: AppSpacing.md),
                              OutlinedButton(
                                onPressed: () {
                                  ref
                                      .read(
                                        creatorSearchFiltersProvider.notifier,
                                      )
                                      .set(const CreatorSearchFilters());
                                },
                                child: const Text('Clear Filters'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: state.items.length + (state.hasMore ? 1 : 0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      if (index == state.items.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final creator = state.items[index];
                      return CreatorDiscoveryCard(
                        creator: creator,
                        onTap: () => context.push(
                          '/discover/creator/${creator.creatorId}',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
