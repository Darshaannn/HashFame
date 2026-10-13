/// Role context for GGs AI Assistant
enum AssistantRole {
  brand('brand'),
  creator('creator'),
  agency('agency');

  const AssistantRole(this.wire);
  final String wire;
}

/// Supported Assistant Tasks
enum AssistantTask {
  draftBrief('draft_brief'),
  suggestDeliverables('suggest_deliverables'),
  explainFilters('explain_filters'),
  draftPitch('draft_pitch'),
  suggestProfileImprovements('suggest_profile_improvements'),
  summarizeCreator('summarize_creator');

  const AssistantTask(this.wire);
  final String wire;
}

/// Request payload sent to the backend assistant endpoint
class AssistantRequest {
  const AssistantRequest({
    required this.role,
    required this.task,
    required this.contextData,
  });

  final AssistantRole role;
  final AssistantTask task;
  final Map<String, dynamic> contextData;

  Map<String, dynamic> toJson() => {
        'role': role.wire,
        'task': task.wire,
        'contextData': contextData,
      };
}

/// Response returned from the assistant
class AssistantResponse {
  const AssistantResponse({
    required this.success,
    this.suggestion,
    this.rationale,
    this.fields = const {},
    this.errorMessage,
    this.rateLimitRemaining,
  });

  final bool success;
  final String? suggestion;
  final String? rationale;
  final Map<String, dynamic> fields;
  final String? errorMessage;
  final int? rateLimitRemaining;

  factory AssistantResponse.fromJson(Map<String, dynamic> json) {
    return AssistantResponse(
      success: json['success'] as bool? ?? false,
      suggestion: json['suggestion'] as String?,
      rationale: json['rationale'] as String?,
      fields: (json['fields'] as Map<String, dynamic>?) ?? const {},
      errorMessage: json['error'] as String?,
      rateLimitRemaining: json['rateLimitRemaining'] as int?,
    );
  }

  factory AssistantResponse.failure(String error) {
    return AssistantResponse(
      success: false,
      errorMessage: error,
    );
  }
}

/// Provider-independent interface for GGs AI Assistant Service
abstract interface class AssistantService {
  Future<AssistantResponse> executeTask(AssistantRequest request);
  bool get isConfigured;
}
