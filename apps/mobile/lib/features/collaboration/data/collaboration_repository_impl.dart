import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/active_collaboration.dart';
import '../domain/collaboration_repository.dart';

class SupabaseCollaborationDataSource {
  const SupabaseCollaborationDataSource(this.client);
  final SupabaseClient client;

  Future<ActiveCollaboration> getCollaboration(String collaborationId) async {
    final response = await client
        .from('collaborations')
        .select('''
          *,
          campaigns(
            title,
            organizations(name, logo_path)
          ),
          creator_profiles(
            user_id,
            city,
            profiles(display_name, avatar_path)
          ),
          deliverable_submissions(*),
          collaboration_messages(*)
        ''')
        .eq('id', collaborationId)
        .single();

    return _mapCollaboration(response);
  }

  Future<List<ActiveCollaboration>> listUserCollaborations({
    required String userId,
    ActiveCollaborationStatus? status,
  }) async {
    var query = client
        .from('collaborations')
        .select('''
          *,
          campaigns(
            title,
            organizations(name, logo_path)
          ),
          creator_profiles(
            user_id,
            city,
            profiles(display_name, avatar_path)
          ),
          deliverable_submissions(*),
          collaboration_messages(*)
        ''')
        .eq('creator_id', userId);

    if (status != null) {
      query = query.eq('status', status.wire);
    }

    final response = await query.order('created_at', ascending: false);
    return (response as List).map((row) => _mapCollaboration(row)).toList();
  }

  Future<List<ActiveCollaboration>> listOrganizationCollaborations({
    required String organizationId,
    ActiveCollaborationStatus? status,
  }) async {
    var query = client
        .from('collaborations')
        .select('''
          *,
          campaigns(
            title,
            organizations(name, logo_path)
          ),
          creator_profiles(
            user_id,
            city,
            profiles(display_name, avatar_path)
          ),
          deliverable_submissions(*),
          collaboration_messages(*)
        ''')
        .eq('organization_id', organizationId);

    if (status != null) {
      query = query.eq('status', status.wire);
    }

    final response = await query.order('created_at', ascending: false);
    return (response as List).map((row) => _mapCollaboration(row)).toList();
  }

  Future<CollaborationDeliverableSubmission> submitDeliverable({
    required String collaborationId,
    required String deliverableTitle,
    required String contentLink,
    String? creatorNotes,
  }) async {
    final response = await client.rpc(
      'submit_deliverable_content',
      params: {
        'p_collaboration_id': collaborationId,
        'p_deliverable_title': deliverableTitle,
        'p_content_link': contentLink,
        'p_creator_notes': creatorNotes,
      },
    );

    return _mapSubmission(response as Map<String, dynamic>);
  }

  Future<CollaborationDeliverableSubmission> reviewDeliverable({
    required String submissionId,
    required String action,
    String? feedback,
  }) async {
    final response = await client.rpc(
      'review_deliverable_submission',
      params: {
        'p_submission_id': submissionId,
        'p_action': action,
        'p_feedback': feedback,
      },
    );

    return _mapSubmission(response as Map<String, dynamic>);
  }

  Future<ActiveCollaboration> completeCollaboration({
    required String collaborationId,
    String? notes,
  }) async {
    await client.rpc(
      'complete_collaboration',
      params: {'p_collaboration_id': collaborationId, 'p_notes': notes},
    );

    return getCollaboration(collaborationId);
  }

  Future<CollaborationMessage> sendMessage({
    required String collaborationId,
    required String senderId,
    required String senderName,
    required String content,
  }) async {
    final response = await client
        .from('collaboration_messages')
        .insert({
          'collaboration_id': collaborationId,
          'sender_id': senderId,
          'content': content,
        })
        .select()
        .single();

    return CollaborationMessage(
      id: response['id'] as String,
      collaborationId: collaborationId,
      senderId: senderId,
      senderName: senderName,
      content: content,
      readAt: response['read_at'] != null
          ? DateTime.parse(response['read_at'] as String)
          : null,
      createdAt: DateTime.parse(response['created_at'] as String),
      isMine: true,
    );
  }

  Future<List<CollaborationMessage>> getMessages(String collaborationId) async {
    final response = await client
        .from('collaboration_messages')
        .select('''
          *,
          profiles(display_name)
        ''')
        .eq('collaboration_id', collaborationId)
        .order('created_at', ascending: true);

    final currentUserId = client.auth.currentUser?.id;

    return (response as List).map((row) {
      final senderProfile = row['profiles'] as Map<String, dynamic>?;
      return CollaborationMessage(
        id: row['id'] as String,
        collaborationId: collaborationId,
        senderId: row['sender_id'] as String,
        senderName: senderProfile?['display_name'] as String? ?? 'User',
        content: row['content'] as String,
        readAt: row['read_at'] != null
            ? DateTime.parse(row['read_at'] as String)
            : null,
        createdAt: DateTime.parse(row['created_at'] as String),
        isMine: currentUserId != null && row['sender_id'] == currentUserId,
      );
    }).toList();
  }

