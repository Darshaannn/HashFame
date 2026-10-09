import 'active_collaboration.dart';

abstract interface class CollaborationRepository {
  Future<ActiveCollaboration> getCollaboration(String collaborationId);

  Future<List<ActiveCollaboration>> listUserCollaborations({
    required String userId,
    ActiveCollaborationStatus? status,
  });

  Future<List<ActiveCollaboration>> listOrganizationCollaborations({
    required String organizationId,
    ActiveCollaborationStatus? status,
  });

  Future<CollaborationDeliverableSubmission> submitDeliverable({
    required String collaborationId,
    required String deliverableTitle,
    required String contentLink,
    String? creatorNotes,
  });

  Future<CollaborationDeliverableSubmission> reviewDeliverable({
    required String submissionId,
    required String action, // 'approve' or 'request_revision'
    String? feedback,
  });

  Future<ActiveCollaboration> completeCollaboration({
    required String collaborationId,
    String? notes,
  });

  Future<CollaborationMessage> sendMessage({
    required String collaborationId,
    required String senderId,
    required String senderName,
    required String content,
  });

  Future<List<CollaborationMessage>> getMessages(String collaborationId);
}
