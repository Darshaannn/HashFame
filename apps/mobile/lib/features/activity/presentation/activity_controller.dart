import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../domain/activity_event.dart';

final userActivityProvider = FutureProvider.autoDispose
    .family<List<ActivityEvent>, String>((ref, userId) async {
      final repo = ref.watch(activityRepositoryProvider);
      return repo.getUserActivity(userId);
    });

final activityActionControllerProvider =
    NotifierProvider.autoDispose<ActivityActionController, AsyncValue<void>>(
      ActivityActionController.new,
    );

class ActivityActionController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> markAsRead(String activityId, String userId) async {
    try {
      final repo = ref.read(activityRepositoryProvider);
      await repo.markActivityAsRead(activityId);
      ref.invalidate(userActivityProvider(userId));
    } catch (_) {}
  }
}
