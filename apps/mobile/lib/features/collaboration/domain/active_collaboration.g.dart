// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_collaboration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CollaborationDeliverableSubmission
_$CollaborationDeliverableSubmissionFromJson(Map<String, dynamic> json) =>
    _CollaborationDeliverableSubmission(
      id: json['id'] as String,
      collaborationId: json['collaboration_id'] as String,
      deliverableTitle: json['deliverable_title'] as String,
      contentLink: json['content_link'] as String,
      creatorNotes: json['creator_notes'] as String?,
      status:
          $enumDecodeNullable(
            _$DeliverableSubmissionStatusEnumMap,
            json['status'],
          ) ??
          DeliverableSubmissionStatus.submitted,
      feedback: json['feedback'] as String?,
      submittedAt: DateTime.parse(json['submitted_at'] as String),
      reviewedAt: json['reviewed_at'] == null
          ? null
          : DateTime.parse(json['reviewed_at'] as String),
      reviewedBy: json['reviewed_by'] as String?,
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$CollaborationDeliverableSubmissionToJson(
  _CollaborationDeliverableSubmission instance,
) => <String, dynamic>{
  'id': instance.id,
  'collaboration_id': instance.collaborationId,
  'deliverable_title': instance.deliverableTitle,
  'content_link': instance.contentLink,
  'creator_notes': instance.creatorNotes,
  'status': _$DeliverableSubmissionStatusEnumMap[instance.status]!,
  'feedback': instance.feedback,
  'submitted_at': instance.submittedAt.toIso8601String(),
  'reviewed_at': instance.reviewedAt?.toIso8601String(),
  'reviewed_by': instance.reviewedBy,
  'version': instance.version,
};

const _$DeliverableSubmissionStatusEnumMap = {
  DeliverableSubmissionStatus.pending: 'pending',
  DeliverableSubmissionStatus.submitted: 'submitted',
  DeliverableSubmissionStatus.revisionRequested: 'revision_requested',
  DeliverableSubmissionStatus.approved: 'approved',
};

_CollaborationMessage _$CollaborationMessageFromJson(
  Map<String, dynamic> json,
) => _CollaborationMessage(
  id: json['id'] as String,
  collaborationId: json['collaboration_id'] as String,
  senderId: json['sender_id'] as String,
  senderName: json['sender_name'] as String,
  content: json['content'] as String,
  readAt: json['read_at'] == null
      ? null
      : DateTime.parse(json['read_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  isMine: json['is_mine'] as bool? ?? false,
);

Map<String, dynamic> _$CollaborationMessageToJson(
  _CollaborationMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'collaboration_id': instance.collaborationId,
  'sender_id': instance.senderId,
  'sender_name': instance.senderName,
  'content': instance.content,
  'read_at': instance.readAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'is_mine': instance.isMine,
};

_ActiveCollaboration _$ActiveCollaborationFromJson(
  Map<String, dynamic> json,
) => _ActiveCollaboration(
  id: json['id'] as String,
  organizationId: json['organization_id'] as String,
  campaignId: json['campaign_id'] as String,
  applicationId: json['application_id'] as String,
  creatorId: json['creator_id'] as String,
  status:
      $enumDecodeNullable(_$ActiveCollaborationStatusEnumMap, json['status']) ??
      ActiveCollaborationStatus.active,
  compensationAmount: (json['compensation_amount'] as num?)?.toDouble(),
  currency: json['currency'] as String? ?? 'INR',
  dueDate: json['due_date'] == null
      ? null
      : DateTime.parse(json['due_date'] as String),
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
  cancelledAt: json['cancelled_at'] == null
      ? null
      : DateTime.parse(json['cancelled_at'] as String),
  cancellationReason: json['cancellation_reason'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  campaignTitle: json['campaign_title'] as String?,
  brandName: json['brand_name'] as String?,
  brandLogoUrl: json['brand_logo_url'] as String?,
  creatorDisplayName: json['creator_display_name'] as String?,
  creatorAvatarPath: json['creator_avatar_path'] as String?,
  creatorCity: json['creator_city'] as String?,
  deliverableRequirements:
      (json['deliverable_requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  submissions:
      (json['submissions'] as List<dynamic>?)
          ?.map(
            (e) => CollaborationDeliverableSubmission.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const [],
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => CollaborationMessage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ActiveCollaborationToJson(
  _ActiveCollaboration instance,
) => <String, dynamic>{
  'id': instance.id,
  'organization_id': instance.organizationId,
  'campaign_id': instance.campaignId,
  'application_id': instance.applicationId,
  'creator_id': instance.creatorId,
  'status': _$ActiveCollaborationStatusEnumMap[instance.status]!,
  'compensation_amount': instance.compensationAmount,
  'currency': instance.currency,
  'due_date': instance.dueDate?.toIso8601String(),
  'completed_at': instance.completedAt?.toIso8601String(),
  'cancelled_at': instance.cancelledAt?.toIso8601String(),
  'cancellation_reason': instance.cancellationReason,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'campaign_title': instance.campaignTitle,
  'brand_name': instance.brandName,
  'brand_logo_url': instance.brandLogoUrl,
  'creator_display_name': instance.creatorDisplayName,
  'creator_avatar_path': instance.creatorAvatarPath,
  'creator_city': instance.creatorCity,
  'deliverable_requirements': instance.deliverableRequirements,
  'submissions': instance.submissions.map((e) => e.toJson()).toList(),
  'messages': instance.messages.map((e) => e.toJson()).toList(),
};

const _$ActiveCollaborationStatusEnumMap = {
  ActiveCollaborationStatus.active: 'active',
  ActiveCollaborationStatus.submitted: 'submitted',
  ActiveCollaborationStatus.revisionRequested: 'revision_requested',
  ActiveCollaborationStatus.approved: 'approved',
  ActiveCollaborationStatus.completed: 'completed',
  ActiveCollaborationStatus.cancelled: 'cancelled',
};
