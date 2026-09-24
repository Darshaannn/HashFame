import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/app_config.dart';
import '../core/telemetry/analytics_service.dart';
import '../features/account/domain/account_repository.dart';
import '../features/agency/domain/agency_repository.dart';
import '../features/auth/domain/auth_repository.dart';
import '../features/brand/domain/brand_repository.dart';
import '../features/creator/domain/creator_repository.dart';
import '../features/discovery/domain/discovery_repository.dart';
import '../features/profile_common/domain/reference_data_repository.dart';
import '../features/shortlist/domain/shortlist_repository.dart';
import '../features/talent_manager/domain/talent_manager_repository.dart';

final configProvider = Provider<AppConfig>(
  (ref) => throw StateError('Bootstrap must supply configuration'),
);
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => throw StateError('Bootstrap must supply auth repository'),
);
final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => throw StateError('Bootstrap must supply account repository'),
);
final referenceDataRepositoryProvider = Provider<ReferenceDataRepository>(
  (ref) => throw StateError('Bootstrap must supply reference data repository'),
);
final creatorRepositoryProvider = Provider<CreatorRepository>(
  (ref) => throw StateError('Bootstrap must supply creator repository'),
);
final brandRepositoryProvider = Provider<BrandRepository>(
  (ref) => throw StateError('Bootstrap must supply brand repository'),
);
final agencyRepositoryProvider = Provider<AgencyRepository>(
  (ref) => throw StateError('Bootstrap must supply agency repository'),
);
final talentManagerRepositoryProvider = Provider<TalentManagerRepository>(
  (ref) => throw StateError('Bootstrap must supply talent manager repository'),
);
final discoveryRepositoryProvider = Provider<DiscoveryRepository>(
  (ref) => throw StateError('Bootstrap must supply discovery repository'),
);
final shortlistRepositoryProvider = Provider<ShortlistRepository>(
  (ref) => throw StateError('Bootstrap must supply shortlist repository'),
);
final analyticsProvider = Provider<AnalyticsService>(
  (ref) => const NoopAnalyticsService(),
);

