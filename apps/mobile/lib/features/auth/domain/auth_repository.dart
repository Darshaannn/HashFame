enum SocialProvider { google, apple }

enum SessionEvent { signedIn, signedOut, refreshed, invalid }

abstract interface class AuthRepository {
  String? get userId;
  Stream<SessionEvent> get events;
  Future<void> restore();
  Future<void> sendOtp(String email);
  Future<void> verifyOtp(String email, String code);
  Future<void> sendPhoneOtp(String phone);
  Future<void> verifyPhoneOtp(String phone, String code);
  Future<void> signInSocial(SocialProvider provider);
  Future<void> logout();
}
