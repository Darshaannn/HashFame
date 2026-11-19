enum ContactRequestType {
  brandCollaboration('brand_collaboration', 'Brand Collaboration'),
  paidPartnership('paid_partnership', 'Paid Partnership'),
  barterCollaboration('barter_collaboration', 'Barter Collaboration'),
  eventAppearance('event_appearance', 'Event Appearance'),
  ugcRequirement('ugc_requirement', 'UGC Requirement'),
  requestQuotation('request_quotation', 'Request Quotation'),
  other('other', 'Other Enquiry');

  const ContactRequestType(this.wire, this.label);
  final String wire;
  final String label;

  static ContactRequestType fromWire(String? wire) {
    return ContactRequestType.values.firstWhere(
      (e) => e.wire == wire,
      orElse: () => ContactRequestType.brandCollaboration,
    );
  }
}

enum ContactRequestStatus {
  pending('pending', 'Pending Response'),
  accepted('accepted', 'Accepted'),
  declined('declined', 'Declined'),
  cancelled('cancelled', 'Cancelled'),
  expired('expired', 'Expired');

  const ContactRequestStatus(this.wire, this.label);
  final String wire;
  final String label;

  static ContactRequestStatus fromWire(String? wire) {
    return ContactRequestStatus.values.firstWhere(
      (e) => e.wire == wire,
      orElse: () => ContactRequestStatus.pending,
    );
  }
}

enum OutreachContactMethod {
  inApp('in_app', 'In-App'),
  instagram('instagram', 'Instagram'),
  whatsapp('whatsapp', 'WhatsApp'),
  email('email', 'Email'),
  phone('phone', 'Phone');

  const OutreachContactMethod(this.wire, this.label);
  final String wire;
  final String label;

  static OutreachContactMethod fromWire(String? wire) {
    return OutreachContactMethod.values.firstWhere(
      (e) => e.wire == wire,
      orElse: () => OutreachContactMethod.inApp,
    );
  }
}

enum ExternalOutreachStage {
  channelOpened('channel_opened', 'Channel Opened'),
  contactedManually('contacted_manually', 'Contacted (Logged)'),
  responseReceived('response_received', 'Response Received'),
  followUpRequired('follow_up_required', 'Follow-up Needed');

  const ExternalOutreachStage(this.wire, this.label);
  final String wire;
  final String label;

  static ExternalOutreachStage fromWire(String? wire) {
    return ExternalOutreachStage.values.firstWhere(
      (e) => e.wire == wire,
      orElse: () => ExternalOutreachStage.channelOpened,
    );
  }
}

class CreatorContactPreferences {
  const CreatorContactPreferences({
    required this.creatorId,
    this.allowCollaborationRequests = true,
    this.allowBusinessEmail = false,
    this.businessEmail,
    this.allowPhone = false,
    this.phoneNumber,
    this.allowWhatsapp = false,
    this.whatsappNumber,
    this.preferredContactMethod = OutreachContactMethod.inApp,
    this.responseTimeHours = 48,
  });

  final String creatorId;
  final bool allowCollaborationRequests;
  final bool allowBusinessEmail;
  final String? businessEmail;
  final bool allowPhone;
  final String? phoneNumber;
  final bool allowWhatsapp;
  final String? whatsappNumber;
  final OutreachContactMethod preferredContactMethod;
  final int responseTimeHours;

  factory CreatorContactPreferences.fromJson(Map<String, dynamic> json) {
    return CreatorContactPreferences(
      creatorId: json['creator_id'] as String? ?? '',
      allowCollaborationRequests: json['allow_collaboration_requests'] as bool? ?? true,
      allowBusinessEmail: json['allow_business_email'] as bool? ?? false,
      businessEmail: json['business_email'] as String?,
      allowPhone: json['allow_phone'] as bool? ?? false,
      phoneNumber: json['phone_number'] as String?,
      allowWhatsapp: json['allow_whatsapp'] as bool? ?? false,
      whatsappNumber: json['whatsapp_number'] as String?,
      preferredContactMethod: OutreachContactMethod.fromWire(json['preferred_contact_method'] as String?),
      responseTimeHours: json['response_time_hours'] as int? ?? 48,
    );
  }

