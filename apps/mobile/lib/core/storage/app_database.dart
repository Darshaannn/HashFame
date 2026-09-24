import 'dart:convert';

import 'package:drift/drift.dart';

import '../../features/account/domain/account.dart';
part 'app_database.g.dart';

class ProfileSummaries extends Table {
  TextColumn get userId => text()();
  TextColumn get payload => text()();
  DateTimeColumn get fetchedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {userId};
}

@DriftDatabase(tables: [ProfileSummaries])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);
  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (m) => m.createAll());
  Future<AccountSnapshot?> readSummary(String userId) async {
    final row = await (select(
      profileSummaries,
    )..where((t) => t.userId.equals(userId))).getSingleOrNull();
    if (row == null) return null;
    try {
      final account = Account.fromJson(
        jsonDecode(row.payload) as Map<String, dynamic>,
      );
      if (account.id != userId) {
        await clear();
        return null;
      }
      return AccountSnapshot(account, fetchedAt: row.fetchedAt, offline: true);
    } on FormatException {
      await clear();
      return null;
    } on TypeError {
      await clear();
      return null;
    } on ArgumentError {
      await clear();
      return null;
    }
  }

  Future<void> writeSummary(Account account, DateTime fetchedAt) async {
    // Only the own display summary and role/state; no email, token or documents.
    final summary = account.copyWith(avatarPath: null);
    await into(profileSummaries).insertOnConflictUpdate(
      ProfileSummariesCompanion.insert(
        userId: account.id,
        payload: jsonEncode(summary.toJson()),
        fetchedAt: fetchedAt,
      ),
    );
  }

  Future<void> clear() => delete(profileSummaries).go();
}
