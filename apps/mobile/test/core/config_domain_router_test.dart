import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/router.dart';
import 'package:ggs_mobile/core/config/app_config.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';

Map<String, String> config({String environment = 'local'}) => {
  'APP_ENV': environment,
  'APP_NAME': 'GGs Test',
  'SUPABASE_URL': environment == 'local'
      ? 'http://127.0.0.1:54321'
      : 'https://project.supabase.co',
  'SUPABASE_PUBLISHABLE_KEY': 'sb_publishable_example',
  'AUTH_REDIRECT_URL': 'com.ggs.mobile.$environment://auth/callback',
  'SUPPORT_URL': 'https://support.example.com/help',
  'FIREBASE_ENABLED': 'false',
};

AccountSnapshot snapshot({
  ProfessionalRole role = ProfessionalRole.creator,
  bool offline = false,
}) => AccountSnapshot(
  Account(
    id: 'user-a',
    displayName: 'Creator A',
    primaryRoleLabel: role,
    accountState: AccountState.active,
    updatedAt: DateTime.utc(2026),
  ),
  fetchedAt: DateTime.utc(2026),
  offline: offline,
);

void main() {
  group('configuration', () {
    test('accepts an explicit local public configuration', () {
      final parsed = AppConfig.parse(config());
      expect(parsed.environment, AppEnvironment.local);
      expect(parsed.firebaseEnabled, isFalse);
    });

    test('requires HTTPS outside local development', () {
      final values = config(environment: 'production')
        ..['SUPABASE_URL'] = 'http://project.supabase.co';
      expect(() => AppConfig.parse(values), throwsFormatException);
    });

    test('rejects privileged JWTs and malformed telemetry flags', () {
      final privileged = config()
        ..['SUPABASE_PUBLISHABLE_KEY'] =
            'e30.eyJyb2xlIjoic2VydmljZV9yb2xlIn0.signature';
      expect(() => AppConfig.parse(privileged), throwsFormatException);

      final malformedFlag = config()..['FIREBASE_ENABLED'] = 'yes';
      expect(() => AppConfig.parse(malformedFlag), throwsFormatException);
    });

    test('requires an environment-matched callback', () {
      final values = config()
        ..['AUTH_REDIRECT_URL'] = 'com.ggs.mobile.production://auth/callback';
      expect(() => AppConfig.parse(values), throwsFormatException);
    });
  });

  group('domain rules', () {
    test('admin can never self-register', () {
      expect(ProfessionalRole.admin.canSelfRegister, isFalse);
      expect(
        ProfessionalRole.values.where((role) => role.canSelfRegister),
        hasLength(4),
      );
    });

    test('validates names, email addresses and one-time codes', () {
      expect(validateName('A'), isNotNull);
      expect(validateName('Valid Name'), isNull);
      expect(validateEmail('person@example.com'), isNull);
      expect(validateEmail('not-an-email'), isNotNull);
      expect(validatePhone('+919876543210'), isNull);
      expect(validatePhone('9876543210'), isNotNull);
      expect(validateOtp('123456'), isNull);
      expect(validateOtp('12345a'), isNotNull);
    });
  });

  group('route authorization', () {
    test('keeps unauthenticated users out of private routes', () {
      expect(
        routeRedirect(
          const SessionState(SessionPhase.unauthenticated),
          '/settings',
        ),
        '/welcome',
      );
      expect(
        routeRedirect(
          const SessionState(SessionPhase.unauthenticated),
          '/auth',
          selectedRole: ProfessionalRole.creator,
        ),
        isNull,
      );
    });

    test('forces incomplete and restricted accounts to safe destinations', () {
      expect(
        routeRedirect(
          const SessionState(SessionPhase.onboarding),
          '/home/creator',
        ),
        '/onboarding',
      );
      expect(
        routeRedirect(const SessionState(SessionPhase.restricted), '/settings'),
        '/status',
      );
    });

    test('prevents cross-role navigation and offline mutations', () {
      final ready = SessionState(SessionPhase.ready, snapshot: snapshot());
      expect(routeRedirect(ready, '/home/admin'), '/home/creator');
      expect(routeRedirect(ready, '/settings'), isNull);
      expect(routeRedirect(ready, '/profile'), isNull);

      final offline = SessionState(
        SessionPhase.ready,
        snapshot: snapshot(offline: true),
      );
      expect(routeRedirect(offline, '/settings'), '/home/creator');
      expect(routeRedirect(offline, '/profile'), isNull);
    });

    test('uses the startup route while session recovery is pending', () {
      expect(
        routeRedirect(const SessionState(SessionPhase.loading), '/welcome'),
        '/startup',
      );
      expect(
        routeRedirect(const SessionState(SessionPhase.loading), '/startup'),
        isNull,
      );
    });

    test('keeps the gallery disabled in production', () {
      final ready = SessionState(SessionPhase.ready, snapshot: snapshot());
      expect(routeRedirect(ready, '/gallery'), '/home/creator');
      expect(routeRedirect(ready, '/gallery', galleryAllowed: true), isNull);
    });
  });
}
