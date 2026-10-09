import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/design_system/components.dart';
import '../../../core/design_system/tokens.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/active_collaboration.dart';
import 'collaboration_controller.dart';

class CollaborationWorkspaceScreen extends ConsumerStatefulWidget {
  const CollaborationWorkspaceScreen({
    super.key,
    required this.collaborationId,
  });

  final String collaborationId;

  @override
  ConsumerState<CollaborationWorkspaceScreen> createState() =>
      _CollaborationWorkspaceScreenState();
}

class _CollaborationWorkspaceScreenState
    extends ConsumerState<CollaborationWorkspaceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collabAsync = ref.watch(
      collaborationDetailProvider(widget.collaborationId),
    );
    final messagesAsync = ref.watch(
      collaborationMessagesProvider(widget.collaborationId),
    );
    final session = ref.watch(sessionProvider);
    final authUserId = ref.watch(authRepositoryProvider).userId;
    final currentUserId = authUserId ?? session.snapshot?.account.id ?? '';
    final currentUserName = session.snapshot?.account.displayName ?? 'User';

    return collabAsync.when(
      loading: () => const Scaffold(body: Center(child: AppLoader())),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Collaboration Workspace')),
        body: Center(
          child: AppErrorState(
            message: e.toString(),
            onRetry: () => ref.invalidate(
              collaborationDetailProvider(widget.collaborationId),
            ),
          ),
        ),
      ),
      data: (collab) {
        final isCreator = currentUserId == collab.creatorId;
        final isCompleted =
            collab.status == ActiveCollaborationStatus.completed;

        return Scaffold(
          appBar: AppBar(
            title: Text(collab.campaignTitle ?? 'Active Collaboration'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.dashboard_outlined), text: 'Workspace'),
                Tab(
                  icon: Icon(Icons.assignment_outlined),
                  text: 'Deliverables',
                ),
                Tab(icon: Icon(Icons.chat_outlined), text: 'Messages'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // 1. Workspace Tab
              _buildWorkspaceTab(collab, isCreator, isCompleted),

              // 2. Deliverables Tab
              _buildDeliverablesTab(collab, isCreator, isCompleted),

              // 3. Messages Tab
              _buildMessagesTab(
                collab,
                messagesAsync,
                currentUserId,
                currentUserName,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWorkspaceTab(
    ActiveCollaboration collab,
    bool isCreator,
    bool isCompleted,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        collab.brandName ?? 'Brand',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppBadge(label: collab.status.label),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  collab.campaignTitle ?? 'Campaign Brief',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Creator: ${collab.creatorDisplayName ?? collab.creatorId}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                if (collab.compensationAmount != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.payments_outlined,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Compensation: ₹${collab.compensationAmount!.toStringAsFixed(0)} ${collab.currency}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
                if (collab.dueDate != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.event_outlined,
                        size: 16,
                        color: AppColors.muted,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Due Date: ${collab.dueDate!.day}/${collab.dueDate!.month}/${collab.dueDate!.year}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Deliverables Requirements
          const Text(
            'Deliverable Requirements',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppCard(
            child: collab.deliverableRequirements.isEmpty
                ? const Text(
                    '1x Instagram Reel (60s dedicated brand integration)',
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: collab.deliverableRequirements
                        .map(
                          (req) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    req,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Primary Actions
          if (!isCompleted) ...[
            if (isCreator)
              FilledButton.icon(
                onPressed: () => _tabController.animateTo(1),
                icon: const Icon(Icons.upload_file),
                label: const Text('Submit Deliverable Content'),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _tabController.animateTo(1),
                      icon: const Icon(Icons.rate_review_outlined),
                      label: const Text('Review Deliverables'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  if (collab.status == ActiveCollaborationStatus.approved)
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => _completeCollaboration(collab.id),
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Complete'),
                      ),
                    ),
                ],
              ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.control),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified, color: AppColors.success, size: 24),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'This collaboration has been fully completed and approved! 🎉',
                      style: TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeliverablesTab(
    ActiveCollaboration collab,
    bool isCreator,
    bool isCompleted,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Submission History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isCreator && !isCompleted) ...[
                const SizedBox(width: 8),
                FilledButton.tonalIcon(
                  onPressed: () => _showSubmissionDialog(collab.id),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Submit Work'),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          if (collab.submissions.isEmpty)
            const AppEmptyState(
              title: 'No submissions yet',
              message: 'When deliverables are uploaded, they will appear here for review and revision tracking.',
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: collab.submissions.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (ctx, index) {
                final sub = collab.submissions[index];
                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${sub.deliverableTitle} (v${sub.version})',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          AppBadge(label: sub.status.label),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SelectableText(
                        'Link: ${sub.contentLink}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 13,
                        ),
                      ),
                      if (sub.creatorNotes != null &&
                          sub.creatorNotes!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Notes: ${sub.creatorNotes}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.inkSecondary,
                          ),
                        ),
                      ],
                      if (sub.feedback != null && sub.feedback!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceSubtle,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.feedback_outlined,
                                size: 16,
                                color: AppColors.accent,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'Feedback: ${sub.feedback}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Submitted: ${sub.submittedAt.day}/${sub.submittedAt.month} ${sub.submittedAt.hour}:${sub.submittedAt.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),

                      // Brand / Agency Review Actions
                      if (!isCreator &&
                          sub.status == DeliverableSubmissionStatus.submitted &&
                          !isCompleted) ...[
                        const Divider(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _showReviewDialog(
                                  collab.id,
                                  sub.id,
                                  'request_revision',
                                ),
                                child: const Text('Request Revision'),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: FilledButton(
                                onPressed: () => _reviewDeliverable(
                                  collab.id,
                                  sub.id,
                                  'approve',
                                ),
                                child: const Text('Approve Content'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildMessagesTab(
    ActiveCollaboration collab,
    AsyncValue<List<CollaborationMessage>> messagesAsync,
    String currentUserId,
    String currentUserName,
  ) {
    return Column(
      children: [
        Expanded(
          child: messagesAsync.when(
            loading: () => const Center(child: AppLoader()),
            error: (e, _) =>
                Center(child: AppErrorState(message: e.toString())),
            data: (messages) {
              if (messages.isEmpty) {
                return const Center(
                  child: AppEmptyState(
                    title: 'No messages yet',
                    message: 'Start communicating regarding script drafts, logistics, or questions.',
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: messages.length,
                itemBuilder: (ctx, index) {
                  final msg = messages[index];
                  final isMine = msg.senderId == currentUserId;

                  return Align(
                    alignment: isMine
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isMine
                            ? AppColors.primary
                            : AppColors.surfaceSubtle,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                      ),
                      child: Column(
                        crossAxisAlignment: isMine
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (!isMine)
                            Text(
                              msg.senderName,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.inkSecondary,
                              ),
                            ),
                          Text(
                            msg.content,
                            style: TextStyle(
                              color: isMine ? Colors.white : AppColors.ink,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${msg.createdAt.hour}:${msg.createdAt.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 10,
                              color: isMine ? Colors.white70 : AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Message input bar
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: const Border(
              top: BorderSide(color: AppColors.outlineLight, width: 0.8),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: AppColors.primary),
                onPressed: () async {
                  final text = _messageController.text.trim();
                  if (text.isEmpty) return;
                  _messageController.clear();
                  await ref
                      .read(collaborationActionControllerProvider.notifier)
                      .sendMessage(
                        collaborationId: collab.id,
                        senderId: currentUserId,
                        senderName: currentUserName,
                        content: text,
                      );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showSubmissionDialog(String collabId) async {
    final titleCtrl = TextEditingController(text: 'Instagram Reel Final Cut');
    final linkCtrl = TextEditingController();
    final notesCtrl = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Submit Deliverable'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Deliverable Title',
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: linkCtrl,
                decoration: const InputDecoration(
                  labelText: 'Content Link (Drive / Dropbox / Unlisted)',
                  hintText: 'https://drive.google.com/...',
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: notesCtrl,
                decoration: const InputDecoration(
                  labelText: 'Creator Notes (Optional)',
                  hintText: 'Audio tag used, framing notes, etc.',
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Submit Content'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      if (linkCtrl.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please provide a valid content link.')),
        );
        return;
      }
      final success = await ref
          .read(collaborationActionControllerProvider.notifier)
          .submitDeliverable(
            collaborationId: collabId,
            deliverableTitle: titleCtrl.text.trim(),
            contentLink: linkCtrl.text.trim(),
            creatorNotes: notesCtrl.text.trim(),
          );
      if (mounted && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deliverable submitted successfully!')),
        );
      }
    }
  }

  Future<void> _showReviewDialog(
    String collabId,
    String submissionId,
    String action,
  ) async {
    final feedbackCtrl = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Request Revision'),
        content: TextField(
          controller: feedbackCtrl,
          decoration: const InputDecoration(
            labelText: 'Revision Feedback',
            hintText: 'Please adjust lighting and add official brand hashtag at 0:15.',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Send Feedback'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      await _reviewDeliverable(
        collabId,
        submissionId,
        action,
        feedbackCtrl.text.trim(),
      );
    }
  }

  Future<void> _reviewDeliverable(
    String collabId,
    String submissionId,
    String action, [
    String? feedback,
  ]) async {
    final success = await ref
        .read(collaborationActionControllerProvider.notifier)
        .reviewDeliverable(
          collaborationId: collabId,
          submissionId: submissionId,
          action: action,
          feedback: feedback,
        );
    if (mounted && success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            action == 'approve'
                ? 'Content approved!'
                : 'Revision requested from creator.',
          ),
        ),
      );
    }
  }

  Future<void> _completeCollaboration(String collabId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Complete Collaboration?'),
        content: const Text(
          'Mark this collaboration as fully finished and completed. Both parties will be notified.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Complete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await ref
          .read(collaborationActionControllerProvider.notifier)
          .completeCollaboration(collaborationId: collabId);
      if (mounted && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Collaboration completed! 🏆')),
        );
      }
    }
  }
}
