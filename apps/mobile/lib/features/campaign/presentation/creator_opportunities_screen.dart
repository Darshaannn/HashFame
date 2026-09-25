import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/campaign_opportunity_item.dart';
import 'campaign_controller.dart';
import 'widgets/campaign_filter_sheet.dart';
import 'widgets/campaign_opportunity_card.dart';

class CreatorOpportunitiesScreen extends ConsumerStatefulWidget {
  const CreatorOpportunitiesScreen({super.key});

  @override
  ConsumerState<CreatorOpportunitiesScreen> createState() =>
      _CreatorOpportunitiesScreenState();
}

class _CreatorOpportunitiesScreenState
    extends ConsumerState<CreatorOpportunitiesScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refresh();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _refresh() {
    final filters = ref.read(campaignFiltersProvider);
    final userId = ref.read(sessionProvider).snapshot?.account.id;
    ref
        .read(opportunitySearchControllerProvider.notifier)
        .search(filters: filters, creatorId: userId, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(opportunitySearchControllerProvider);
    final filters = ref.watch(campaignFiltersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Work'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.filter_list),
                if (filters.hasActiveFilters)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 8,
                        minHeight: 8,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => CampaignFilterSheet(
                  initialFilters: filters,
                  onApply: (updated) {
                    ref.read(campaignFiltersProvider.notifier).set(updated);
                    _refresh();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _refresh(),
        child: Column(
          children: [
            // Search Input
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: AppSearchField(
                onChanged: (val) {
                  ref
                      .read(campaignFiltersProvider.notifier)
                      .set(filters.copyWith(query: val.trim()));
                  _refresh();
                },
              ),
            ),

            // Opportunity List
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.isLoading && state.items.isEmpty) {
                    return const Center(child: AppLoader());
                  }

                  if (state.error != null && state.items.isEmpty) {
                    return Center(
                      child: AppErrorState(
                        message: state.error!,
                        onRetry: _refresh,
                      ),
                    );
                  }

                  if (state.items.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppEmptyState(
                              title: 'No Campaigns Found',
                              message: filters.hasActiveFilters
                                  ? 'No live campaigns match your filter criteria.'
                                  : 'There are currently no live creator opportunities.',
                            ),
                            if (filters.hasActiveFilters) ...[
                              const SizedBox(height: AppSpacing.sm),
                              OutlinedButton(
                                onPressed: () {
                                  ref
                                      .read(campaignFiltersProvider.notifier)
                                      .set(const CampaignSearchFilters());
                                  _searchController.clear();
                                  _refresh();
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
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: state.items.length + (state.hasMore ? 1 : 0),
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      if (index == state.items.length) {
                        return Center(
                          child: state.isLoadingMore
                              ? const AppLoader()
                              : TextButton(
                                  onPressed: () {
                                    final userId = ref
                                        .read(sessionProvider)
                                        .snapshot
                                        ?.account
                                        .id;
                                    ref
                                        .read(
                                          opportunitySearchControllerProvider
                                              .notifier,
                                        )
                                        .loadMore(
                                          filters: filters,
                                          creatorId: userId,
                                        );
                                  },
                                  child: const Text('Load More'),
                                ),
                        );
                      }

                      final item = state.items[index];
                      return CampaignOpportunityCard(
                        item: item,
                        onTap: () =>
                            context.push('/opportunities/${item.campaignId}'),
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
