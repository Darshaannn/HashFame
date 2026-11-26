import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/demo/demo_repositories.dart';
import 'package:ggs_mobile/demo/demo_store.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/account/domain/account_repository.dart';
import 'package:ggs_mobile/features/auth/domain/auth_repository.dart';
import 'package:ggs_mobile/features/brand/presentation/widgets/brand_home_header.dart';
import 'package:ggs_mobile/features/profile_common/presentation/widgets/account_switcher_menu.dart';

class _FakeRealAuthRepository implements AuthRepository {
  _FakeRealAuthRepository(this._userId);
  final String? _userId;

  @override
  Stream<SessionEvent> get events => const Stream.empty();

  @override
  Future<void> logout() async {}

  @override
  Future<void> restore() async {}

  @override
  Future<void> sendOtp(String email) async {}

  @override
  Future<void> verifyOtp(String email, String code) async {}

  @override
  Future<void> sendPhoneOtp(String phone) async {}

  @override
  Future<void> verifyPhoneOtp(String phone, String code) async {}

  @override
  Future<void> signInSocial(SocialProvider provider) async {}

  @override
  String? get userId => _userId;
}

class _FakeAccountRepository implements AccountRepository {
  _FakeAccountRepository(this._role);
  final ProfessionalRole _role;

  Account _buildAccount() => Account(
    id: 'real_user_1',
    displayName: 'Real User',
    accountState: AccountState.active,
    primaryRoleLabel: _role,
    updatedAt: DateTime(2026, 11, 26),
  );

  @override
  Future<void> clearCache() async {}

  @override
  Future<Account> completeOnboarding(
    ProfessionalRole role,
    String name,
  ) async => _buildAccount();

  @override
  Future<AccountSnapshot> load() async {
    return AccountSnapshot(
      _buildAccount(),
      offline: false,
      fetchedAt: DateTime(2026, 11, 26),
    );
  }

  @override
  Future<String> requestDeletion() async => 'req_1';

  @override
  Future<AccountSettings> settings() async => const AccountSettings(
    locale: 'en',
    notificationPreferences: NotificationPreferences(productUpdates: true),
  );

  @override
  Future<Account> updateName(String name) async => _buildAccount();

  @override
  Future<void> updateSettings(AccountSettings settings) async {}
}

void main() {
  setUp(() {
    DemoStore.instance.reset();
    DemoStore.instance.currentRole = ProfessionalRole.brandMarketer;
  });

  testWidgets('Demo Mode shows Demo Account Switcher on BrandHomeHeader', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            DemoAuthRepository(DemoStore.instance),
          ),
          accountRepositoryProvider.overrideWithValue(
            DemoAccountRepository(DemoStore.instance),
          ),
        ],
        child: const MaterialApp(home: Scaffold(body: BrandHomeHeader())),
      ),
    );
    await tester.pumpAndSettle();

    // Top-right account button is present on Brand Home
    final btn = find.byKey(const Key('gg_account_switcher_button'));
    expect(btn, findsOneWidget);

    await tester.tap(btn);
    await tester.pumpAndSettle();

    expect(find.text('Demo Account Switcher'), findsOneWidget);
    expect(find.text('Brand Demo'), findsOneWidget);
    expect(find.text('Creator Demo'), findsOneWidget);
    expect(find.text('Agency Demo'), findsOneWidget);
    expect(find.text('Admin Dashboard'), findsNothing);
    expect(find.text('Switch Account'), findsNothing);
  });

  testWidgets(
    'Real non-admin user sees Switch Account and no Admin Dashboard',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(
              _FakeRealAuthRepository('real_user_1'),
            ),
            accountRepositoryProvider.overrideWithValue(
              _FakeAccountRepository(ProfessionalRole.brandMarketer),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => GGAccountSwitcherMenu.show(context),
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Switch Account'), findsOneWidget);
      expect(find.text('Demo Account Switcher'), findsNothing);
      expect(find.text('Admin Dashboard'), findsNothing);
    },
  );

  testWidgets('Server-authorized admin user sees Admin Dashboard', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            _FakeRealAuthRepository('real_user_1'),
          ),
          accountRepositoryProvider.overrideWithValue(
            _FakeAccountRepository(ProfessionalRole.admin),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => GGAccountSwitcherMenu.show(context),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Admin Dashboard'), findsOneWidget);
    expect(find.text('Switch Account'), findsOneWidget);
    expect(find.text('Demo Account Switcher'), findsNothing);
  });
}
