import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/telemetry/analytics_service.dart';
import '../../auth/presentation/session_controller.dart';
import '../domain/account.dart';

final accountActionProvider =
    NotifierProvider<AccountController, AsyncValue<void>>(
      AccountController.new,
    );
final settingsProvider = FutureProvider<AccountSettings>(
  (ref) => ref.watch(accountRepositoryProvider).settings(),
);

class AccountController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);
  Future<void> _run(Future<void> Function() action) async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    try {
      await action();
      if (ref.mounted) state = const AsyncData(null);
    } catch (error, stack) {
      if (ref.mounted) state = AsyncError(mapFailure(error), stack);
    }
  }

  Future<void> onboard(String name, ProfessionalRole? role) => _run(() async {
    if (role == null) throw AppFailure(FailureKind.validation);
    await ref.read(accountRepositoryProvider).completeOnboarding(role, name);
    await ref.read(analyticsProvider).event(AnalyticsEvent.onboardingCompleted);
    await ref.read(sessionProvider.notifier).refresh();
  });
  Future<void> saveName(String name) => _run(() async {
    await ref.read(accountRepositoryProvider).updateName(name);
    await ref.read(sessionProvider.notifier).refresh();
  });
  Future<void> saveSettings(AccountSettings settings) => _run(() async {
    await ref.read(accountRepositoryProvider).updateSettings(settings);
    ref.invalidate(settingsProvider);
  });
  Future<void> deleteRequest() => _run(() async {
    await ref.read(accountRepositoryProvider).requestDeletion();
    await ref.read(sessionProvider.notifier).refresh();
  });
  Future<void> logout() =>
      _run(() => ref.read(sessionProvider.notifier).logout());
}
