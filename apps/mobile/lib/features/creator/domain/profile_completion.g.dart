// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MissingRecommendation _$MissingRecommendationFromJson(
  Map<String, dynamic> json,
) => _MissingRecommendation(
  key: json['key'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  weight: (json['weight'] as num).toInt(),
  actionRoute: json['action_route'] as String,
);

Map<String, dynamic> _$MissingRecommendationToJson(
  _MissingRecommendation instance,
) => <String, dynamic>{
  'key': instance.key,
  'title': instance.title,
  'description': instance.description,
  'weight': instance.weight,
  'action_route': instance.actionRoute,
};

_ProfileCompletionReport _$ProfileCompletionReportFromJson(
  Map<String, dynamic> json,
) => _ProfileCompletionReport(
  percentage: (json['percentage'] as num).toInt(),
  recommendations: (json['recommendations'] as List<dynamic>)
      .map((e) => MissingRecommendation.fromJson(e as Map<String, dynamic>))
      .toList(),
  completedFields: Map<String, bool>.from(json['completed_fields'] as Map),
);

Map<String, dynamic> _$ProfileCompletionReportToJson(
  _ProfileCompletionReport instance,
) => <String, dynamic>{
  'percentage': instance.percentage,
  'recommendations': instance.recommendations.map((e) => e.toJson()).toList(),
  'completed_fields': instance.completedFields,
};
