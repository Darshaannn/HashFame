// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfileSummariesTable extends ProfileSummaries
    with TableInfo<$ProfileSummariesTable, ProfileSummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileSummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [userId, payload, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_summaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileSummary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  ProfileSummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileSummary(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $ProfileSummariesTable createAlias(String alias) {
    return $ProfileSummariesTable(attachedDatabase, alias);
  }
}

class ProfileSummary extends DataClass implements Insertable<ProfileSummary> {
  final String userId;
  final String payload;
  final DateTime fetchedAt;
  const ProfileSummary({
    required this.userId,
    required this.payload,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['payload'] = Variable<String>(payload);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  ProfileSummariesCompanion toCompanion(bool nullToAbsent) {
    return ProfileSummariesCompanion(
      userId: Value(userId),
      payload: Value(payload),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory ProfileSummary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileSummary(
      userId: serializer.fromJson<String>(json['userId']),
      payload: serializer.fromJson<String>(json['payload']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'payload': serializer.toJson<String>(payload),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  ProfileSummary copyWith({
    String? userId,
    String? payload,
    DateTime? fetchedAt,
  }) => ProfileSummary(
    userId: userId ?? this.userId,
    payload: payload ?? this.payload,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  ProfileSummary copyWithCompanion(ProfileSummariesCompanion data) {
    return ProfileSummary(
      userId: data.userId.present ? data.userId.value : this.userId,
      payload: data.payload.present ? data.payload.value : this.payload,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileSummary(')
          ..write('userId: $userId, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, payload, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileSummary &&
          other.userId == this.userId &&
          other.payload == this.payload &&
          other.fetchedAt == this.fetchedAt);
}

class ProfileSummariesCompanion extends UpdateCompanion<ProfileSummary> {
  final Value<String> userId;
  final Value<String> payload;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const ProfileSummariesCompanion({
    this.userId = const Value.absent(),
    this.payload = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileSummariesCompanion.insert({
    required String userId,
    required String payload,
    required DateTime fetchedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       payload = Value(payload),
       fetchedAt = Value(fetchedAt);
  static Insertable<ProfileSummary> custom({
    Expression<String>? userId,
    Expression<String>? payload,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (payload != null) 'payload': payload,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileSummariesCompanion copyWith({
    Value<String>? userId,
    Value<String>? payload,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return ProfileSummariesCompanion(
      userId: userId ?? this.userId,
      payload: payload ?? this.payload,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileSummariesCompanion(')
          ..write('userId: $userId, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfileSummariesTable profileSummaries = $ProfileSummariesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [profileSummaries];
}

typedef $$ProfileSummariesTableCreateCompanionBuilder =
    ProfileSummariesCompanion Function({
      required String userId,
      required String payload,
      required DateTime fetchedAt,
      Value<int> rowid,
    });
typedef $$ProfileSummariesTableUpdateCompanionBuilder =
    ProfileSummariesCompanion Function({
      Value<String> userId,
      Value<String> payload,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });

class $$ProfileSummariesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileSummariesTable> {
  $$ProfileSummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileSummariesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileSummariesTable> {
  $$ProfileSummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileSummariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileSummariesTable> {
  $$ProfileSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$ProfileSummariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileSummariesTable,
          ProfileSummary,
          $$ProfileSummariesTableFilterComposer,
          $$ProfileSummariesTableOrderingComposer,
          $$ProfileSummariesTableAnnotationComposer,
          $$ProfileSummariesTableCreateCompanionBuilder,
          $$ProfileSummariesTableUpdateCompanionBuilder,
          (
            ProfileSummary,
            BaseReferences<
              _$AppDatabase,
              $ProfileSummariesTable,
              ProfileSummary
            >,
          ),
          ProfileSummary,
          PrefetchHooks Function()
        > {
  $$ProfileSummariesTableTableManager(
    _$AppDatabase db,
    $ProfileSummariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileSummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileSummariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileSummariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileSummariesCompanion(
                userId: userId,
                payload: payload,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String payload,
                required DateTime fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProfileSummariesCompanion.insert(
                userId: userId,
                payload: payload,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfileSummariesTable, ProfileSummary>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ProfileSummariesTable,
                    ProfileSummary
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileSummariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileSummariesTable,
      ProfileSummary,
      $$ProfileSummariesTableFilterComposer,
      $$ProfileSummariesTableOrderingComposer,
      $$ProfileSummariesTableAnnotationComposer,
      $$ProfileSummariesTableCreateCompanionBuilder,
      $$ProfileSummariesTableUpdateCompanionBuilder,
      (
        ProfileSummary,
        BaseReferences<_$AppDatabase, $ProfileSummariesTable, ProfileSummary>,
      ),
      ProfileSummary,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfileSummariesTableTableManager get profileSummaries =>
      $$ProfileSummariesTableTableManager(_db, _db.profileSummaries);
}
