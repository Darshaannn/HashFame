import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/activity_event.dart';
import '../domain/activity_repository.dart';

class SupabaseActivityDataSource {
  const SupabaseActivityDataSource(this.client);
  final SupabaseClient client;

  Future<List<ActivityEvent>> getUserActivity(String userId) async {
    final response = await client
        .from('user_activity_feed')
        .select('*')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((row) {
      return ActivityEvent(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        collaborationId: row['collaboration_id'] as String?,
        title: row['title'] as String,
        subtitle: row['subtitle'] as String,
        activityType: row['activity_type'] as String,
        route: row['route'] as String?,
        isRead: row['is_read'] as bool? ?? false,
        createdAt: DateTime.parse(row['created_at'] as String),
      );
    }).toList();
  }

  Future<void> markActivityAsRead(String activityId) async {
    await client
        .from('user_activity_feed')
        .update({'is_read': true})
        .eq('id', activityId);
  }
}

class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl(this.dataSource);
  final SupabaseActivityDataSource dataSource;

  @override
  Future<List<ActivityEvent>> getUserActivity(String userId) =>
      dataSource.getUserActivity(userId);

  @override
  Future<void> markActivityAsRead(String activityId) =>
      dataSource.markActivityAsRead(activityId);
}
