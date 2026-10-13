import 'package:dio/dio.dart';
import '../domain/assistant_service.dart';

/// Production implementation communicating with the backend Supabase Edge Function
class SupabaseAssistantServiceImpl implements AssistantService {
  SupabaseAssistantServiceImpl({
    required this.supabaseUrl,
    required this.tokenProvider,
    Dio? dioClient,
  }) : _dio = dioClient ?? Dio();

  final String supabaseUrl;
  final Future<String?> Function() tokenProvider;
  final Dio _dio;

  @override
  bool get isConfigured =>
      supabaseUrl.isNotEmpty && !supabaseUrl.contains('localhost_unconfigured');

  @override
  Future<AssistantResponse> executeTask(AssistantRequest request) async {
    final token = await tokenProvider();
    if (token == null || token.isEmpty) {
      return AssistantResponse.failure(
        'Authentication required to use AI Assistant. Please sign in.',
      );
    }

    try {
      final endpoint = '$supabaseUrl/functions/v1/ggs-assistant';
      final response = await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          sendTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );

      if (response.data != null) {
        return AssistantResponse.fromJson(response.data!);
      }
      return AssistantResponse.failure('Empty response from AI assistant service.');
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        return AssistantResponse.failure(
          'AI rate limit reached. Please wait a minute before requesting another suggestion.',
        );
      }
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        return AssistantResponse.failure(
          'Unauthorized: Your session lacks permissions for this AI task.',
        );
      }
      final serverMessage = e.response?.data is Map
          ? (e.response?.data as Map)['error']?.toString()
          : null;
      return AssistantResponse.failure(
        serverMessage ??
            'AI Assistant is currently unavailable. Please verify connection.',
      );
    } catch (e) {
      return AssistantResponse.failure('Failed to connect to AI Assistant: $e');
    }
  }
}

/// In-Memory Demo implementation with authentic role logic
/// (Strictly uses actual context data without fake statistics)
class DemoAssistantServiceImpl implements AssistantService {
  const DemoAssistantServiceImpl({this.simulateError = false});

  final bool simulateError;

  @override
  bool get isConfigured => true;

  @override
  Future<AssistantResponse> executeTask(AssistantRequest request) async {
    // Artificial small latency for human-realistic UX
    await Future<void>.delayed(const Duration(milliseconds: 300));

    if (simulateError) {
      return AssistantResponse.failure(
        'AI Assistant temporary service failure. Please retry.',
      );
    }

    final data = request.contextData;

    switch (request.task) {
      case AssistantTask.draftBrief:
        final title = (data['title'] as String?)?.trim() ?? 'Creator Campaign';
        final objective = (data['objective'] as String?)?.trim() ??
            'Authentic product review and community engagement';
        return AssistantResponse(
          success: true,
          suggestion:
              'Seeking collaborative creators for "$title". Objective: $objective. Deliverables will require 1 dedicated Reel/video (60s) and 2 Story frames with brand tags. We offer milestone payouts upon deliverable verification.',
          rationale:
              'Drafted with clear scope, transparent expectations, and high creator response probability.',
          fields: {
            'deliverables': '1x Dedicated Video/Reel, 2x Story posts',
            'suggestedSlots': 3,
          },
        );

      case AssistantTask.suggestDeliverables:
        return const AssistantResponse(
          success: true,
          suggestion:
              'Recommended bundle: 1x 60-second high-resolution Reel/Video, 2x Instagram Stories with link stickers, and 30 days organic digital usage rights.',
          rationale:
              'Standard high-performing deliverable structure for Indian creator campaigns.',
          fields: {
            'deliverables': '1x Reel (60s), 2x Story frames',
          },
        );

      case AssistantTask.explainFilters:
        return const AssistantResponse(
          success: true,
          suggestion:
              'The "Verified Only" filter displays talent with confirmed identities. Filtering by Category targets niche creators, while Engagement Rate ensures authentic community resonance.',
          rationale:
              'Filter explanation based on actual GGs discovery parameters.',
        );

      case AssistantTask.draftPitch:
        final campaign = (data['campaignTitle'] as String?) ?? 'this campaign';
        return AssistantResponse(
          success: true,
          suggestion:
              'Hi team, I would love to collaborate on "$campaign"! My audience is highly aligned with your niche, and my visual aesthetic matches your brand standard. I guarantee on-time milestone delivery and proactive communication.',
          rationale:
              'Short, direct pitch highlighting relevance, audience fit, and milestone reliability.',
        );

      case AssistantTask.suggestProfileImprovements:
        final hasBio = data['hasBio'] as bool? ?? false;
        final hasRateCard = data['hasRateCard'] as bool? ?? false;
        final hasLanguages = data['hasLanguages'] as bool? ?? false;

        final missing = <String>[];
        if (!hasBio) missing.add('Add an authentic 2-line bio describing your style');
        if (!hasRateCard) missing.add('Publish a rate card so brands can book you faster');
        if (!hasLanguages) missing.add('Specify languages you create content in');

        final suggestion = missing.isEmpty
            ? 'Your profile contains all core verification fields! Keeping your rate card up to date ensures faster brand selections.'
            : 'To increase brand shortlist rates, complete these fields:\n• ${missing.join("\n• ")}';

        return AssistantResponse(
          success: true,
          suggestion: suggestion,
          rationale:
              'Based on your active profile completeness fields in the GGs repository.',
        );

      case AssistantTask.summarizeCreator:
        final name = (data['name'] as String?) ?? 'Creator';
        final handle = (data['handle'] as String?) ?? '';
        final category = (data['primaryCategory'] as String?) ?? 'General';
        return AssistantResponse(
          success: true,
          suggestion:
              '$name (@$handle) specializes in $category. Clear candidate for category-targeted campaigns with direct deliverables.',
          rationale: 'Generated purely from verified profile data.',
        );
    }
  }
}
