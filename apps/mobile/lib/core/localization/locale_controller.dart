import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Supported application locales
enum AppSupportedLocale {
  english(Locale('en'), 'English', 'English'),
  hindi(Locale('hi'), 'Hindi', 'हिंदी'),
  marathi(Locale('mr'), 'Marathi', 'मराठी');

  const AppSupportedLocale(this.locale, this.englishName, this.nativeName);
  final Locale locale;
  final String englishName;
  final String nativeName;

  static AppSupportedLocale fromCode(String? code) {
    return switch (code) {
      'hi' => AppSupportedLocale.hindi,
      'mr' => AppSupportedLocale.marathi,
      _ => AppSupportedLocale.english,
    };
  }
}

/// Secure storage key for persisting app language
const String _kLanguageStorageKey = 'ggs_app_selected_locale';

/// Service for loading and saving the user's interface language
class LocaleService {
  LocaleService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<Locale> loadSavedLocale() async {
    try {
      final code = await _storage.read(key: _kLanguageStorageKey);
      return AppSupportedLocale.fromCode(code).locale;
    } catch (_) {
      return const Locale('en');
    }
  }

  Future<void> saveLocale(Locale locale) async {
    try {
      await _storage.write(
        key: _kLanguageStorageKey,
        value: locale.languageCode,
      );
    } catch (_) {
      // In-memory fallback if secure storage is unavailable
    }
  }
}

/// Provider for the locale persistence service
final localeServiceProvider = Provider<LocaleService>((ref) {
  return LocaleService();
});

/// Riverpod 3.x Notifier controlling the active application locale
class LocaleController extends Notifier<Locale> {
  @override
  Locale build() {
    _init();
    return const Locale('en');
  }

  Future<void> _init() async {
    final service = ref.read(localeServiceProvider);
    final saved = await service.loadSavedLocale();
    state = saved;
  }

  Future<void> setLocale(Locale newLocale) async {
    if (state == newLocale) return;
    state = newLocale;
    final service = ref.read(localeServiceProvider);
    await service.saveLocale(newLocale);
  }

  Future<void> setByLanguageCode(String code) async {
    final appLocale = AppSupportedLocale.fromCode(code);
    await setLocale(appLocale.locale);
  }
}

/// Active application locale provider
final activeLocaleProvider =
    NotifierProvider<LocaleController, Locale>(LocaleController.new);
