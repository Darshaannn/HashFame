import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/design_system/tokens.dart';
import '../core/localization/locale_controller.dart';
import '../l10n/app_localizations.dart';
import 'navigation_history.dart';
import 'providers.dart';
import 'router.dart';

class FoundationApp extends ConsumerWidget {
  const FoundationApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeLocale = ref.watch(activeLocaleProvider);

    return MaterialApp.router(
      title: ref.watch(configProvider).name,
      theme: buildAppTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) => RootNavigationGuard(
        child: child ?? const SizedBox.shrink(),
      ),
      locale: activeLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

