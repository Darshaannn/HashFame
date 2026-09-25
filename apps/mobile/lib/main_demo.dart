import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/providers.dart';
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

class DemoAppRoot extends StatefulWidget {
  const DemoAppRoot({super.key});

  @override
  State<DemoAppRoot> createState() => _DemoAppRootState();
}

class _DemoAppRootState extends State<DemoAppRoot> {
  bool _roleSelected = false;

  @override
  Widget build(BuildContext context) {
    if (!_roleSelected) {
      return MaterialApp(
        title: 'GGs Demo Launcher',
        theme: buildAppTheme(),
        debugShowCheckedModeBanner: false,
        home: DemoLauncherScreen(
          onRoleSelected: () {
            setState(() {
              _roleSelected = true;
            });
          },
        ),
      );
    }

    return Column(
      children: [
        const Material(child: DemoTopBanner()),
        const Expanded(child: FoundationApp()),
      ],
    );
  }
}
