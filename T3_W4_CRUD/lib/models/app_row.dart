class AppRow {
  final int id;
  final int tableId;

  const AppRow({required this.id, required this.tableId});

  factory AppRow.fromMap(Map<String, Object?> map) {
    return AppRow(
      id: (map['id'] as int?) ?? 0,
      tableId: (map['table_id'] as int?) ?? 0,
    );
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'table_id': tableId};
  }
}
