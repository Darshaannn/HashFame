// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityEvent _$ActivityEventFromJson(Map<String, dynamic> json) =>
    _ActivityEvent(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      collaborationId: json['collaboration_id'] as String?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      activityType: json['activity_type'] as String,
      route: json['route'] as String?,
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ActivityEventToJson(_ActivityEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'collaboration_id': instance.collaborationId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'activity_type': instance.activityType,
      'route': instance.route,
      'is_read': instance.isRead,
      'created_at': instance.createdAt.toIso8601String(),
    };
