import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/telemetry/analytics_service.dart';
import '../../discovery/domain/creator_discovery_item.dart';

class ComparisonState {
  const ComparisonState({
    this.selectedCreatorIds = const [],
    this.creators = const [],
    this.isLoading = false,
    this.error,
  });

  final List<String> selectedCreatorIds;
  final List<CreatorDiscoveryItem> creators;
  final bool isLoading;
  final String? error;

  static const int maxLimit = 4;

  ComparisonState copyWith({
    List<String>? selectedCreatorIds,
    List<CreatorDiscoveryItem>? creators,
    bool? isLoading,
    String? error,
  }) {
    return ComparisonState(
      selectedCreatorIds: selectedCreatorIds ?? this.selectedCreatorIds,
      creators: creators ?? this.creators,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final comparisonControllerProvider =
    NotifierProvider<ComparisonController, ComparisonState>(
  ComparisonController.new,
);

class ComparisonController extends Notifier<ComparisonState> {
  @override
  ComparisonState build() => const ComparisonState();

  Future<void> setCreators(List<String> creatorIds) async {
    final bounded = creatorIds.take(ComparisonState.maxLimit).toList();
    state = state.copyWith(selectedCreatorIds: bounded, isLoading: true, error: null);

    try {
      final repo = ref.read(discoveryRepositoryProvider);
      final list = await repo.getCreatorsForComparison(creatorIds: bounded);
      state = state.copyWith(creators: list, isLoading: false);
      await ref.read(analyticsProvider).event(AnalyticsEvent.creatorComparisonStarted);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addCreator(String creatorId) async {
    if (state.selectedCreatorIds.contains(creatorId)) return;
    if (state.selectedCreatorIds.length >= ComparisonState.maxLimit) {
      state = state.copyWith(error: 'Maximum 4 creators can be compared side-by-side.');
      return;
    }
    final updated = [...state.selectedCreatorIds, creatorId];
    await setCreators(updated);
  }

  Future<void> removeCreator(String creatorId) async {
    final updated = state.selectedCreatorIds.where((id) => id != creatorId).toList();
    await setCreators(updated);
  }

  void clear() {
    state = const ComparisonState();
  }
}
