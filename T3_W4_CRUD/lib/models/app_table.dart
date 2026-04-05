class AppTable {
  final int id;
  final String name;

  const AppTable({required this.id, required this.name});

  factory AppTable.fromMap(Map<String, Object?> map) {
    return AppTable(
      id: (map['id'] as int?) ?? 0,
      name: (map['name'] as String?) ?? '',
    );
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name};
  }

  AppTable copyWith({int? id, String? name}) {
    return AppTable(id: id ?? this.id, name: name ?? this.name);
  }
}
