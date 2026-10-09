import 'activity_event.dart';

abstract interface class ActivityRepository {
  Future<List<ActivityEvent>> getUserActivity(String userId);
  Future<void> markActivityAsRead(String activityId);
}
