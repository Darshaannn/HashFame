import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/assistant_service.dart';

/// Modal sheet presenting contextual AI assistance
class AssistantModalSheet extends ConsumerStatefulWidget {
  const AssistantModalSheet({
    super.key,
    required this.role,
    required this.task,
    required this.title,
    required this.contextData,
    this.onSuggestionAccepted,
  });

  final AssistantRole role;
  final AssistantTask task;
  final String title;
  final Map<String, dynamic> contextData;
  final void Function(AssistantResponse response)? onSuggestionAccepted;

  static Future<void> show({
    required BuildContext context,
    required AssistantRole role,
    required AssistantTask task,
    required String title,
    required Map<String, dynamic> contextData,
    void Function(AssistantResponse response)? onSuggestionAccepted,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (_) => AssistantModalSheet(
        role: role,
        task: task,
        title: title,
        contextData: contextData,
        onSuggestionAccepted: onSuggestionAccepted,
      ),
    );
  }

  @override
  ConsumerState<AssistantModalSheet> createState() => _AssistantModalSheetState();
}

class _AssistantModalSheetState extends ConsumerState<AssistantModalSheet> {
  bool _isLoading = false;
  AssistantResponse? _response;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchSuggestion();
  }

  Future<void> _fetchSuggestion() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final service = ref.read(assistantServiceProvider);
    if (!service.isConfigured) {
      setState(() {
        _isLoading = false;
        _error = 'AI Assistant is currently offline or not configured in environment.';
      });
      return;
    }

    try {
      final res = await service.executeTask(
        AssistantRequest(
          role: widget.role,
          task: widget.task,
          contextData: widget.contextData,
        ),
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
          if (res.success) {
            _response = res;
          } else {
            _error = res.errorMessage ?? 'Unable to generate recommendation.';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Failed to connect to Assistant: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with AI Icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.burgundy.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: AppColors.burgundy,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      Text(
                        l10n?.aiAssistant ?? 'GGs AI Assistant',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Content Area
            if (_isLoading) ...[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 36),
                child: Column(
                  children: [
                    CircularProgressIndicator(color: AppColors.burgundy),
                    SizedBox(height: AppSpacing.md),
                    Text(
                      'Analyzing context and generating suggestion...',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (_error != null) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.errorLight,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.error, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        _error!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: _fetchSuggestion,
                icon: const Icon(Icons.refresh, size: 16),
                label: Text(l10n?.retry ?? 'Retry'),
              ),
            ] else if (_response != null) ...[
              // AI Review & Safety Notice
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.shield_outlined, size: 16, color: AppColors.secondaryGray),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n?.aiReviewNotice ??
                            'Review this AI suggestion before applying it to your data:',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Suggestion Body Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.outlineLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _response!.suggestion ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.ink,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (_response!.rationale != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSubtle,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Why: ${_response!.rationale}',
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.secondaryGray,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Action Buttons: Accept / Discard
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.ink,
                        side: const BorderSide(color: AppColors.outline),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.control),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        l10n?.aiDiscardSuggestion ?? 'Discard',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.burgundy,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.control),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onSuggestionAccepted?.call(_response!);
                      },
                      child: Text(
                        l10n?.aiApplySuggestion ?? 'Accept & Apply',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Subtle, non-obtrusive inline AI action button
class AssistantActionChip extends StatelessWidget {
  const AssistantActionChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.burgundy.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: AppColors.burgundy.withValues(alpha: 0.35),
            width: 0.9,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.auto_awesome,
              color: AppColors.burgundy,
              size: 13,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.burgundy,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
