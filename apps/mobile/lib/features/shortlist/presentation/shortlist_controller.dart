import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/telemetry/analytics_service.dart';
import '../domain/shortlist.dart';
import '../domain/shortlist_member.dart';

final shortlistsListProvider = FutureProvider.autoDispose<List<Shortlist>>((
  ref,
) async {
  final repo = ref.watch(shortlistRepositoryProvider);
  return repo.listShortlists();
});

final shortlistDetailProvider = FutureProvider.autoDispose
    .family<Shortlist, String>((ref, id) async {
      final repo = ref.watch(shortlistRepositoryProvider);
      return repo.getShortlist(shortlistId: id);
    });

final savedCreatorMembershipsProvider =
    FutureProvider.autoDispose<Map<String, List<String>>>((ref) async {
      final repo = ref.watch(shortlistRepositoryProvider);
      return repo.getSavedCreatorMemberships();
    });

final shortlistControllerProvider =
    NotifierProvider<ShortlistController, AsyncValue<void>>(
      ShortlistController.new,
    );

class ShortlistController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> createShortlist({
    required String name,
    String? description,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(shortlistRepositoryProvider);
      await repo.createShortlist(name: name, description: description);
      ref.invalidate(shortlistsListProvider);
      ref.invalidate(savedCreatorMembershipsProvider);
      await ref.read(analyticsProvider).event(AnalyticsEvent.shortlistCreated);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateShortlist({
    required String shortlistId,
    String? name,
    String? description,
    bool? isArchived,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(shortlistRepositoryProvider);
      await repo.updateShortlist(
        shortlistId: shortlistId,
        name: name,
        description: description,
        isArchived: isArchived,
      );
      ref.invalidate(shortlistsListProvider);
      ref.invalidate(shortlistDetailProvider(shortlistId));
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteShortlist({required String shortlistId}) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(shortlistRepositoryProvider);
      await repo.deleteShortlist(shortlistId: shortlistId);
      ref.invalidate(shortlistsListProvider);
      ref.invalidate(savedCreatorMembershipsProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addCreatorToShortlist({
    required String shortlistId,
    required String creatorId,
    ShortlistMemberStatus status = ShortlistMemberStatus.potential,
    String? notes,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(shortlistRepositoryProvider);
      await repo.addCreatorToShortlist(
        shortlistId: shortlistId,
        creatorId: creatorId,
        status: status,
        notes: notes,
      );
      ref.invalidate(shortlistDetailProvider(shortlistId));
      ref.invalidate(savedCreatorMembershipsProvider);
      ref.invalidate(shortlistsListProvider);
      await ref
          .read(analyticsProvider)
          .event(AnalyticsEvent.creatorShortlisted);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removeCreatorFromShortlist({
    required String shortlistId,
    required String creatorId,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(shortlistRepositoryProvider);
      await repo.removeCreatorFromShortlist(
        shortlistId: shortlistId,
        creatorId: creatorId,
      );
      ref.invalidate(shortlistDetailProvider(shortlistId));
      ref.invalidate(savedCreatorMembershipsProvider);
      ref.invalidate(shortlistsListProvider);
      await ref
          .read(analyticsProvider)
          .event(AnalyticsEvent.creatorRemovedFromShortlist);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateMemberStatus({
    required String shortlistId,
    required String memberId,
    required ShortlistMemberStatus status,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(shortlistRepositoryProvider);
      await repo.updateMemberStatus(memberId: memberId, status: status);
      ref.invalidate(shortlistDetailProvider(shortlistId));
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateMemberNotes({
    required String shortlistId,
    required String memberId,
    required String notes,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(shortlistRepositoryProvider);
      await repo.updateMemberNotes(memberId: memberId, notes: notes);
      ref.invalidate(shortlistDetailProvider(shortlistId));
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