  ActiveCollaboration _mapCollaboration(Map<String, dynamic> row) {
    final campaign = row['campaigns'] as Map<String, dynamic>?;
    final org = campaign?['organizations'] as Map<String, dynamic>?;
    final creator = row['creator_profiles'] as Map<String, dynamic>?;
    final profile = creator?['profiles'] as Map<String, dynamic>?;
    final subs = (row['deliverable_submissions'] as List? ?? []);
    final msgs = (row['collaboration_messages'] as List? ?? []);
    final currentUserId = client.auth.currentUser?.id;

    final submissions =
        subs.map((s) => _mapSubmission(s as Map<String, dynamic>)).toList()
          ..sort((a, b) => b.submittedAt.compareTo(a.submittedAt));

    final messages = msgs.map((m) {
      return CollaborationMessage(
        id: m['id'] as String,
        collaborationId: row['id'] as String,
        senderId: m['sender_id'] as String,
        senderName: m['sender_id'] == creator?['user_id']
            ? (profile?['display_name'] as String? ?? 'Creator')
            : (org?['name'] as String? ?? 'Brand'),
        content: m['content'] as String,
        readAt: m['read_at'] != null
            ? DateTime.parse(m['read_at'] as String)
            : null,
        createdAt: DateTime.parse(m['created_at'] as String),
        isMine: currentUserId != null && m['sender_id'] == currentUserId,
      );
    }).toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return ActiveCollaboration(
      id: row['id'] as String,
      organizationId: row['organization_id'] as String,
      campaignId: row['campaign_id'] as String,
      applicationId: row['application_id'] as String,
      creatorId: row['creator_id'] as String,
      status: _parseCollaborationStatus(row['status'] as String?),
      compensationAmount: (row['compensation_amount'] as num?)?.toDouble(),
      currency: row['currency'] as String? ?? 'INR',
      dueDate: row['due_date'] != null
          ? DateTime.parse(row['due_date'] as String)
          : null,
      completedAt: row['completed_at'] != null
          ? DateTime.parse(row['completed_at'] as String)
          : null,
      cancelledAt: row['cancelled_at'] != null
          ? DateTime.parse(row['cancelled_at'] as String)
          : null,
      cancellationReason: row['cancellation_reason'] as String?,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: row['updated_at'] != null
          ? DateTime.parse(row['updated_at'] as String)
          : null,
      campaignTitle: campaign?['title'] as String?,
      brandName: org?['name'] as String?,
      brandLogoUrl: org?['logo_path'] as String?,
      creatorDisplayName: profile?['display_name'] as String?,
      creatorAvatarPath: profile?['avatar_path'] as String?,
      creatorCity: creator?['city'] as String?,
      submissions: submissions,
      messages: messages,
    );
  }

  CollaborationDeliverableSubmission _mapSubmission(Map<String, dynamic> row) {
    return CollaborationDeliverableSubmission(
      id: row['id'] as String,
      collaborationId: row['collaboration_id'] as String,
      deliverableTitle: row['deliverable_title'] as String,
      contentLink: row['content_link'] as String,
      creatorNotes: row['creator_notes'] as String?,
      status: _parseDeliverableStatus(row['status'] as String?),
      feedback: row['feedback'] as String?,
      submittedAt: DateTime.parse(row['submitted_at'] as String),
      reviewedAt: row['reviewed_at'] != null
          ? DateTime.parse(row['reviewed_at'] as String)
          : null,
      reviewedBy: row['reviewed_by'] as String?,
      version: row['version'] as int? ?? 1,
    );
  }

  ActiveCollaborationStatus _parseCollaborationStatus(String? value) {
    return switch (value) {
      'submitted' => ActiveCollaborationStatus.submitted,
      'revision_requested' => ActiveCollaborationStatus.revisionRequested,
      'approved' => ActiveCollaborationStatus.approved,
      'completed' => ActiveCollaborationStatus.completed,
      'cancelled' => ActiveCollaborationStatus.cancelled,
      _ => ActiveCollaborationStatus.active,
    };
  }

  DeliverableSubmissionStatus _parseDeliverableStatus(String? value) {
    return switch (value) {
      'pending' => DeliverableSubmissionStatus.pending,
      'revision_requested' => DeliverableSubmissionStatus.revisionRequested,
      'approved' => DeliverableSubmissionStatus.approved,
      _ => DeliverableSubmissionStatus.submitted,
    };
  }
}

class CollaborationRepositoryImpl implements CollaborationRepository {
  CollaborationRepositoryImpl(this.dataSource);
  final SupabaseCollaborationDataSource dataSource;

  @override
  Future<ActiveCollaboration> getCollaboration(String collaborationId) =>
      dataSource.getCollaboration(collaborationId);

  @override
  Future<List<ActiveCollaboration>> listUserCollaborations({
    required String userId,
    ActiveCollaborationStatus? status,
  }) => dataSource.listUserCollaborations(userId: userId, status: status);

  @override
  Future<List<ActiveCollaboration>> listOrganizationCollaborations({
    required String organizationId,
    ActiveCollaborationStatus? status,
  }) => dataSource.listOrganizationCollaborations(
    organizationId: organizationId,
    status: status,
  );

  @override
  Future<CollaborationDeliverableSubmission> submitDeliverable({
    required String collaborationId,
    required String deliverableTitle,
    required String contentLink,
    String? creatorNotes,
  }) => dataSource.submitDeliverable(
    collaborationId: collaborationId,
    deliverableTitle: deliverableTitle,
    contentLink: contentLink,
    creatorNotes: creatorNotes,
  );

  @override
  Future<CollaborationDeliverableSubmission> reviewDeliverable({
    required String submissionId,
    required String action,
    String? feedback,
  }) => dataSource.reviewDeliverable(
    submissionId: submissionId,
    action: action,
    feedback: feedback,
  );

  @override
  Future<ActiveCollaboration> completeCollaboration({
    required String collaborationId,
    String? notes,
  }) => dataSource.completeCollaboration(
    collaborationId: collaborationId,
    notes: notes,
  );

  @override
  Future<CollaborationMessage> sendMessage({
    required String collaborationId,
    required String senderId,
    required String senderName,
    required String content,
  }) => dataSource.sendMessage(
    collaborationId: collaborationId,
    senderId: senderId,
    senderName: senderName,
    content: content,
  );

  @override
  Future<List<CollaborationMessage>> getMessages(String collaborationId) =>
      dataSource.getMessages(collaborationId);
}
