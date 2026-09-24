import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/app_failure.dart';
import '../domain/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this.client, this.redirectUrl);
  final SupabaseClient client;
  final String redirectUrl;
  @override
  String? get userId => client.auth.currentUser?.id;
  @override
  Stream<SessionEvent> get events => client.auth.onAuthStateChange.map(
    (state) => switch (state.event) {
      AuthChangeEvent.signedOut => SessionEvent.signedOut,
      AuthChangeEvent.tokenRefreshed => SessionEvent.refreshed,
      _ =>
        state.session != null ? SessionEvent.signedIn : SessionEvent.signedOut,
    },
  );
  Future<void> _run(Future<void> Function() action) async {
    try {
      await action().timeout(const Duration(seconds: 15));
    } catch (error) {
      throw mapFailure(error);
    }
  }

  @override
  Future<void> restore() => _run(() async {
    final session = client.auth.currentSession;
    if (session == null) return;
    if (session.isExpired) {
      // Exactly one refresh, no redirect/restart retry loop.
      try {
        await client.auth.refreshSession();
      } on AuthException {
        await client.auth.signOut(scope: SignOutScope.local);
        rethrow;
      }
    }
  });
  @override
  Future<void> sendOtp(String email) => _run(
    () => client.auth.signInWithOtp(
      email: email.trim(),
      emailRedirectTo: redirectUrl,
    ),
  );
  @override
  Future<void> verifyOtp(String email, String code) => _run(() async {
    await client.auth.verifyOTP(
      email: email.trim(),
      token: code.trim(),
      type: OtpType.email,
    );
  });
  @override
  Future<void> sendPhoneOtp(String phone) =>
      _run(() => client.auth.signInWithOtp(phone: phone.trim()));
  @override
  Future<void> verifyPhoneOtp(String phone, String code) => _run(() async {
    await client.auth.verifyOTP(
      phone: phone.trim(),
      token: code.trim(),
      type: OtpType.sms,
    );
  });
  @override
  Future<void> signInSocial(SocialProvider provider) => _run(() async {
    final opened = await client.auth.signInWithOAuth(
      provider == SocialProvider.google
          ? OAuthProvider.google
          : OAuthProvider.apple,
      redirectTo: redirectUrl,
    );
    if (!opened) throw AppFailure(FailureKind.server);
  });
  @override
  Future<void> logout() =>
      _run(() => client.auth.signOut(scope: SignOutScope.local));
}
