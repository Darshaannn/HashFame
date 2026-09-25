import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/telemetry/analytics_service.dart';
import '../domain/creator_discovery_item.dart';
import '../domain/creator_search_filters.dart';

class CreatorSearchFiltersNotifier extends Notifier<CreatorSearchFilters> {
  @override
  CreatorSearchFilters build() => const CreatorSearchFilters();

  void update(CreatorSearchFilters Function(CreatorSearchFilters) cb) {
    state = cb(state);
  }

  void set(CreatorSearchFilters filters) {
    state = filters;
  }
}

final creatorSearchFiltersProvider =
    NotifierProvider<CreatorSearchFiltersNotifier, CreatorSearchFilters>(
      CreatorSearchFiltersNotifier.new,
    );

class DiscoveryState {
  const DiscoveryState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.nextOffset = 0,
    this.error,
  });

  final List<CreatorDiscoveryItem> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int nextOffset;
  final String? error;

  DiscoveryState copyWith({
    List<CreatorDiscoveryItem>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? nextOffset,
    String? error,
  }) {
    return DiscoveryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      nextOffset: nextOffset ?? this.nextOffset,
      error: error,
    );
  }
}

final discoveryControllerProvider =
    NotifierProvider<DiscoveryController, DiscoveryState>(
      DiscoveryController.new,
    );

class DiscoveryController extends Notifier<DiscoveryState> {
  Timer? _debounceTimer;

  @override
  DiscoveryState build() {
    ref.listen(creatorSearchFiltersProvider, (previous, next) {
      if (previous != next) {
        _onFiltersChanged(next);
      }
    });

    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    // Initial search
    Future.microtask(() => search(initial: true));

    return const DiscoveryState(isLoading: true);
  }

  void _onFiltersChanged(CreatorSearchFilters filters) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      search(initial: true);
    });
  }

  Future<void> search({bool initial = false}) async {
    final repo = ref.read(discoveryRepositoryProvider);
    final filters = ref.read(creatorSearchFiltersProvider);

    if (initial) {
      state = state.copyWith(isLoading: true, error: null, nextOffset: 0);
      try {
        final result = await repo.searchCreators(
          filters: filters,
          limit: 20,
          offset: 0,
        );
        state = state.copyWith(
          items: result.items,
          isLoading: false,
          hasMore: result.hasMore,
          nextOffset: result.nextOffset ?? 20,
        );
        await ref
            .read(analyticsProvider)
            .event(AnalyticsEvent.creatorSearchPerformed);
      } catch (e) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    } else {
      if (state.isLoadingMore || !state.hasMore) return;
      state = state.copyWith(isLoadingMore: true, error: null);
      try {
        final result = await repo.searchCreators(
          filters: filters,
          limit: 20,
          offset: state.nextOffset,
        );
        state = state.copyWith(
          items: [...state.items, ...result.items],
          isLoadingMore: false,
          hasMore: result.hasMore,
          nextOffset: result.nextOffset ?? (state.nextOffset + 20),
        );
      } catch (e) {
        state = state.copyWith(isLoadingMore: false, error: e.toString());
      }
    }
  }

  void retry() {
    search(initial: true);
  }
}
