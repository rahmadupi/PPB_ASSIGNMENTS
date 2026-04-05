import 'package:flutter/foundation.dart';

import '../models/app_table.dart';
import '../services/drift_database.dart';

class TablesController extends ChangeNotifier {
  final AppDriftDatabase _db;

  TablesController({AppDriftDatabase? db})
    : _db = db ?? AppDriftDatabase.instance;

  bool isLoading = false;
  Object? lastError;
  List<AppTable> tables = const [];

  Future<void> load() async {
    isLoading = true;
    lastError = null;
    notifyListeners();

    try {
      final dbTables = await _db.getTables();
      tables = dbTables
          .map((t) => AppTable(id: t.id, name: t.name))
          .toList(growable: false);
    } catch (e) {
      lastError = e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTable(String name) async {
    await _db.createTable(name);
    await load();
  }

  Future<void> renameTable(int tableId, String newName) async {
    await _db.renameTable(tableId, newName);
    await load();
  }

  Future<void> deleteTable(int tableId) async {
    await _db.deleteTable(tableId);
    await load();
  }
}
