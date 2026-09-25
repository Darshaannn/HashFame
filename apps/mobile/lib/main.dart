import 'dart:async';
import 'dart:developer' as developer;
import 'dart:ui';

import 'package:drift_flutter/drift_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/config/app_config.dart';
import 'core/design_system/components.dart';
import 'core/design_system/tokens.dart';
import 'core/errors/app_failure.dart';
import 'core/storage/app_database.dart';
import 'core/storage/secure_session_storage.dart';
import 'core/telemetry/analytics_service.dart';
import 'features/account/data/account_data_source.dart';
import 'features/account/data/account_repository_impl.dart';
import 'features/agency/data/agency_repository_impl.dart';
import 'features/auth/data/supabase_auth_repository.dart';
import 'features/brand/data/brand_repository_impl.dart';
import 'features/campaign/data/campaign_repository_impl.dart';
import 'features/creator/data/creator_repository_impl.dart';
import 'features/discovery/data/discovery_repository_impl.dart';
import 'features/profile_common/data/reference_data_repository_impl.dart';
import 'features/shortlist/data/shortlist_repository_impl.dart';
import 'features/talent_manager/data/talent_manager_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final config = AppConfig.fromEnvironment();
    const secure = FlutterSecureStorage();
    final namespace = 'foundation.${config.environment.name}';
    await Supabase.initialize(
      url: config.supabaseUrl,
      publishableKey: config.publishableKey,
      debug: false,
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        localStorage: SecureSessionStorage(secure, namespace),
        pkceAsyncStorage: SecurePkceStorage(secure, namespace),
      ),
    );
    final db = AppDatabase(
      driftDatabase(name: 'foundation_${config.environment.name}'),
    );
    final telemetry = await initializeTelemetry(config);
    FlutterError.onError = (details) {
      unawaited(telemetry.failure(mapFailure(details.exception), fatal: true));
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      unawaited(telemetry.failure(mapFailure(error), fatal: true));
      return true;
    };
    ErrorWidget.builder = (_) {
      unawaited(telemetry.event(AnalyticsEvent.fatalErrorScreen));
      return const Material(
        child: SafeArea(
          child: AppErrorState(
            message:
                'This screen could not be displayed. Please reopen the app.',
          ),
        ),
      );
    };
    await telemetry.event(AnalyticsEvent.appOpen);
    runApp(
      ProviderScope(
        overrides: [
          configProvider.overrideWithValue(config),
          analyticsProvider.overrideWithValue(telemetry),
          authRepositoryProvider.overrideWithValue(
            SupabaseAuthRepository(
              Supabase.instance.client,
              config.redirectUrl,
            ),
          ),
          accountRepositoryProvider.overrideWithValue(
            AccountRepositoryImpl(
              SupabaseAccountDataSource(Supabase.instance.client),
              db,
            ),
          ),
          referenceDataRepositoryProvider.overrideWithValue(
            ReferenceDataRepositoryImpl(
              SupabaseReferenceDataSource(Supabase.instance.client),
            ),
          ),
          creatorRepositoryProvider.overrideWithValue(
            CreatorRepositoryImpl(
              SupabaseCreatorDataSource(Supabase.instance.client),
            ),
          ),
          brandRepositoryProvider.overrideWithValue(
            BrandRepositoryImpl(
              SupabaseBrandDataSource(Supabase.instance.client),
            ),
          ),
          agencyRepositoryProvider.overrideWithValue(
            AgencyRepositoryImpl(
              SupabaseAgencyDataSource(Supabase.instance.client),
            ),
          ),
          talentManagerRepositoryProvider.overrideWithValue(
            TalentManagerRepositoryImpl(
              SupabaseTalentManagerDataSource(Supabase.instance.client),
            ),
          ),
          discoveryRepositoryProvider.overrideWithValue(
            DiscoveryRepositoryImpl(
              SupabaseDiscoveryDataSource(Supabase.instance.client),
            ),
          ),
          shortlistRepositoryProvider.overrideWithValue(
            ShortlistRepositoryImpl(
              SupabaseShortlistDataSource(Supabase.instance.client),
            ),
          ),
          campaignRepositoryProvider.overrideWithValue(
            CampaignRepositoryImpl(
              SupabaseCampaignDataSource(Supabase.instance.client),
            ),
          ),
        ],
        child: const FoundationApp(),
      ),
    );
  } catch (error) {
    developer.log(
      'bootstrap_failed:${mapFailure(error).kind.name}',
      name: 'foundation',
    );
    runApp(
      MaterialApp(
        theme: buildAppTheme(),
        home: const AppScaffold(
          title: 'Configuration required',
          children: [
            AppErrorState(
              message: 'The app could not initialize. Check the environment configuration and connectivity, then reopen the app.',
            ),
          ],
        ),
      ),
    );
  }
}

Future<AnalyticsService> initializeTelemetry(AppConfig config) async {
  if (!config.firebaseEnabled) return const NoopAnalyticsService();
  try {
    const options = FirebaseOptions(
      apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
      appId: String.fromEnvironment('FIREBASE_APP_ID'),
      messagingSenderId: String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'),
      projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
      iosBundleId: String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID'),
    );
    if ([
      options.apiKey,
      options.appId,
      options.messagingSenderId,
      options.projectId,
    ].any((v) => v.isEmpty)) {
      throw const FormatException('Firebase public configuration missing');
    }
    await Firebase.initializeApp(options: options);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
    return SafeAnalyticsService(
      FirebaseAnalyticsService(
        FirebaseAnalytics.instance,
        FirebaseCrashlytics.instance,
        FirebasePerformance.instance,
      ),
    );
  } catch (error) {
    developer.log(
      'telemetry_initialization_failed:${mapFailure(error).kind.name}',
      name: 'foundation',
    );
    return const NoopAnalyticsService();
  }
}
