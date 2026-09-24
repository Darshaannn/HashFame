import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/config/app_config.dart';
import 'package:ggs_mobile/core/design_system/components.dart';
import 'package:ggs_mobile/core/design_system/gallery_screen.dart';
import 'package:ggs_mobile/core/design_system/tokens.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/account/presentation/account_screens.dart';
import 'package:ggs_mobile/features/auth/presentation/auth_screens.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';

import '../support/fakes.dart';

const testConfig = AppConfig(
  environment: AppEnvironment.local,
  name: 'GGs Test',
  supabaseUrl: 'http://127.0.0.1:54321',
  publishableKey: 'sb_publishable_example',
  redirectUrl: 'com.ggs.mobile.local://auth/callback',
  supportUrl: 'https://support.example.com',
);

ProviderContainer testContainer(FakeAuth auth, FakeAccounts accounts) =>
    ProviderContainer(
      overrides: [
        configProvider.overrideWithValue(testConfig),
        authRepositoryProvider.overrideWithValue(auth),
        accountRepositoryProvider.overrideWithValue(accounts),
      ],
    );

Widget host(ProviderContainer container, Widget child) =>
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: buildAppTheme(), home: child),
    );

void main() {
  test('core text colors meet WCAG AA normal-text contrast', () {
    double contrast(Color foreground, Color background) {
      final lighter =
          foreground.computeLuminance() > background.computeLuminance()
          ? foreground.computeLuminance()
          : background.computeLuminance();
      final darker =
          foreground.computeLuminance() > background.computeLuminance()
          ? background.computeLuminance()
          : foreground.computeLuminance();
      return (lighter + 0.05) / (darker + 0.05);
    }

    expect(
      contrast(AppColors.ink, AppColors.surface),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      contrast(AppColors.muted, AppColors.surface),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      contrast(Colors.white, AppColors.primary),
      greaterThanOrEqualTo(4.5),
    );
  });

  testWidgets('welcome and role choice expose all self-service roles', (
    tester,
  ) async {
    final container = testContainer(FakeAuth(), FakeAccounts());
    addTearDown(container.dispose);

    await tester.pumpWidget(host(container, const WelcomeScreen()));
    expect(find.text('Your professional story starts here.'), findsOneWidget);
    expect(find.text('Get started or sign in'), findsOneWidget);

    await tester.pumpWidget(host(container, const RoleSelectionScreen()));
    for (final role in ProfessionalRole.values.where(
      (role) => role.canSelfRegister,
    )) {
      expect(find.text(role.label), findsOneWidget);
    }
    expect(find.text(ProfessionalRole.admin.label), findsNothing);
  });

  testWidgets('email authentication validates and shows the OTP state', (
    tester,
  ) async {
    final auth = FakeAuth();
    final container = testContainer(auth, FakeAccounts());
    addTearDown(container.dispose);
    container
        .read(selectedRoleProvider.notifier)
        .choose(ProfessionalRole.creator);

    await tester.pumpWidget(host(container, const AuthScreen()));
    await tester.enterText(
      find.byType(TextFormField).first,
      'person@example.com',
    );
    await tester.tap(find.text('Send sign-in code'));
    await tester.pump();
    await tester.pump();

    expect(auth.otpCalls, 1);
    expect(
      find.text('Check your inbox. Codes expire after ten minutes.'),
      findsOneWidget,
    );
    expect(find.text('Verify code'), findsOneWidget);
  });

  testWidgets('phone OTP is not exposed as a launch sign-in dependency', (
    tester,
  ) async {
    final container = testContainer(FakeAuth(), FakeAccounts());
    addTearDown(container.dispose);
    container
        .read(selectedRoleProvider.notifier)
        .choose(ProfessionalRole.creator);

    await tester.pumpWidget(host(container, const AuthScreen()));

    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Phone'), findsNothing);
    expect(find.text('Phone number'), findsNothing);
  });

  testWidgets(
    'session loading and backend failure never render a blank screen',
    (tester) async {
      final gate = Completer<void>();
      final pendingAuth = FakeAuth()..restoreGate = gate;
      final loadingContainer = testContainer(pendingAuth, FakeAccounts());
      addTearDown(loadingContainer.dispose);
      await tester.pumpWidget(
        host(loadingContainer, const SessionStatusScreen()),
      );
      await tester.pump();
      expect(find.text('Opening your account'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      gate.complete();
      await tester.pump();

      final auth = FakeAuth()..id = sampleAccount().id;
      final accounts = FakeAccounts()
        ..failure = Exception('backend unavailable');
      final errorContainer = testContainer(auth, accounts);
      addTearDown(errorContainer.dispose);
      await tester.pumpWidget(
        host(errorContainer, const SessionStatusScreen()),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('Something went wrong'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    },
  );

  testWidgets('offline role home is explicit and disables settings', (
    tester,
  ) async {
    final auth = FakeAuth()..id = sampleAccount().id;
    final accounts = FakeAccounts()..offline = true;
    final container = testContainer(auth, accounts);
    addTearDown(container.dispose);

    container.read(sessionProvider);
    await tester.pumpWidget(
      host(container, const RoleHomeScreen(role: ProfessionalRole.creator)),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Offline • Last updated'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Account settings'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    final settings = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Account settings'),
    );
    expect(settings.onPressed, isNull);
  });

  testWidgets('foundational controls have semantics and minimum tap targets', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: Scaffold(
          body: Column(
            children: [
              const AppAvatar(label: 'Creator A'),
              AppButton(label: 'Continue', onPressed: () {}),
              const AppLoader(label: 'Loading account'),
            ],
          ),
        ),
      ),
    );

    expect(
      find.bySemanticsLabel('Profile avatar for Creator A'),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel('Loading account'), findsOneWidget);
    expect(
      tester.getSize(find.widgetWithText(FilledButton, 'Continue')).height,
      greaterThanOrEqualTo(48),
    );
    semantics.dispose();
  });

  testWidgets('component gallery remains usable at 200 percent text scale', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(2)),
          child: child!,
        ),
        home: const GalleryScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Foundation components'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
