import 'package:flutter/foundation.dart';

import '../models/app_cell.dart';
import '../models/app_column.dart';
import '../models/app_row.dart';
import '../services/drift_database.dart';

class TableController extends ChangeNotifier {
  final int tableId;
  final AppDriftDatabase _db;

  TableController({required this.tableId, AppDriftDatabase? db})
    : _db = db ?? AppDriftDatabase.instance;

  bool isLoading = false;
  Object? lastError;

  List<AppColumn> columns = const [];
  List<AppRow> rows = const [];
  List<AppCell> cells = const [];

  /// Fast lookup: key = "rowId-columnId".
  final Map<String, String> cellMap = {};

  String _key(int rowId, int columnId) => '$rowId-$columnId';

  int? selectedRowId;
  int? selectedColumnId;

  int? editingRowId;
  int? editingColumnId;

  bool get isEditingAny => editingRowId != null && editingColumnId != null;

  bool isSelected(int rowId, int columnId) {
    return selectedRowId == rowId && selectedColumnId == columnId;
  }

  bool isEditing(int rowId, int columnId) {
    return editingRowId == rowId && editingColumnId == columnId;
  }

  void selectCell(int rowId, int columnId) {
    selectedRowId = rowId;
    selectedColumnId = columnId;
    notifyListeners();
  }

  void startEditing(int rowId, int columnId) {
    editingRowId = rowId;
    editingColumnId = columnId;
    notifyListeners();
  }

  void cancelEditing() {
    if (!isEditingAny) return;
    editingRowId = null;
    editingColumnId = null;
    notifyListeners();
  }

  Future<void> commitEditing(String value) async {
    final r = editingRowId;
    final c = editingColumnId;
    if (r == null || c == null) return;

    await saveCellValue(rowId: r, columnId: c, value: value);
    editingRowId = null;
    editingColumnId = null;
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    lastError = null;
    notifyListeners();

    try {
      final dbColumns = await _db.getColumns(tableId);
      final dbRows = await _db.getRows(tableId);
      final dbCells = await _db.getCellsForTable(tableId);

      columns = dbColumns
          .map((c) => AppColumn(id: c.id, tableId: c.tableId, name: c.name))
          .toList(growable: false);
      rows = dbRows
          .map((r) => AppRow(id: r.id, tableId: r.tableId))
          .toList(growable: false);
      cells = dbCells
          .map(
            (c) => AppCell(
              id: c.id,
              rowId: c.rowId,
              columnId: c.columnId,
              value: c.value ?? '',
            ),
          )
          .toList(growable: false);

      cellMap
        ..clear()
        ..addEntries(
          cells.map((c) => MapEntry(_key(c.rowId, c.columnId), c.value)),
        );

      // If selected/editing cell no longer exists, clear state.
      if (selectedRowId != null && selectedColumnId != null) {
        final hasRow = rows.any((r) => r.id == selectedRowId);
        final hasCol = columns.any((c) => c.id == selectedColumnId);
        if (!hasRow || !hasCol) {
          selectedRowId = null;
          selectedColumnId = null;
        }
      }
      if (editingRowId != null && editingColumnId != null) {
        final hasRow = rows.any((r) => r.id == editingRowId);
        final hasCol = columns.any((c) => c.id == editingColumnId);
        if (!hasRow || !hasCol) {
          editingRowId = null;
          editingColumnId = null;
        }
      }
    } catch (e) {
      lastError = e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addColumn(String name) async {
    await _db.addColumn(tableId: tableId, name: name);
    await load();
  }

  Future<void> renameColumn(int columnId, String newName) async {
    await _db.renameColumn(columnId: columnId, newName: newName);
    await load();
  }

  Future<void> deleteColumn(int columnId) async {
    await _db.deleteColumn(columnId);
    await load();
  }

  Future<void> addRow() async {
    await _db.addRow(tableId);
    await load();
  }

  Future<void> deleteRow(int rowId) async {
    await _db.deleteRow(rowId);
    await load();
  }

  Future<void> saveCellValue({
    required int rowId,
    required int columnId,
    required String value,
  }) async {
    await _db.upsertCellValue(rowId: rowId, columnId: columnId, value: value);

    final k = _key(rowId, columnId);
    if (value.trim().isEmpty) {
      cellMap.remove(k);
    } else {
      cellMap[k] = value;
    }

    notifyListeners();
  }

  String getCellValue(int rowId, int columnId) {
    return cellMap[_key(rowId, columnId)] ?? '';
  }
}
