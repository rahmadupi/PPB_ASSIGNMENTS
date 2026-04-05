class AppColumn {
  final int id;
  final int tableId;
  final String name;

  const AppColumn({
    required this.id,
    required this.tableId,
    required this.name,
  });

  factory AppColumn.fromMap(Map<String, Object?> map) {
    return AppColumn(
      id: (map['id'] as int?) ?? 0,
      tableId: (map['table_id'] as int?) ?? 0,
      name: (map['name'] as String?) ?? '',
    );
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'table_id': tableId, 'name': name};
  }

  AppColumn copyWith({int? id, int? tableId, String? name}) {
    return AppColumn(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      name: name ?? this.name,
    );
  }
}