  Map<String, dynamic> toJson() => {
    'creator_id': creatorId,
    'allow_collaboration_requests': allowCollaborationRequests,
    'allow_business_email': allowBusinessEmail,
    'business_email': businessEmail,
    'allow_phone': allowPhone,
    'phone_number': phoneNumber,
    'allow_whatsapp': allowWhatsapp,
    'whatsapp_number': whatsappNumber,
    'preferred_contact_method': preferredContactMethod.wire,
    'response_time_hours': responseTimeHours,
  };
}

class CreatorContactRequest {
  const CreatorContactRequest({
    required this.id,
    required this.senderUserId,
    this.senderOrganizationId,
    required this.senderOrganizationName,
    this.recipientCreatorId,
    this.recipientDirectoryId,
    required this.recipientDisplayName,
    this.recipientAvatarPath,
    this.isRegisteredCreator = false,
    required this.requestType,
    this.campaignName,
    required this.collaborationRequirement,
    this.deliverables = const [],
    this.expectedTimeline,
    this.personalMessage,
    this.status = ContactRequestStatus.pending,
    this.contactMethod = OutreachContactMethod.inApp,
    this.externalStage = ExternalOutreachStage.channelOpened,
    this.declineReason,
    this.cancellationReason,
    this.conversationId,
    required this.createdAt,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? createdAt;

  final String id;
  final String senderUserId;
  final String? senderOrganizationId;
  final String senderOrganizationName;
  final String? recipientCreatorId;
  final String? recipientDirectoryId;
  final String recipientDisplayName;
  final String? recipientAvatarPath;
  final bool isRegisteredCreator;
  final ContactRequestType requestType;
  final String? campaignName;
  final String collaborationRequirement;
  final List<String> deliverables;
  final String? expectedTimeline;
  final String? personalMessage;
  final ContactRequestStatus status;
  final OutreachContactMethod contactMethod;
  final ExternalOutreachStage externalStage;
  final String? declineReason;
  final String? cancellationReason;
  final String? conversationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isPending => status == ContactRequestStatus.pending;
  bool get isAccepted => status == ContactRequestStatus.accepted;
  bool get isDeclined => status == ContactRequestStatus.declined;
  bool get isCancelled => status == ContactRequestStatus.cancelled;

  CreatorContactRequest copyWith({
    ContactRequestStatus? status,
    ExternalOutreachStage? externalStage,
    String? declineReason,
    String? cancellationReason,
    String? conversationId,
    DateTime? updatedAt,
  }) {
    return CreatorContactRequest(
      id: id,
      senderUserId: senderUserId,
      senderOrganizationId: senderOrganizationId,
      senderOrganizationName: senderOrganizationName,
      recipientCreatorId: recipientCreatorId,
      recipientDirectoryId: recipientDirectoryId,
      recipientDisplayName: recipientDisplayName,
      recipientAvatarPath: recipientAvatarPath,
      isRegisteredCreator: isRegisteredCreator,
      requestType: requestType,
      campaignName: campaignName,
      collaborationRequirement: collaborationRequirement,
      deliverables: deliverables,
      expectedTimeline: expectedTimeline,
      personalMessage: personalMessage,
      status: status ?? this.status,
      contactMethod: contactMethod,
      externalStage: externalStage ?? this.externalStage,
      declineReason: declineReason ?? this.declineReason,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      conversationId: conversationId ?? this.conversationId,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CreatorContactRequest.fromJson(Map<String, dynamic> json) {
    return CreatorContactRequest(
      id: json['id'] as String? ?? '',
      senderUserId: json['sender_user_id'] as String? ?? '',
      senderOrganizationId: json['sender_organization_id'] as String?,
      senderOrganizationName: json['sender_organization_name'] as String? ?? '',
      recipientCreatorId: json['recipient_creator_id'] as String?,
      recipientDirectoryId: json['recipient_directory_id'] as String?,
      recipientDisplayName: json['recipient_display_name'] as String? ?? 'Creator',
      recipientAvatarPath: json['recipient_avatar_path'] as String?,
      isRegisteredCreator: json['is_registered_creator'] as bool? ?? false,
      requestType: ContactRequestType.fromWire(json['request_type'] as String?),
      campaignName: json['campaign_name'] as String?,
      collaborationRequirement: json['collaboration_requirement'] as String? ?? '',
      deliverables: (json['deliverables'] as List?)?.cast<String>() ?? const [],
      expectedTimeline: json['expected_timeline'] as String?,
      personalMessage: json['personal_message'] as String?,
      status: ContactRequestStatus.fromWire(json['status'] as String?),
      contactMethod: OutreachContactMethod.fromWire(json['contact_method'] as String?),
      externalStage: ExternalOutreachStage.fromWire(json['external_stage'] as String?),
      declineReason: json['decline_reason'] as String?,
      cancellationReason: json['cancellation_reason'] as String?,
      conversationId: json['conversation_id'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
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
    'status': status.wire,
    'contact_method': contactMethod.wire,
    'external_stage': externalStage.wire,
    'decline_reason': declineReason,
    'cancellation_reason': cancellationReason,
    'conversation_id': conversationId,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

class PrivateQuotation {
  const PrivateQuotation({
    required this.id,
    required this.requestId,
    required this.creatorId,
    required this.proposedAmount,
    this.currency = 'INR',
    required this.deliverableDescription,
    this.usageRights,
    this.timeline,
    this.notes,
    required this.createdAt,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? createdAt;

  final String id;
  final String requestId;
  final String creatorId;
  final double proposedAmount;
  final String currency;
  final String deliverableDescription;
  final String? usageRights;
  final String? timeline;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory PrivateQuotation.fromJson(Map<String, dynamic> json) {
    return PrivateQuotation(
      id: json['id'] as String? ?? '',
      requestId: json['request_id'] as String? ?? '',
      creatorId: json['creator_id'] as String? ?? '',
      proposedAmount: (json['proposed_amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'INR',
      deliverableDescription: json['deliverable_description'] as String? ?? '',
      usageRights: json['usage_rights'] as String?,
      timeline: json['timeline'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'request_id': requestId,
    'creator_id': creatorId,
    'proposed_amount': proposedAmount,
    'currency': currency,
    'deliverable_description': deliverableDescription,
    'usage_rights': usageRights,
    'timeline': timeline,
    'notes': notes,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

class OutreachConversation {
  const OutreachConversation({
    required this.id,
    required this.requestId,
    this.organizationId,
    required this.brandUserId,
    required this.creatorUserId,
    required this.subject,
    required this.lastMessageAt,
    required this.createdAt,
    this.creatorName,
    this.brandName,
    this.creatorAvatarPath,
    this.unreadCount = 0,
  });

  final String id;
  final String requestId;
  final String? organizationId;
  final String brandUserId;
  final String creatorUserId;
  final String subject;
  final DateTime lastMessageAt;
  final DateTime createdAt;
  final String? creatorName;
  final String? brandName;
  final String? creatorAvatarPath;
  final int unreadCount;

  factory OutreachConversation.fromJson(Map<String, dynamic> json) {
    return OutreachConversation(
      id: json['id'] as String? ?? '',
      requestId: json['request_id'] as String? ?? '',
      organizationId: json['organization_id'] as String?,
      brandUserId: json['brand_user_id'] as String? ?? '',
      creatorUserId: json['creator_user_id'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      lastMessageAt: json['last_message_at'] != null ? DateTime.parse(json['last_message_at'] as String) : DateTime.now(),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now(),
      creatorName: json['creator_name'] as String?,
      brandName: json['brand_name'] as String?,
      creatorAvatarPath: json['creator_avatar_path'] as String?,
      unreadCount: json['unread_count'] as int? ?? 0,
    );
  }
}

class OutreachMessage {
  const OutreachMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.content,
    this.readAt,
    required this.createdAt,
    this.isMine = false,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime? readAt;
  final DateTime createdAt;
  final bool isMine;

  factory OutreachMessage.fromJson(Map<String, dynamic> json, {String? currentUserId}) {
    final sender = json['sender_id'] as String? ?? '';
    return OutreachMessage(
      id: json['id'] as String? ?? '',
      conversationId: json['conversation_id'] as String? ?? '',
      senderId: sender,
      senderName: json['sender_name'] as String? ?? '',
      content: json['content'] as String? ?? '',
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at'] as String) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now(),
      isMine: currentUserId != null && sender == currentUserId,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversation_id': conversationId,
    'sender_id': senderId,
    'sender_name': senderName,
    'content': content,
    'read_at': readAt?.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
  };
}
