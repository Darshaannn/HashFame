import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/core/errors/app_failure.dart';
import 'package:ggs_mobile/core/storage/app_database.dart';
import 'package:ggs_mobile/features/account/data/account_data_source.dart';
import 'package:ggs_mobile/features/account/data/account_repository_impl.dart';
import 'package:ggs_mobile/features/account/domain/account.dart';

class StubAccountDataSource implements AccountDataSource {
  String? actor = 'user-a';
  Object? failure;
  int onboardCalls = 0;
  Account account = Account(
    id: 'user-a',
    displayName: 'Creator A',
    primaryRoleLabel: ProfessionalRole.creator,
    accountState: AccountState.active,
    updatedAt: DateTime.utc(2026),
  );

  void failIfNeeded() {
    if (failure case final error?) throw error;
  }

  @override
  String? get userId => actor;
  @override
  Future<Account> load() async {
    failIfNeeded();
    return account;
  }

  @override
  Future<Account> onboard(ProfessionalRole role, String name) async {
    failIfNeeded();
    onboardCalls++;
    return account.copyWith(displayName: name, primaryRoleLabel: role);
  }

  @override
  Future<Account> updateName(String name) async {
    failIfNeeded();
    return account.copyWith(displayName: name);
  }

  @override
  Future<AccountSettings> settings() async {
    failIfNeeded();
    return const AccountSettings();
  }

  @override
  Future<void> updateSettings(AccountSettings settings) async => failIfNeeded();
  @override
  Future<String> requestDeletion() async {
    failIfNeeded();
    return 'receipt';
  }
}

void main() {
  late AppDatabase database;
  late StubAccountDataSource remote;
  late DateTime clock;
  late AccountRepositoryImpl repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    remote = StubAccountDataSource();
    clock = DateTime.utc(2026, 1, 1, 12);
    repository = AccountRepositoryImpl(remote, database, now: () => clock);
  });

  tearDown(() => database.close());

  test('server remains authoritative and writes a minimal cache', () async {
    final result = await repository.load();
    expect(result.offline, isFalse);
    expect(result.account, remote.account);

    final cached = await database.readSummary('user-a');
    expect(cached?.account.avatarPath, isNull);
    expect(cached?.account.id, 'user-a');
  });

  test('uses a fresh cache only for connectivity failures', () async {
    await repository.load();
    remote.failure = const SocketException('offline');
    clock = clock.add(const Duration(hours: 1));

    final result = await repository.load();
    expect(result.offline, isTrue);
    expect(result.account.displayName, 'Creator A');
  });

  test('rejects stale cache entries', () async {
    await repository.load();
    remote.failure = const SocketException('offline');
    clock = clock.add(const Duration(hours: 25));

    await expectLater(
      repository.load(),
      throwsA(
        isA<AppFailure>().having(
          (failure) => failure.kind,
          'kind',
          FailureKind.network,
        ),
      ),
    );
  });

  test('never falls back for authorization or malformed identity', () async {
    await repository.load();
    remote.failure = AppFailure(FailureKind.authorization);
    await expectLater(repository.load(), throwsA(isA<AppFailure>()));
    expect(await database.readSummary('user-a'), isNull);

    remote.failure = null;
    remote.account = remote.account.copyWith(id: 'user-b');
    await expectLater(
      repository.load(),
      throwsA(
        isA<AppFailure>().having(
          (failure) => failure.kind,
          'kind',
          FailureKind.authentication,
        ),
      ),
    );
  });

  test('logout cache clearing prevents later offline recovery', () async {
    await repository.load();
    await repository.clearCache();
    remote.failure = const SocketException('offline');
    await expectLater(repository.load(), throwsA(isA<AppFailure>()));
  });

  test('blocks invalid onboarding before the data source', () async {
    await expectLater(
      repository.completeOnboarding(ProfessionalRole.admin, 'Operator'),
      throwsA(
        isA<AppFailure>().having(
          (failure) => failure.kind,
          'kind',
          FailureKind.authorization,
        ),
      ),
    );
    await expectLater(
      repository.completeOnboarding(ProfessionalRole.creator, 'x'),
      throwsA(
        isA<AppFailure>().having(
          (failure) => failure.kind,
          'kind',
          FailureKind.validation,
        ),
      ),
    );
    expect(remote.onboardCalls, 0);
  });
}
