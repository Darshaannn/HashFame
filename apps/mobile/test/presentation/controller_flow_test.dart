import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';
import 'package:ggs_mobile/features/account/presentation/account_controller.dart';
import 'package:ggs_mobile/features/auth/presentation/auth_controller.dart';
import 'package:ggs_mobile/features/auth/presentation/session_controller.dart';

import '../support/fakes.dart';

ProviderContainer containerFor(FakeAuth auth, FakeAccounts accounts) =>
    ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(auth),
        accountRepositoryProvider.overrideWithValue(accounts),
      ],
    );

Future<void> flushMicrotasks() async {
  for (var index = 0; index < 4; index++) {
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  test('invalid authentication input fails before a network call', () async {
    final auth = FakeAuth();
    final container = containerFor(auth, FakeAccounts());
    addTearDown(container.dispose);
    container
        .read(selectedRoleProvider.notifier)
        .choose(ProfessionalRole.creator);

    await container.read(authFormProvider.notifier).sendOtp('invalid');

    expect(auth.otpCalls, 0);
    expect(
      container.read(authFormProvider).failure?.kind,
      FailureKind.validation,
    );
  });

  test('phone OTP validates E.164 format before requesting SMS', () async {
    final auth = FakeAuth();
    final container = containerFor(auth, FakeAccounts());
    addTearDown(container.dispose);
    container
        .read(selectedRoleProvider.notifier)
        .choose(ProfessionalRole.creator);

    await container.read(authFormProvider.notifier).sendPhoneOtp('9876543210');
    expect(auth.phoneOtpCalls, 0);
    expect(
      container.read(authFormProvider).failure?.kind,
      FailureKind.validation,
    );

    await container
        .read(authFormProvider.notifier)
        .sendPhoneOtp('+919876543210');
    expect(auth.phoneOtpCalls, 1);
    expect(container.read(authFormProvider).codeSent, isTrue);
  });

  test('fresh signup, onboarding, session recovery and logout', () async {
    final auth = FakeAuth();
    final accounts = FakeAccounts()
      ..account = sampleAccount(role: null, state: AccountState.onboarding);
    final container = containerFor(auth, accounts);
    addTearDown(container.dispose);
    container
        .read(selectedRoleProvider.notifier)
        .choose(ProfessionalRole.creator);

    await container
        .read(authFormProvider.notifier)
        .verify('person@example.com', '123456');
    await flushMicrotasks();
    expect(container.read(sessionProvider).phase, SessionPhase.onboarding);

    await container
        .read(accountActionProvider.notifier)
        .onboard('New Creator', ProfessionalRole.creator);
    expect(container.read(sessionProvider).phase, SessionPhase.ready);
    expect(
      container.read(sessionProvider).snapshot?.account.displayName,
      'New Creator',
    );

    await container.read(sessionProvider.notifier).logout();
    expect(container.read(sessionProvider).phase, SessionPhase.unauthenticated);
    expect(accounts.cleared, greaterThanOrEqualTo(1));
    expect(container.read(selectedRoleProvider), isNull);
  });

  test(
    'returning authenticated account restores to its role home state',
    () async {
      final auth = FakeAuth()..id = sampleAccount().id;
      final container = containerFor(auth, FakeAccounts());
      addTearDown(container.dispose);

      container.read(sessionProvider);
      await flushMicrotasks();

      expect(container.read(sessionProvider).phase, SessionPhase.ready);
      expect(
        container.read(sessionProvider).snapshot?.account.primaryRoleLabel,
        ProfessionalRole.creator,
      );
    },
  );

  test('expired restore clears cache and returns to sign in', () async {
    final auth = FakeAuth()
      ..id = sampleAccount().id
      ..failure = AppFailure(FailureKind.authentication);
    final accounts = FakeAccounts();
    final container = containerFor(auth, accounts);
    addTearDown(container.dispose);

    container.read(sessionProvider);
    await flushMicrotasks();

    expect(container.read(sessionProvider).phase, SessionPhase.unauthenticated);
    expect(
      container.read(sessionProvider).failure?.kind,
      FailureKind.authentication,
    );
    expect(accounts.cleared, greaterThanOrEqualTo(1));
  });

  test(
    'logout failure still clears identity cache and selected role',
    () async {
      final auth = FakeAuth()
        ..id = sampleAccount().id
        ..failure = AppFailure(FailureKind.network);
      final accounts = FakeAccounts();
      final container = containerFor(auth, accounts);
      addTearDown(container.dispose);
      container
          .read(selectedRoleProvider.notifier)
          .choose(ProfessionalRole.creator);

      await expectLater(
        container.read(sessionProvider.notifier).logout(),
        throwsA(isA<AppFailure>()),
      );

      expect(accounts.cleared, greaterThanOrEqualTo(1));
      expect(container.read(selectedRoleProvider), isNull);
      expect(
        container.read(sessionProvider).phase,
        SessionPhase.unauthenticated,
      );
    },
  );

  test(
    'network loss during onboarding is visible and does not advance',
    () async {
      final auth = FakeAuth()..id = sampleAccount().id;
      final accounts = FakeAccounts()
        ..account = sampleAccount(role: null, state: AccountState.onboarding);
      final container = containerFor(auth, accounts);
      addTearDown(container.dispose);

      await container.read(sessionProvider.notifier).refresh();
      accounts.failure = AppFailure(FailureKind.network);
      await container
          .read(accountActionProvider.notifier)
          .onboard('New Creator', ProfessionalRole.creator);

      expect(container.read(accountActionProvider).hasError, isTrue);
      expect(container.read(sessionProvider).phase, SessionPhase.onboarding);
    },
  );

  test(
    'restore remains loading while secure session recovery is pending',
    () async {
      final gate = Completer<void>();
      final auth = FakeAuth()..restoreGate = gate;
      final container = containerFor(auth, FakeAccounts());
      addTearDown(container.dispose);

      expect(container.read(sessionProvider).phase, SessionPhase.loading);
      await flushMicrotasks();
      expect(container.read(sessionProvider).phase, SessionPhase.loading);

      gate.complete();
      await flushMicrotasks();
      expect(
        container.read(sessionProvider).phase,
        SessionPhase.unauthenticated,
      );
    },
  );
}
