import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/telemetry/analytics_service.dart';
import '../../account/domain/account.dart';
import '../domain/auth_repository.dart';

enum SessionPhase {
  loading,
  unauthenticated,
  onboarding,
  ready,
  restricted,
  error,
}

class SessionState {
  const SessionState(this.phase, {this.snapshot, this.failure});
  final SessionPhase phase;
  final AccountSnapshot? snapshot;
  final AppFailure? failure;
}

final sessionProvider = NotifierProvider<SessionController, SessionState>(
  SessionController.new,
);
final selectedRoleProvider = NotifierProvider<SelectedRole, ProfessionalRole?>(
  SelectedRole.new,
);

class SelectedRole extends Notifier<ProfessionalRole?> {
  @override
  ProfessionalRole? build() => null;
  void choose(ProfessionalRole role) {
    if (!role.canSelfRegister) throw AppFailure(FailureKind.authorization);
    state = role;
    unawaited(ref.read(analyticsProvider).event(AnalyticsEvent.roleSelected));
  }

  void clear() => state = null;
}

class SessionController extends Notifier<SessionState> {
  int _generation = 0;
  Future<void>? _pending;
  @override
  SessionState build() {
    final auth = ref.read(authRepositoryProvider);
    final subscription = auth.events.listen(
      (event) {
        if (event == SessionEvent.signedOut || event == SessionEvent.invalid) {
          unawaited(
            _signedOut(
              event == SessionEvent.invalid
                  ? AppFailure(FailureKind.authentication)
                  : null,
            ),
          );
        } else {
          unawaited(refresh());
        }
      },
      onError: (Object error, StackTrace stack) {
        unawaited(_signedOut(mapFailure(error)));
      },
    );
    ref.onDispose(subscription.cancel);
    Future.microtask(_restore);
    return const SessionState(SessionPhase.loading);
  }

  Future<void> _restore() async {
    try {
      await ref.read(authRepositoryProvider).restore();
      await refresh();
    } catch (error) {
      if (ref.mounted) await _signedOut(mapFailure(error));
    }
  }

  Future<void> _signedOut(AppFailure? failure) async {
    _generation++;
    state = SessionState(SessionPhase.unauthenticated, failure: failure);
    await ref.read(accountRepositoryProvider).clearCache();
  }

  Future<void> refresh() =>
      _pending ??= _refresh().whenComplete(() => _pending = null);
  Future<void> _refresh() async {
    final auth = ref.read(authRepositoryProvider);
    if (auth.userId == null) {
      await _signedOut(null);
      return;
    }
    final generation = _generation;
    try {
      final snapshot = await ref
          .read(analyticsProvider)
          .trace('account_load', ref.read(accountRepositoryProvider).load);
      if (!ref.mounted || generation != _generation) return;
      final account = snapshot.account;
      state = SessionState(switch (account.accountState) {
        AccountState.onboarding => SessionPhase.onboarding,
        AccountState.active =>
          account.canEnterHome ? SessionPhase.ready : SessionPhase.error,
        _ => SessionPhase.restricted,
      }, snapshot: snapshot);
    } catch (error) {
      if (!ref.mounted || generation != _generation) return;
      final failure = mapFailure(error);
      if (failure.kind == FailureKind.authentication) {
        try {
          await auth.logout();
        } finally {
          await _signedOut(failure);
        }
      } else {
        state = SessionState(SessionPhase.error, failure: failure);
        await ref.read(analyticsProvider).failure(failure);
      }
    }
  }

  Future<void> logout() async {
    _generation++;
    AppFailure? failure;
    try {
      await ref.read(authRepositoryProvider).logout();
    } catch (error) {
      failure = mapFailure(error);
    }
    await ref.read(accountRepositoryProvider).clearCache();
    ref.read(selectedRoleProvider.notifier).clear();
    if (ref.mounted) {
      state = SessionState(SessionPhase.unauthenticated, failure: failure);
    }
    await ref.read(analyticsProvider).event(AnalyticsEvent.logout);
    if (failure != null) throw failure;
  }
}
