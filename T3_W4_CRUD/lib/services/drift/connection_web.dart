import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

QueryExecutor createExecutor() {
  return LazyDatabase(() async {
    final result = await WasmDatabase.open(
      databaseName: 't3_w4_crud',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );

    return result.resolvedExecutor;
  });
}
