import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ggs_mobile/app/providers.dart';
import 'package:ggs_mobile/core/localization/locale_controller.dart';
import 'package:ggs_mobile/features/assistant/data/assistant_service_impl.dart';
import 'package:ggs_mobile/features/assistant/domain/assistant_service.dart';
import 'package:ggs_mobile/features/assistant/presentation/assistant_modal_sheet.dart';
import 'package:ggs_mobile/l10n/app_localizations.dart';

class _FakeLocaleService extends LocaleService {
  Locale current = const Locale('en');

  @override
  Future<Locale> loadSavedLocale() async => current;

  @override
  Future<void> saveLocale(Locale locale) async {
    current = locale;
  }
}

void main() {
  group('Multilingual & Localization Tests', () {
    test('LocaleService and AppSupportedLocale resolution', () {
      expect(AppSupportedLocale.fromCode('en'), AppSupportedLocale.english);
      expect(AppSupportedLocale.fromCode('hi'), AppSupportedLocale.hindi);
      expect(AppSupportedLocale.fromCode('mr'), AppSupportedLocale.marathi);
      expect(AppSupportedLocale.fromCode('unknown'), AppSupportedLocale.english);
    });

    testWidgets('Language switching updates MaterialApp locale', (tester) async {
      final fakeService = _FakeLocaleService();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            localeServiceProvider.overrideWithValue(fakeService),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              final locale = ref.watch(activeLocaleProvider);
              return MaterialApp(
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                home: Scaffold(
                  body: Builder(
                    builder: (innerCtx) {
                      final l10n = AppLocalizations.of(innerCtx);
                      return Column(
                        children: [
                          Text('KEY_TITLE:${l10n?.appTitle}'),
                          Text('KEY_LANG:${l10n?.language}'),
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(activeLocaleProvider.notifier)
                                  .setLocale(const Locale('hi'));
                            },
                            child: const Text('SWITCH_HI'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(activeLocaleProvider.notifier)
                                  .setLocale(const Locale('mr'));
                            },
                            child: const Text('SWITCH_MR'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check English defaults
      expect(find.text('KEY_TITLE:GGs Platform'), findsOneWidget);
      expect(find.text('KEY_LANG:Language'), findsOneWidget);

      // Switch to Hindi
      await tester.tap(find.text('SWITCH_HI'));
      await tester.pumpAndSettle();
      expect(find.text('KEY_TITLE:GGs प्लेटफॉर्म'), findsOneWidget);
      expect(find.text('KEY_LANG:भाषा'), findsOneWidget);
      expect(fakeService.current, const Locale('hi'));

      // Switch to Marathi
      await tester.tap(find.text('SWITCH_MR'));
      await tester.pumpAndSettle();
      expect(find.text('KEY_TITLE:GGs प्लॅटफॉर्म'), findsOneWidget);
      expect(find.text('KEY_LANG:भाषा'), findsOneWidget);
      expect(fakeService.current, const Locale('mr'));
    });
  });

  group('GGs AI Assistant Tests', () {
    test('DemoAssistantServiceImpl executes task with structured contextual fields', () async {
      const service = DemoAssistantServiceImpl();
      expect(service.isConfigured, isTrue);

      final response = await service.executeTask(
        const AssistantRequest(
          role: AssistantRole.brand,
          task: AssistantTask.draftBrief,
          contextData: {
            'title': 'Eco Bottle Launch',
            'objective': 'Sustainable Lifestyle Promotion',
          },
        ),
      );

      expect(response.success, isTrue);
      expect(response.suggestion, contains('Eco Bottle Launch'));
      expect(response.suggestion, contains('Sustainable Lifestyle Promotion'));
      expect(response.rationale, isNotNull);
      expect(response.fields['suggestedSlots'], 3);
    });

    test('DemoAssistantServiceImpl handles error simulation honestly', () async {
      const service = DemoAssistantServiceImpl(simulateError: true);
      final response = await service.executeTask(
        const AssistantRequest(
          role: AssistantRole.creator,
          task: AssistantTask.draftPitch,
          contextData: {'campaignTitle': 'Summer Glow'},
        ),
      );

      expect(response.success, isFalse);
      expect(response.errorMessage, contains('temporary service failure'));
    });

    testWidgets('AssistantModalSheet renders suggestion, accepts and rejects cleanly', (
      tester,
    ) async {
      AssistantResponse? accepted;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            assistantServiceProvider.overrideWithValue(const DemoAssistantServiceImpl()),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    AssistantModalSheet.show(
                      context: context,
                      role: AssistantRole.creator,
                      task: AssistantTask.draftPitch,
                      title: 'Draft Pitch Note',
                      contextData: {
                        'campaignTitle': 'Fitness Energy Drink',
                      },
                      onSuggestionAccepted: (resp) {
                        accepted = resp;
                      },
                    );
                  },
                  child: const Text('OPEN_AI_MODAL'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open Modal
      await tester.tap(find.text('OPEN_AI_MODAL'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Settle delayed async task
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(find.text('Draft Pitch Note'), findsOneWidget);
      expect(find.textContaining('Fitness Energy Drink'), findsOneWidget);
      expect(find.text('Accept & Apply Suggestion'), findsOneWidget);
      expect(find.text('Discard Suggestion'), findsOneWidget);

      // Tap Accept & Apply
      await tester.tap(find.text('Accept & Apply Suggestion'));
      await tester.pumpAndSettle();

      expect(accepted, isNotNull);
      expect(accepted?.suggestion, contains('Fitness Energy Drink'));
    });
  });
}
