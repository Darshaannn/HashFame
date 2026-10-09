import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../domain/active_collaboration.dart';

final collaborationDetailProvider = FutureProvider.autoDispose
    .family<ActiveCollaboration, String>((ref, collaborationId) async {
      final repo = ref.watch(collaborationRepositoryProvider);
      return repo.getCollaboration(collaborationId);
    });

final userCollaborationsProvider = FutureProvider.autoDispose
    .family<List<ActiveCollaboration>, String>((ref, userId) async {
      final repo = ref.watch(collaborationRepositoryProvider);
      return repo.listUserCollaborations(userId: userId);
    });

final organizationCollaborationsProvider = FutureProvider.autoDispose
    .family<List<ActiveCollaboration>, String>((ref, orgId) async {
      final repo = ref.watch(collaborationRepositoryProvider);
      return repo.listOrganizationCollaborations(organizationId: orgId);
    });

final collaborationMessagesProvider = FutureProvider.autoDispose
    .family<List<CollaborationMessage>, String>((ref, collaborationId) async {
      final repo = ref.watch(collaborationRepositoryProvider);
      return repo.getMessages(collaborationId);
    });

final collaborationActionControllerProvider =
    NotifierProvider<CollaborationActionController, AsyncValue<void>>(
      CollaborationActionController.new,
    );

class CollaborationActionController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> submitDeliverable({
    required String collaborationId,
    required String deliverableTitle,
    required String contentLink,
    String? creatorNotes,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(collaborationRepositoryProvider);
      await repo.submitDeliverable(
        collaborationId: collaborationId,
        deliverableTitle: deliverableTitle,
        contentLink: contentLink,
        creatorNotes: creatorNotes,
      );
      ref.invalidate(collaborationDetailProvider(collaborationId));
      ref.invalidate(activityRepositoryProvider);
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> reviewDeliverable({
    required String collaborationId,
    required String submissionId,
    required String action, // 'approve' or 'request_revision'
    String? feedback,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(collaborationRepositoryProvider);
      await repo.reviewDeliverable(
        submissionId: submissionId,
        action: action,
        feedback: feedback,
      );
      ref.invalidate(collaborationDetailProvider(collaborationId));
      ref.invalidate(activityRepositoryProvider);
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> completeCollaboration({
    required String collaborationId,
    String? notes,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(collaborationRepositoryProvider);
      await repo.completeCollaboration(
        collaborationId: collaborationId,
        notes: notes,
      );
      ref.invalidate(collaborationDetailProvider(collaborationId));
      ref.invalidate(activityRepositoryProvider);
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> sendMessage({
    required String collaborationId,
    required String senderId,
    required String senderName,
    required String content,
  }) async {
    try {
      final repo = ref.read(collaborationRepositoryProvider);
      await repo.sendMessage(
        collaborationId: collaborationId,
        senderId: senderId,
        senderName: senderName,
        content: content,
      );
      ref.invalidate(collaborationMessagesProvider(collaborationId));
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}
