import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_event.freezed.dart';
part 'activity_event.g.dart';

@Freezed(toJson: true, fromJson: true)
abstract class ActivityEvent with _$ActivityEvent {
  const factory ActivityEvent({
    required String id,
    required String userId,
    String? collaborationId,
    required String title,
    required String subtitle,
    required String activityType,
    String? route,
    @Default(false) bool isRead,
    required DateTime createdAt,
  }) = _ActivityEvent;

  factory ActivityEvent.fromJson(Map<String, dynamic> json) =>
      _$ActivityEventFromJson(json);
}
