import '../../../core/errors/app_failure.dart';
import '../../../core/storage/app_database.dart';
import '../domain/account.dart';
import '../domain/account_repository.dart';
import 'account_data_source.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this.remote, this.cache, {DateTime Function()? now})
    : now = now ?? DateTime.now;
  final AccountDataSource remote;
  final AppDatabase cache;
  final DateTime Function() now;
  static const maximumOfflineAge = Duration(hours: 24);
  Future<AccountSnapshot>? _pendingRead;
  int _generation = 0;

  @override
  Future<AccountSnapshot> load() =>
      _pendingRead ??= _load().whenComplete(() => _pendingRead = null);
  Future<AccountSnapshot> _load() async {
    final userId = remote.userId;
    if (userId == null) throw AppFailure(FailureKind.authentication);
    final generation = _generation;
    try {
      final account = await remote.load().timeout(const Duration(seconds: 12));
      if (remote.userId != userId ||
          generation != _generation ||
          account.id != userId) {
        throw AppFailure(FailureKind.authentication);
      }
      final fetched = now();
      if (account.canEnterHome) {
        await cache.writeSummary(account, fetched);
      } else {
        await cache.clear();
      }
      return AccountSnapshot(account, fetchedAt: fetched);
    } catch (error) {
      final failure = mapFailure(error);
      if (failure.permitsCache &&
          remote.userId == userId &&
          generation == _generation) {
        final cached = await cache.readSummary(userId);
        if (cached != null &&
            cached.account.canEnterHome &&
            now().difference(cached.fetchedAt) >= Duration.zero &&
            now().difference(cached.fetchedAt) <= maximumOfflineAge) {
          return cached;
        }
      }
      if (!failure.permitsCache) {
        await cache.clear();
      }
      throw failure;
    }
  }

  Future<T> _run<T>(Future<T> Function() action) async {
    try {
      return await action().timeout(const Duration(seconds: 12));
    } catch (error) {
      throw mapFailure(error);
    }
  }

  @override
  Future<Account> completeOnboarding(ProfessionalRole role, String name) =>
      _run(() async {
        if (!role.canSelfRegister) {
          throw AppFailure(FailureKind.authorization);
        }
        if (validateName(name) != null) {
          throw AppFailure(FailureKind.validation);
        }
        final account = await remote.onboard(role, name.trim());
        await clearCache();
        return account;
      });
  @override
  Future<Account> updateName(String name) => _run(() async {
    if (validateName(name) != null) {
      throw AppFailure(FailureKind.validation);
    }
    final account = await remote.updateName(name.trim());
    await clearCache();
    return account;
  });
  @override
  Future<AccountSettings> settings() => _run(remote.settings);
  @override
  Future<void> updateSettings(AccountSettings settings) =>
      _run(() => remote.updateSettings(settings));
  @override
  Future<String> requestDeletion() => _run(() async {
    final receipt = await remote.requestDeletion();
    await clearCache();
    return receipt;
  });
  @override
  Future<void> clearCache() async {
    _generation++;
    await cache.clear();
  }
}
