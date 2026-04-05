import 'package:drift/drift.dart';

import 'drift/connection.dart';

part 'drift_database.g.dart';

class NameConflictException implements Exception {
  final String message;
  const NameConflictException(this.message);

  @override
  String toString() => message;
}

@DataClassName('DbTable')
class DbTables extends Table {
  @override
  String get tableName => 'tables';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name},
  ];
}

@DataClassName('DbColumn')
class DbColumns extends Table {
  @override
  String get tableName => 'columns';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get tableId =>
      integer()
          .named('table_id')
          .references(DbTables, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {tableId, name},
  ];
}

@DataClassName('DbRow')
class DbRows extends Table {
  @override
  String get tableName => 'rows';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get tableId =>
      integer()
          .named('table_id')
          .references(DbTables, #id, onDelete: KeyAction.cascade)();
}

@DataClassName('DbCell')
class DbCells extends Table {
  @override
  String get tableName => 'cells';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get rowId =>
      integer()
          .named('row_id')
          .references(DbRows, #id, onDelete: KeyAction.cascade)();
  IntColumn get columnId =>
      integer()
          .named('column_id')
          .references(DbColumns, #id, onDelete: KeyAction.cascade)();
  TextColumn get value => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {rowId, columnId},
  ];
}

@DriftDatabase(tables: [DbTables, DbColumns, DbRows, DbCells])
class AppDriftDatabase extends _$AppDriftDatabase {
  AppDriftDatabase() : super(openConnection());

  static final AppDriftDatabase instance = AppDriftDatabase();

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();

