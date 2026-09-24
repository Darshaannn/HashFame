import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/telemetry/analytics_service.dart';
import '../../account/domain/account.dart';
import '../domain/auth_repository.dart';
import 'session_controller.dart';

class AuthFormState {
  const AuthFormState({this.busy = false, this.codeSent = false, this.failure});
  final bool busy;
  final bool codeSent;
  final AppFailure? failure;
}

final authFormProvider = NotifierProvider<AuthController, AuthFormState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthFormState> {
  @override
  AuthFormState build() => const AuthFormState();
  Future<void> _run(Future<void> Function() action, {bool? codeSent}) async {
    if (state.busy) return;
    final sent = state.codeSent;
    state = AuthFormState(busy: true, codeSent: sent);
    try {
      if (ref.read(selectedRoleProvider) == null) {
        throw AppFailure(FailureKind.validation);
      }
      await action();
      if (ref.mounted) {
        state = AuthFormState(codeSent: codeSent ?? sent);
      }
    } catch (error) {
      if (ref.mounted) {
        state = AuthFormState(codeSent: sent, failure: mapFailure(error));
      }
    }
  }

  Future<void> sendOtp(String email) => _run(() async {
    if (validateEmail(email) != null) throw AppFailure(FailureKind.validation);
    await ref.read(analyticsProvider).event(AnalyticsEvent.authStarted);
    await ref.read(authRepositoryProvider).sendOtp(email);
  }, codeSent: true);
  Future<void> sendPhoneOtp(String phone) => _run(() async {
    if (validatePhone(phone) != null) throw AppFailure(FailureKind.validation);
    await ref.read(analyticsProvider).event(AnalyticsEvent.authStarted);
    await ref.read(authRepositoryProvider).sendPhoneOtp(phone);
  }, codeSent: true);
  Future<void> verify(String email, String otp) => _run(() async {
    if (validateEmail(email) != null || validateOtp(otp) != null) {
      throw AppFailure(FailureKind.validation);
    }
    await ref.read(authRepositoryProvider).verifyOtp(email, otp);
    await ref.read(analyticsProvider).event(AnalyticsEvent.authCompleted);
    await ref.read(sessionProvider.notifier).refresh();
  });
  Future<void> verifyPhone(String phone, String otp) => _run(() async {
    if (validatePhone(phone) != null || validateOtp(otp) != null) {
      throw AppFailure(FailureKind.validation);
    }
    await ref.read(authRepositoryProvider).verifyPhoneOtp(phone, otp);
    await ref.read(analyticsProvider).event(AnalyticsEvent.authCompleted);
    await ref.read(sessionProvider.notifier).refresh();
  });
  Future<void> social(SocialProvider provider) => _run(() async {
    await ref.read(analyticsProvider).event(AnalyticsEvent.authStarted);
    await ref.read(authRepositoryProvider).signInSocial(provider);
  });
  void reset() => state = const AuthFormState();
}
