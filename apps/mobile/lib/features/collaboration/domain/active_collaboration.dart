import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_collaboration.freezed.dart';
part 'active_collaboration.g.dart';

enum ActiveCollaborationStatus {
  @JsonValue('active')
  active,
  @JsonValue('submitted')
  submitted,
  @JsonValue('revision_requested')
  revisionRequested,
  @JsonValue('approved')
  approved,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

extension ActiveCollaborationStatusExtension on ActiveCollaborationStatus {
  String get wire => switch (this) {
    ActiveCollaborationStatus.active => 'active',
    ActiveCollaborationStatus.submitted => 'submitted',
    ActiveCollaborationStatus.revisionRequested => 'revision_requested',
    ActiveCollaborationStatus.approved => 'approved',
    ActiveCollaborationStatus.completed => 'completed',
    ActiveCollaborationStatus.cancelled => 'cancelled',
  };

  String get label => switch (this) {
    ActiveCollaborationStatus.active => 'In Progress',
    ActiveCollaborationStatus.submitted => 'Deliverables Submitted',
    ActiveCollaborationStatus.revisionRequested => 'Revision Requested',
    ActiveCollaborationStatus.approved => 'Deliverables Approved',
    ActiveCollaborationStatus.completed => 'Completed',
    ActiveCollaborationStatus.cancelled => 'Cancelled',
  };
}

enum DeliverableSubmissionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('submitted')
  submitted,
  @JsonValue('revision_requested')
  revisionRequested,
  @JsonValue('approved')
  approved,
}

extension DeliverableSubmissionStatusExtension on DeliverableSubmissionStatus {
  String get wire => switch (this) {
    DeliverableSubmissionStatus.pending => 'pending',
    DeliverableSubmissionStatus.submitted => 'submitted',
    DeliverableSubmissionStatus.revisionRequested => 'revision_requested',
    DeliverableSubmissionStatus.approved => 'approved',
  };

  String get label => switch (this) {
    DeliverableSubmissionStatus.pending => 'Pending Submission',
    DeliverableSubmissionStatus.submitted => 'Under Review',
    DeliverableSubmissionStatus.revisionRequested => 'Changes Requested',
    DeliverableSubmissionStatus.approved => 'Approved',
  };
}

@Freezed(toJson: true, fromJson: true)
abstract class CollaborationDeliverableSubmission
    with _$CollaborationDeliverableSubmission {
  const factory CollaborationDeliverableSubmission({
    required String id,
    required String collaborationId,
    required String deliverableTitle,
    required String contentLink,
    String? creatorNotes,
    @Default(DeliverableSubmissionStatus.submitted)
    DeliverableSubmissionStatus status,
    String? feedback,
    required DateTime submittedAt,
    DateTime? reviewedAt,
    String? reviewedBy,
    @Default(1) int version,
  }) = _CollaborationDeliverableSubmission;

  factory CollaborationDeliverableSubmission.fromJson(
    Map<String, dynamic> json,
  ) => _$CollaborationDeliverableSubmissionFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class CollaborationMessage with _$CollaborationMessage {
  const factory CollaborationMessage({
    required String id,
    required String collaborationId,
    required String senderId,
    required String senderName,
    required String content,
    DateTime? readAt,
    required DateTime createdAt,
    @Default(false) bool isMine,
  }) = _CollaborationMessage;

  factory CollaborationMessage.fromJson(Map<String, dynamic> json) =>
      _$CollaborationMessageFromJson(json);
}

@Freezed(toJson: true, fromJson: true)
abstract class ActiveCollaboration with _$ActiveCollaboration {
  const factory ActiveCollaboration({
    required String id,
    required String organizationId,
    required String campaignId,
    required String applicationId,
    required String creatorId,
    @Default(ActiveCollaborationStatus.active) ActiveCollaborationStatus status,
    double? compensationAmount,
    @Default('INR') String currency,
    DateTime? dueDate,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    required DateTime createdAt,
    DateTime? updatedAt,

    // Joined Presentation Details
    String? campaignTitle,
    String? brandName,
    String? brandLogoUrl,
    String? creatorDisplayName,
    String? creatorAvatarPath,
    String? creatorCity,
    @Default([]) List<String> deliverableRequirements,
    @Default([]) List<CollaborationDeliverableSubmission> submissions,
    @Default([]) List<CollaborationMessage> messages,
  }) = _ActiveCollaboration;

  factory ActiveCollaboration.fromJson(Map<String, dynamic> json) =>
      _$ActiveCollaborationFromJson(json);
}
