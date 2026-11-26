import 'contact_models.dart';

abstract interface class ContactOutreachRepository {
  /// Send a formal contact request or quotation request
  Future<CreatorContactRequest> sendContactRequest({
    required String senderUserId,
    String? senderOrganizationId,
    required String senderOrganizationName,
    String? recipientCreatorId,
    String? recipientDirectoryId,
    required String recipientDisplayName,
    String? recipientAvatarPath,
    required bool isRegisteredCreator,
    required ContactRequestType requestType,
    String? campaignName,
    required String collaborationRequirement,
    List<String> deliverables = const [],
    String? expectedTimeline,
    String? personalMessage,
    OutreachContactMethod contactMethod = OutreachContactMethod.inApp,
  });

  /// Log external channel opened or manual outreach progress
  Future<CreatorContactRequest> logExternalOutreach({
    required String senderUserId,
    String? senderOrganizationId,
    required String senderOrganizationName,
    String? recipientDirectoryId,
    String? recipientCreatorId,
    required String recipientDisplayName,
    String? recipientAvatarPath,
    required OutreachContactMethod contactMethod,
    ExternalOutreachStage stage = ExternalOutreachStage.channelOpened,
    String? notes,
  });

  /// Update stage for external outreach (e.g. contacted manually, response received)
  Future<CreatorContactRequest> updateExternalOutreachStage({
    required String requestId,
    required ExternalOutreachStage stage,
  });

  /// List outreach sent by Brand or Agency organization/user
  Future<List<CreatorContactRequest>> listSentOutreach({
    required String userId,
    String? organizationId,
  });

  /// List incoming contact requests for a Creator
  Future<List<CreatorContactRequest>> listCreatorIncomingRequests({
    required String creatorId,
  });

  /// Recipient accepts a contact request
  Future<CreatorContactRequest> acceptContactRequest({
    required String requestId,
    required String creatorUserId,
  });

  /// Recipient declines a contact request
  Future<CreatorContactRequest> declineContactRequest({
    required String requestId,
    String? reason,
  });

  /// Sender cancels a pending contact request
  Future<CreatorContactRequest> cancelContactRequest({
    required String requestId,
    String? reason,
  });

  /// Creator submits a private commercial quotation
  Future<PrivateQuotation> submitPrivateQuotation({
    required String requestId,
    required String creatorId,
    required double proposedAmount,
    String currency = 'INR',
    required String deliverableDescription,
    String? usageRights,
    String? timeline,
    String? notes,
  });

  /// Fetch private quotation for a contact request
  Future<PrivateQuotation?> getPrivateQuotation(String requestId);

  /// Fetch creator contact sharing preferences
  Future<CreatorContactPreferences> getCreatorContactPreferences(
    String creatorId,
  );

  /// Update creator contact sharing preferences
  Future<void> updateCreatorContactPreferences(
    CreatorContactPreferences preferences,
  );

  /// Conversations & In-app Messaging
  Future<List<OutreachConversation>> listConversations({
    required String userId,
    String? organizationId,
  });

  Future<OutreachConversation> getConversation(String conversationId);

  Future<List<OutreachMessage>> getMessages(String conversationId);

  Future<OutreachMessage> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderName,
    required String content,
  });

  /// Block user or submit safety report
  Future<void> blockUser({
    required String blockerUserId,
    required String blockedUserId,
    String? reason,
  });

  Future<void> submitReport({
    required String reporterUserId,
    String? reportedUserId,
    String? reportedDirectoryId,
    String? requestId,
    required String reason,
    String? details,
  });
}
