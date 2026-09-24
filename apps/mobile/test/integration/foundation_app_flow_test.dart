import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/app/app.dart';
import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/config/app_config.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';

import '../support/fakes.dart';

const integrationConfig = AppConfig(
  environment: AppEnvironment.local,
  name: 'GGs Integration',
  supabaseUrl: 'http://127.0.0.1:54321',
  publishableKey: 'sb_publishable_example',
  redirectUrl: 'com.ggs.mobile.local://auth/callback',
  supportUrl: 'https://support.example.com',
);

void main() {
  testWidgets(
    'creator: role choice, OTP, multi-step onboarding, protected home, and logout',
    (tester) async {
      final auth = FakeAuth();
      final accounts = FakeAccounts()
        ..account = sampleAccount(role: null, state: AccountState.onboarding);
      final creatorRepo = FakeCreatorRepository();
      final refData = FakeReferenceDataRepository();
      final brandRepo = FakeBrandRepository();
      final agencyRepo = FakeAgencyRepository();
      final tmRepo = FakeTalentManagerRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            configProvider.overrideWithValue(integrationConfig),
            authRepositoryProvider.overrideWithValue(auth),
            accountRepositoryProvider.overrideWithValue(accounts),
            creatorRepositoryProvider.overrideWithValue(creatorRepo),
            referenceDataRepositoryProvider.overrideWithValue(refData),
            brandRepositoryProvider.overrideWithValue(brandRepo),
            agencyRepositoryProvider.overrideWithValue(agencyRepo),
            talentManagerRepositoryProvider.overrideWithValue(tmRepo),
          ],
          child: const FoundationApp(),
        ),
      );
      await tester.pumpAndSettle();

      // ── Welcome Screen ─────────────────────────────────────────────────────
      expect(find.text('Your professional story starts here.'), findsOneWidget);
      await tester.tap(find.text('Get started or sign in'));
      await tester.pumpAndSettle();

      // ── Role Selection ─────────────────────────────────────────────────────
      await tester.tap(find.text('Creator'));
      await tester.pumpAndSettle();

      // ── Email OTP Auth ─────────────────────────────────────────────────────
      await tester.enterText(
        find.byType(TextFormField).first,
        'person@example.com',
      );
      await tester.tap(find.text('Send sign-in code'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).last, '123456');
      await tester.tap(find.text('Verify code'));
      await tester.pumpAndSettle();

      // ── Creator Onboarding — 8 steps ───────────────────────────────────────
      // Step 1: Basic Identity — enter display name and continue
      expect(find.textContaining('Creator Setup'), findsOneWidget);
      expect(find.text('Basic Identity'), findsOneWidget);

      final nameField = find.widgetWithText(TextFormField, 'Display Name (Required)');
      await tester.enterText(nameField, 'New Creator');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Steps 2–7: Tap Continue through all remaining optional steps
      for (int i = 2; i <= 7; i++) {
        // Allow async providers (categories, languages) to settle
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pumpAndSettle();

        final continueButton = find.text('Continue');
        if (continueButton.evaluate().isNotEmpty) {
          await tester.tap(continueButton);
          await tester.pumpAndSettle();
        }
      }

      // Step 8: Review & Launch — tap Complete Setup
      await tester.pumpAndSettle();
      expect(find.text('Review & Launch'), findsOneWidget);

      await tester.tap(find.text('Complete Setup'));
      await tester.pumpAndSettle();

      // ── Creator Home ───────────────────────────────────────────────────────
      expect(find.text('Creator Home'), findsOneWidget);
      expect(find.text('Welcome, New Creator'), findsOneWidget);

      // ── Logout ─────────────────────────────────────────────────────────────
      final signOutButton = find.text('Sign Out');
      await tester.scrollUntilVisible(signOutButton, 50);
      await tester.ensureVisible(signOutButton);
      await tester.pumpAndSettle();
      await tester.tap(signOutButton);
      await tester.pumpAndSettle();

      expect(find.text('Your professional story starts here.'), findsOneWidget);
      expect(accounts.cleared, greaterThanOrEqualTo(1));
    },
  );
}
