class AppCell {
  final int id;
  final int rowId;
  final int columnId;
  final String value;

  const AppCell({
    required this.id,
    required this.rowId,
    required this.columnId,
    required this.value,
  });

  factory AppCell.fromMap(Map<String, Object?> map) {
    return AppCell(
      id: (map['id'] as int?) ?? 0,
      rowId: (map['row_id'] as int?) ?? 0,
      columnId: (map['column_id'] as int?) ?? 0,
      value: (map['value'] as String?) ?? '',
    );
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'row_id': rowId, 'column_id': columnId, 'value': value};
  }
}
