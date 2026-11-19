
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/app_failure.dart';
import '../domain/contact_models.dart';
import '../domain/contact_outreach_repository.dart';

class SupabaseContactOutreachRepository implements ContactOutreachRepository {
  SupabaseContactOutreachRepository(this._client);

  final SupabaseClient _client;

  @override
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
  }) async {
    try {
      final res = await _client.from('creator_contact_requests').insert({
        'sender_user_id': senderUserId,
        'sender_organization_id': senderOrganizationId,
        'sender_organization_name': senderOrganizationName,
        'recipient_creator_id': recipientCreatorId,
        'recipient_directory_id': recipientDirectoryId,
        'recipient_display_name': recipientDisplayName,
        'recipient_avatar_path': recipientAvatarPath,
        'is_registered_creator': isRegisteredCreator,
        'request_type': requestType.wire,
        'campaign_name': campaignName,
        'collaboration_requirement': collaborationRequirement,
        'deliverables': deliverables,
        'expected_timeline': expectedTimeline,
        'personal_message': personalMessage,
        'status': ContactRequestStatus.pending.wire,
        'contact_method': contactMethod.wire,
      }).select().single();

      return CreatorContactRequest.fromJson(Map<String, dynamic>.from(res));
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
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
  }) async {
    try {
      final res = await _client.from('creator_contact_requests').insert({
        'sender_user_id': senderUserId,
        'sender_organization_id': senderOrganizationId,
        'sender_organization_name': senderOrganizationName,
        'recipient_directory_id': recipientDirectoryId,
        'recipient_creator_id': recipientCreatorId,
        'recipient_display_name': recipientDisplayName,
        'recipient_avatar_path': recipientAvatarPath,
        'is_registered_creator': recipientCreatorId != null,
        'request_type': ContactRequestType.brandCollaboration.wire,
        'collaboration_requirement': notes ?? 'External communication initiated via ${contactMethod.label}',
        'status': ContactRequestStatus.pending.wire,
        'contact_method': contactMethod.wire,
        'external_stage': stage.wire,
      }).select().single();

      return CreatorContactRequest.fromJson(Map<String, dynamic>.from(res));
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<CreatorContactRequest> updateExternalOutreachStage({
    required String requestId,
    required ExternalOutreachStage stage,
  }) async {
    try {
      final res = await _client
          .from('creator_contact_requests')
          .update({'external_stage': stage.wire, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', requestId)
          .select()
          .single();
      return CreatorContactRequest.fromJson(Map<String, dynamic>.from(res));
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<List<CreatorContactRequest>> listSentOutreach({
    required String userId,
    String? organizationId,
  }) async {
    try {
      var query = _client.from('creator_contact_requests').select();
      if (organizationId != null && organizationId.isNotEmpty) {
        query = query.or('sender_organization_id.eq.$organizationId,sender_user_id.eq.$userId');
      } else {
        query = query.eq('sender_user_id', userId);
      }
      final res = await query.order('created_at', ascending: false);
      return (res as List)
          .map((r) => CreatorContactRequest.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<List<CreatorContactRequest>> listCreatorIncomingRequests({
    required String creatorId,
  }) async {
    try {
      final res = await _client
          .from('creator_contact_requests')
          .select()
          .eq('recipient_creator_id', creatorId)
          .order('created_at', ascending: false);
      return (res as List)
          .map((r) => CreatorContactRequest.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<CreatorContactRequest> acceptContactRequest({
    required String requestId,
    required String creatorUserId,
  }) async {
    try {
      // 1. Fetch request details to create conversation
      final reqMap = await _client.from('creator_contact_requests').select().eq('id', requestId).single();
      final req = CreatorContactRequest.fromJson(Map<String, dynamic>.from(reqMap));

      // 2. Create conversation
      final convRes = await _client.from('outreach_conversations').insert({
        'request_id': requestId,
        'organization_id': req.senderOrganizationId,
        'brand_user_id': req.senderUserId,
        'creator_user_id': creatorUserId,
        'subject': req.campaignName ?? req.requestType.label,
      }).select().single();
      final convId = convRes['id'] as String;

      // 3. Mark request as accepted
      final updateRes = await _client
          .from('creator_contact_requests')
          .update({
            'status': ContactRequestStatus.accepted.wire,
            'conversation_id': convId,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', requestId)
          .select()
          .single();

      return CreatorContactRequest.fromJson(Map<String, dynamic>.from(updateRes));
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<CreatorContactRequest> declineContactRequest({
    required String requestId,
    String? reason,
  }) async {
    try {
      final res = await _client
          .from('creator_contact_requests')
          .update({
            'status': ContactRequestStatus.declined.wire,
            'decline_reason': reason,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', requestId)
          .select()
          .single();
      return CreatorContactRequest.fromJson(Map<String, dynamic>.from(res));
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<CreatorContactRequest> cancelContactRequest({
    required String requestId,
    String? reason,
  }) async {
    try {
      final res = await _client
          .from('creator_contact_requests')
          .update({
            'status': ContactRequestStatus.cancelled.wire,
            'cancellation_reason': reason,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', requestId)
          .select()
          .single();
      return CreatorContactRequest.fromJson(Map<String, dynamic>.from(res));
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<PrivateQuotation> submitPrivateQuotation({
    required String requestId,
    required String creatorId,
    required double proposedAmount,
    String currency = 'INR',
    required String deliverableDescription,
    String? usageRights,
    String? timeline,
    String? notes,
  }) async {
    try {
      final res = await _client.from('creator_quotations').insert({
        'request_id': requestId,
        'creator_id': creatorId,
        'proposed_amount': proposedAmount,
        'currency': currency,
        'deliverable_description': deliverableDescription,
        'usage_rights': usageRights,
        'timeline': timeline,
        'notes': notes,
      }).select().single();
      return PrivateQuotation.fromJson(Map<String, dynamic>.from(res));
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<PrivateQuotation?> getPrivateQuotation(String requestId) async {
    try {
      final res = await _client
          .from('creator_quotations')
          .select()
          .eq('request_id', requestId)
          .maybeSingle();
      if (res == null) return null;
      return PrivateQuotation.fromJson(Map<String, dynamic>.from(res));
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<CreatorContactPreferences> getCreatorContactPreferences(String creatorId) async {
    try {
      final res = await _client
          .from('creator_contact_preferences')
          .select()
          .eq('creator_id', creatorId)
          .maybeSingle();
      if (res == null) {
        return CreatorContactPreferences(creatorId: creatorId);
      }
      return CreatorContactPreferences.fromJson(Map<String, dynamic>.from(res));
    } catch (e) {
      return CreatorContactPreferences(creatorId: creatorId);
    }
  }

  @override
  Future<void> updateCreatorContactPreferences(CreatorContactPreferences preferences) async {
    try {
      await _client.from('creator_contact_preferences').upsert(preferences.toJson());
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<List<OutreachConversation>> listConversations({
    required String userId,
    String? organizationId,
  }) async {
    try {
      var query = _client.from('outreach_conversations').select();
      if (organizationId != null && organizationId.isNotEmpty) {
        query = query.or('organization_id.eq.$organizationId,creator_user_id.eq.$userId,brand_user_id.eq.$userId');
      } else {
        query = query.or('creator_user_id.eq.$userId,brand_user_id.eq.$userId');
      }
      final res = await query.order('last_message_at', ascending: false);
      return (res as List)
          .map((r) => OutreachConversation.fromJson(Map<String, dynamic>.from(r as Map)))
          .toList();
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<OutreachConversation> getConversation(String conversationId) async {
    try {
      final res = await _client
          .from('outreach_conversations')
          .select()
          .eq('id', conversationId)
          .single();
      return OutreachConversation.fromJson(Map<String, dynamic>.from(res));
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<List<OutreachMessage>> getMessages(String conversationId) async {
    try {
      final uid = _client.auth.currentUser?.id;
      final res = await _client
          .from('outreach_messages')
          .select()
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: true);
      return (res as List)
          .map((r) => OutreachMessage.fromJson(Map<String, dynamic>.from(r as Map), currentUserId: uid))
          .toList();
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<OutreachMessage> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderName,
    required String content,
  }) async {
    try {
      final res = await _client.from('outreach_messages').insert({
        'conversation_id': conversationId,
        'sender_id': senderId,
        'sender_name': senderName,
        'content': content,
      }).select().single();

      await _client
          .from('outreach_conversations')
          .update({'last_message_at': DateTime.now().toIso8601String()})
          .eq('id', conversationId);

      return OutreachMessage.fromJson(Map<String, dynamic>.from(res), currentUserId: senderId);
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<void> blockUser({
    required String blockerUserId,
    required String blockedUserId,
    String? reason,
  }) async {
    try {
      await _client.from('user_blocks').insert({
        'blocker_user_id': blockerUserId,
        'blocked_user_id': blockedUserId,
        'reason': reason,
      });
    } catch (e) {
      throw mapFailure(e);
    }
  }

  @override
  Future<void> submitReport({
    required String reporterUserId,
    String? reportedUserId,
    String? reportedDirectoryId,
    String? requestId,
    required String reason,
    String? details,
  }) async {
    try {
      await _client.from('contact_safety_reports').insert({
        'reporter_user_id': reporterUserId,
        'reported_user_id': reportedUserId,
        'reported_directory_id': reportedDirectoryId,
        'request_id': requestId,
        'reason': reason,
        'details': details,
      });
    } catch (e) {
      throw mapFailure(e);
    }
  }
}