      // Drift doesn't retrofit unique constraints into existing tables, so we
      // explicitly create unique indexes for name uniqueness.
      await customStatement(
        'CREATE UNIQUE INDEX IF NOT EXISTS idx_tables_name_unique ON tables(name);',
      );
      await customStatement(
        'CREATE UNIQUE INDEX IF NOT EXISTS idx_columns_tableid_name_unique ON columns(table_id, name);',
      );
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await _dedupeNamesForUniqueIndexes();
        await customStatement(
          'CREATE UNIQUE INDEX IF NOT EXISTS idx_tables_name_unique ON tables(name);',
        );
        await customStatement(
          'CREATE UNIQUE INDEX IF NOT EXISTS idx_columns_tableid_name_unique ON columns(table_id, name);',
        );
      }
    },
  );

  Future<void> _dedupeNamesForUniqueIndexes() async {
    // 1) tables(name)
    final existingTableNames = <String>{};
    final allTables =
        await (select(dbTables)..orderBy([
          (t) => OrderingTerm.asc(t.name),
          (t) => OrderingTerm.asc(t.id),
        ])).get();

    for (final t in allTables) {
      final base = t.name.trim();
      if (!existingTableNames.add(base)) {
        var suffix = 2;
        var candidate = '$base ($suffix)';
        while (existingTableNames.contains(candidate)) {
          suffix++;
          candidate = '$base ($suffix)';
        }
        existingTableNames.add(candidate);

        await (update(dbTables)..where(
          (x) => x.id.equals(t.id),
        )).write(DbTablesCompanion(name: Value(candidate)));
      }
    }

    // 2) columns(table_id, name)
    final existingNamesPerTable = <int, Set<String>>{};
    final allColumns =
        await (select(dbColumns)..orderBy([
          (c) => OrderingTerm.asc(c.tableId),
          (c) => OrderingTerm.asc(c.name),
          (c) => OrderingTerm.asc(c.id),
        ])).get();

    for (final c in allColumns) {
      final base = c.name.trim();
      final set = existingNamesPerTable.putIfAbsent(
        c.tableId,
        () => <String>{},
      );
      if (!set.add(base)) {
        var suffix = 2;
        var candidate = '$base ($suffix)';
        while (set.contains(candidate)) {
          suffix++;
          candidate = '$base ($suffix)';
        }
        set.add(candidate);

        await (update(dbColumns)..where(
          (x) => x.id.equals(c.id),
        )).write(DbColumnsCompanion(name: Value(candidate)));
      }
    }
  }

  // ----- tables -----

  Future<List<DbTable>> getTables() {
    return (select(dbTables)..orderBy([(t) => OrderingTerm.desc(t.id)])).get();
  }

  Future<int> createTable(String name) {
    final trimmed = name.trim();
    return transaction(() async {
      if (trimmed.isEmpty) {
        throw const NameConflictException('Table name cannot be empty.');
      }

      final exists =
          await (select(dbTables)
                ..where((t) => t.name.equals(trimmed))
                ..limit(1))
              .getSingleOrNull();
      if (exists != null) {
        throw NameConflictException('Table name "$trimmed" already exists.');
      }

      return into(dbTables).insert(DbTablesCompanion(name: Value(trimmed)));
    });
  }

  Future<void> renameTable(int tableId, String newName) async {
    final trimmed = newName.trim();
    await transaction(() async {
      if (trimmed.isEmpty) {
        throw const NameConflictException('Table name cannot be empty.');
      }

      final exists =
          await (select(dbTables)
                ..where(
                  (t) => t.name.equals(trimmed) & t.id.isNotValue(tableId),
                )
                ..limit(1))
              .getSingleOrNull();
      if (exists != null) {
        throw NameConflictException('Table name "$trimmed" already exists.');
      }

      await (update(dbTables)..where(
        (t) => t.id.equals(tableId),
      )).write(DbTablesCompanion(name: Value(trimmed)));
    });
  }

  Future<void> deleteTable(int tableId) async {
    await (delete(dbTables)..where((t) => t.id.equals(tableId))).go();
  }

  // ----- columns -----

  Future<List<DbColumn>> getColumns(int tableId) {
    return (select(dbColumns)
          ..where((c) => c.tableId.equals(tableId))
          ..orderBy([(c) => OrderingTerm.asc(c.id)]))
        .get();
  }

  Future<int> addColumn({required int tableId, required String name}) {
    final trimmed = name.trim();
    return transaction(() async {
      if (trimmed.isEmpty) {
        throw const NameConflictException('Column name cannot be empty.');
      }

      final exists =
          await (select(dbColumns)
                ..where(
                  (c) => c.tableId.equals(tableId) & c.name.equals(trimmed),
                )
                ..limit(1))
              .getSingleOrNull();
      if (exists != null) {
        throw NameConflictException('Column name "$trimmed" already exists.');
      }

      return into(dbColumns).insert(
        DbColumnsCompanion(tableId: Value(tableId), name: Value(trimmed)),
      );
    });
  }

  Future<void> renameColumn({
    required int columnId,
    required String newName,
  }) async {
    final trimmed = newName.trim();
    await transaction(() async {
      if (trimmed.isEmpty) {
        throw const NameConflictException('Column name cannot be empty.');
      }

      final col =
          await (select(dbColumns)
            ..where((c) => c.id.equals(columnId))).getSingleOrNull();
      if (col == null) return;

      final exists =
          await (select(dbColumns)
                ..where(
                  (c) =>
                      c.tableId.equals(col.tableId) &
                      c.name.equals(trimmed) &
                      c.id.isNotValue(columnId),
                )
                ..limit(1))
              .getSingleOrNull();
      if (exists != null) {
        throw NameConflictException('Column name "$trimmed" already exists.');
      }

      await (update(dbColumns)..where(
        (c) => c.id.equals(columnId),
      )).write(DbColumnsCompanion(name: Value(trimmed)));
    });
  }

  Future<void> deleteColumn(int columnId) async {
    await (delete(dbColumns)..where((c) => c.id.equals(columnId))).go();
  }

  // ----- rows -----

  Future<List<DbRow>> getRows(int tableId) {
    return (select(dbRows)
          ..where((r) => r.tableId.equals(tableId))
          ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();
  }

  Future<int> addRow(int tableId) {
    return into(dbRows).insert(DbRowsCompanion(tableId: Value(tableId)));
  }

  Future<void> deleteRow(int rowId) async {
    await (delete(dbRows)..where((r) => r.id.equals(rowId))).go();
  }

  // ----- cells -----

  Future<List<DbCell>> getCellsForTable(int tableId) async {
    final query = select(dbCells).join([
      innerJoin(dbRows, dbRows.id.equalsExp(dbCells.rowId)),
    ])..where(dbRows.tableId.equals(tableId));

    final results = await query.get();
    return results.map((r) => r.readTable(dbCells)).toList(growable: false);
  }

  Future<void> upsertCellValue({
    required int rowId,
    required int columnId,
    required String value,
  }) async {
    final trimmed = value;

    // Keep sparse storage: if user clears value, delete the cell row.
    if (trimmed.trim().isEmpty) {
      await (delete(dbCells)..where(
        (c) => c.rowId.equals(rowId) & c.columnId.equals(columnId),
      )).go();
      return;
    }

    await into(dbCells).insert(
      DbCellsCompanion(
        rowId: Value(rowId),
        columnId: Value(columnId),
        value: Value(trimmed),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }
}
