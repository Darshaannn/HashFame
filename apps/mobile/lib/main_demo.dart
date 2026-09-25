import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/providers.dart';
import 'app/router.dart';
import 'core/config/app_config.dart';
import 'core/design_system/tokens.dart';
import 'core/telemetry/analytics_service.dart';
import 'demo/demo_banner.dart';
import 'demo/demo_launcher_screen.dart';
import 'demo/demo_repositories.dart';
import 'demo/demo_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final store = DemoStore.instance;

  const config = AppConfig(
    environment: AppEnvironment.local,
    name: 'GGs Demo',
    supabaseUrl: 'http://127.0.0.1:54321',
    publishableKey: 'sb_publishable_demo_mode',
    redirectUrl: 'com.ggs.mobile.local://auth/callback',
    supportUrl: 'https://support.hashfame.com',
  );

  final authRepo = DemoAuthRepository(store);
  final accountRepo = DemoAccountRepository(store);
  final refRepo = DemoReferenceDataRepository(store);
  final creatorRepo = DemoCreatorRepository(store);
  final brandRepo = DemoBrandRepository(store);
  final agencyRepo = DemoAgencyRepository(store);
  final tmRepo = DemoTalentManagerRepository(store);
  final discoveryRepo = DemoDiscoveryRepository(store);
  final shortlistRepo = DemoShortlistRepository(store);
  final campaignRepo = DemoCampaignRepository(store);

  runApp(
    ProviderScope(
      overrides: [
        configProvider.overrideWithValue(config),
        analyticsProvider.overrideWithValue(const NoopAnalyticsService()),
        authRepositoryProvider.overrideWithValue(authRepo),
        accountRepositoryProvider.overrideWithValue(accountRepo),
        referenceDataRepositoryProvider.overrideWithValue(refRepo),
        creatorRepositoryProvider.overrideWithValue(creatorRepo),
        brandRepositoryProvider.overrideWithValue(brandRepo),
        agencyRepositoryProvider.overrideWithValue(agencyRepo),
        talentManagerRepositoryProvider.overrideWithValue(tmRepo),
        discoveryRepositoryProvider.overrideWithValue(discoveryRepo),
        shortlistRepositoryProvider.overrideWithValue(shortlistRepo),
        campaignRepositoryProvider.overrideWithValue(campaignRepo),
      ],
      child: const DemoAppRoot(),
    ),
  );
}

class DemoAppRoot extends ConsumerStatefulWidget {
  const DemoAppRoot({super.key});

  @override
  ConsumerState<DemoAppRoot> createState() => _DemoAppRootState();
}

class _DemoAppRootState extends ConsumerState<DemoAppRoot> {
  bool _roleSelected = false;

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'GGs Demo',
      theme: buildAppTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        if (!_roleSelected) {
          return DemoLauncherScreen(
            onRoleSelected: () {
              setState(() {
                _roleSelected = true;
              });
              final role = DemoStore.instance.currentRole;
              router.go(homePath(role));
            },
          );
        }

        return Scaffold(
          body: Column(
            children: [
              const DemoTopBanner(),
              Expanded(
                child: child ?? const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}

