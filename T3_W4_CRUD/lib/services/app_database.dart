import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/app_cell.dart';
import '../models/app_column.dart';
import '../models/app_row.dart';
import '../models/app_table.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const _dbName = 't3_w4_crud.db';
  static const _dbVersion = 1;

  Database? _db;

  Future<Database> get database async {
    final existing = _db;
    if (existing != null) return existing;

    final databasesDir = await getDatabasesPath();
    final dbPath = p.join(databasesDir, _dbName);

    _db = await openDatabase(
      dbPath,
      version: _dbVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE tables (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
)
''');

        await db.execute('''
CREATE TABLE columns (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  table_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  FOREIGN KEY (table_id) REFERENCES tables(id) ON DELETE CASCADE
)
''');

        await db.execute('''
CREATE TABLE rows (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  table_id INTEGER NOT NULL,
  FOREIGN KEY (table_id) REFERENCES tables(id) ON DELETE CASCADE
)
''');

        await db.execute('''
CREATE TABLE cells (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  row_id INTEGER NOT NULL,
  column_id INTEGER NOT NULL,
  value TEXT,
  FOREIGN KEY (row_id) REFERENCES rows(id) ON DELETE CASCADE,
  FOREIGN KEY (column_id) REFERENCES columns(id) ON DELETE CASCADE
)
''');

        await db.execute(
          'CREATE UNIQUE INDEX idx_cells_row_col ON cells(row_id, column_id)',
        );
      },
    );

    return _db!;
  }

  // ----- tables -----

  Future<List<AppTable>> getTables() async {
    final db = await database;
    final rows = await db.query('tables', orderBy: 'id DESC');
    return rows.map(AppTable.fromMap).toList(growable: false);
  }

  Future<int> createTable(String name) async {
    final db = await database;
    return db.insert('tables', {'name': name.trim()});
  }

  Future<void> renameTable(int tableId, String newName) async {
    final db = await database;
    await db.update(
      'tables',
      {'name': newName.trim()},
      where: 'id = ?',
      whereArgs: [tableId],
    );
  }

  Future<void> deleteTable(int tableId) async {
    final db = await database;
    await db.delete('tables', where: 'id = ?', whereArgs: [tableId]);
  }

  // ----- columns -----

  Future<List<AppColumn>> getColumns(int tableId) async {
    final db = await database;
    final rows = await db.query(
      'columns',
      where: 'table_id = ?',
      whereArgs: [tableId],
      orderBy: 'id ASC',
    );
    return rows.map(AppColumn.fromMap).toList(growable: false);
  }

  Future<int> addColumn({required int tableId, required String name}) async {
    final db = await database;
    return db.insert('columns', {'table_id': tableId, 'name': name.trim()});
  }

  Future<void> renameColumn({
    required int columnId,
    required String newName,
  }) async {
    final db = await database;
    await db.update(
      'columns',
      {'name': newName.trim()},
      where: 'id = ?',
      whereArgs: [columnId],
    );
  }

  Future<void> deleteColumn(int columnId) async {
    final db = await database;
    await db.delete('columns', where: 'id = ?', whereArgs: [columnId]);
  }

  // ----- rows -----

  Future<List<AppRow>> getRows(int tableId) async {
    final db = await database;
    final rows = await db.query(
      'rows',
      where: 'table_id = ?',
      whereArgs: [tableId],
      orderBy: 'id ASC',
    );
    return rows.map(AppRow.fromMap).toList(growable: false);
  }

  Future<int> addRow(int tableId) async {
    final db = await database;
    return db.insert('rows', {'table_id': tableId});
  }

  Future<void> deleteRow(int rowId) async {
    final db = await database;
    await db.delete('rows', where: 'id = ?', whereArgs: [rowId]);
  }

  // ----- cells -----

  Future<List<AppCell>> getCellsForTable(int tableId) async {
    final db = await database;
    final rows = await db.rawQuery(
      '''
SELECT c.id, c.row_id, c.column_id, c.value
FROM cells c
INNER JOIN rows r ON r.id = c.row_id
WHERE r.table_id = ?
''',
      [tableId],
    );

    return rows.map(AppCell.fromMap).toList(growable: false);
  }

  Future<void> upsertCellValue({
    required int rowId,
    required int columnId,
    required String value,
  }) async {
    final db = await database;
    final trimmed = value;

    // Keep sparse storage: if user clears value, delete the cell row.
    if (trimmed.trim().isEmpty) {
      await db.delete(
        'cells',
        where: 'row_id = ? AND column_id = ?',
        whereArgs: [rowId, columnId],
      );
      return;
    }

    await db.insert('cells', {
      'row_id': rowId,
      'column_id': columnId,
      'value': trimmed,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
