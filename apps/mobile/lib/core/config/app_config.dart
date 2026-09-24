import 'dart:convert';

enum AppEnvironment { local, staging, production }

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.name,
    required this.supabaseUrl,
    required this.publishableKey,
    required this.redirectUrl,
    required this.supportUrl,
    this.firebaseEnabled = false,
  });

  final AppEnvironment environment;
  final String name;
  final String supabaseUrl;
  final String publishableKey;
  final String redirectUrl;
  final String supportUrl;
  final bool firebaseEnabled;

  factory AppConfig.fromEnvironment() => AppConfig.parse({
    'APP_ENV': const String.fromEnvironment('APP_ENV'),
    'APP_NAME': const String.fromEnvironment('APP_NAME'),
    'SUPABASE_URL': const String.fromEnvironment('SUPABASE_URL'),
    'SUPABASE_PUBLISHABLE_KEY': const String.fromEnvironment(
      'SUPABASE_PUBLISHABLE_KEY',
    ),
    'AUTH_REDIRECT_URL': const String.fromEnvironment('AUTH_REDIRECT_URL'),
    'SUPPORT_URL': const String.fromEnvironment('SUPPORT_URL'),
    'FIREBASE_ENABLED': const String.fromEnvironment(
      'FIREBASE_ENABLED',
      defaultValue: 'false',
    ),
  });

  factory AppConfig.parse(Map<String, String> values) {
    String required(String key) {
      final value = values[key]?.trim() ?? '';
      if (value.isEmpty) {
        throw FormatException('Missing public configuration: $key');
      }
      return value;
    }

    final env = AppEnvironment.values.byName(required('APP_ENV'));
    final url = Uri.parse(required('SUPABASE_URL'));
    if (!url.hasAuthority ||
        url.userInfo.isNotEmpty ||
        (url.scheme != 'https' &&
            !(env == AppEnvironment.local &&
                url.scheme == 'http' &&
                ['localhost', '127.0.0.1', '10.0.2.2'].contains(url.host)))) {
      throw const FormatException(
        'Supabase URL must use HTTPS outside local development',
      );
    }
    final key = required('SUPABASE_PUBLISHABLE_KEY');
    if (!RegExp(r'^sb_publishable_[A-Za-z0-9_-]+$').hasMatch(key)) {
      try {
        final payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(key.split('.')[1]))),
        ) as Map<String, dynamic>;
        if (payload['role'] != 'anon') {
          throw const FormatException('Only anonymous public keys allowed');
        }
      } catch (_) {
        throw const FormatException(
          'Only publishable or anonymous public keys allowed',
        );
      }
    }
    final redirect = required('AUTH_REDIRECT_URL');
    if (redirect != 'com.ggs.mobile.${env.name}://auth/callback') {
      throw const FormatException('Auth callback does not match environment');
    }
    final support = Uri.parse(required('SUPPORT_URL'));
    if (support.scheme != 'https' ||
        support.host.isEmpty ||
        support.userInfo.isNotEmpty) {
      throw const FormatException('Support URL must use HTTPS');
    }
    final firebaseValue = values['FIREBASE_ENABLED']?.trim() ?? 'false';
    if (firebaseValue != 'true' && firebaseValue != 'false') {
      throw const FormatException('FIREBASE_ENABLED must be true or false');
    }
    return AppConfig(
      environment: env,
      name: required('APP_NAME'),
      supabaseUrl: url.toString(),
      publishableKey: key,
      redirectUrl: redirect,
      supportUrl: support.toString(),
      firebaseEnabled: firebaseValue == 'true',
    );
  }
}
