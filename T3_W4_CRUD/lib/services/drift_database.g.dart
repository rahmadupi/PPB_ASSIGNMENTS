// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $DbTablesTable extends DbTables with TableInfo<$DbTablesTable, DbTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbTablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tables';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbTable> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name},
  ];
  @override
  DbTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbTable(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
    );
  }

  @override
  $DbTablesTable createAlias(String alias) {
    return $DbTablesTable(attachedDatabase, alias);
  }
}

class DbTable extends DataClass implements Insertable<DbTable> {
  final int id;
  final String name;
  const DbTable({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  DbTablesCompanion toCompanion(bool nullToAbsent) {
    return DbTablesCompanion(id: Value(id), name: Value(name));
  }

  factory DbTable.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbTable(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  DbTable copyWith({int? id, String? name}) =>
      DbTable(id: id ?? this.id, name: name ?? this.name);
  DbTable copyWithCompanion(DbTablesCompanion data) {
    return DbTable(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbTable(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbTable && other.id == this.id && other.name == this.name);
}

class DbTablesCompanion extends UpdateCompanion<DbTable> {
  final Value<int> id;
  final Value<String> name;
  const DbTablesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  DbTablesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<DbTable> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  DbTablesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return DbTablesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbTablesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $DbColumnsTable extends DbColumns
    with TableInfo<$DbColumnsTable, DbColumn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbColumnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tableIdMeta = const VerificationMeta(
    'tableId',
  );
  @override
  late final GeneratedColumn<int> tableId = GeneratedColumn<int>(
    'table_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tables (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, tableId, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'columns';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbColumn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('table_id')) {
      context.handle(
        _tableIdMeta,
        tableId.isAcceptableOrUnknown(data['table_id']!, _tableIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tableIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {tableId, name},
  ];
  @override
  DbColumn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbColumn(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      tableId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}table_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
    );
  }

  @override
  $DbColumnsTable createAlias(String alias) {
    return $DbColumnsTable(attachedDatabase, alias);
  }
}

class DbColumn extends DataClass implements Insertable<DbColumn> {
  final int id;
  final int tableId;
  final String name;
  const DbColumn({required this.id, required this.tableId, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['table_id'] = Variable<int>(tableId);
    map['name'] = Variable<String>(name);
    return map;
  }

  DbColumnsCompanion toCompanion(bool nullToAbsent) {
    return DbColumnsCompanion(
      id: Value(id),
      tableId: Value(tableId),
      name: Value(name),
    );
  }

  factory DbColumn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbColumn(
      id: serializer.fromJson<int>(json['id']),
      tableId: serializer.fromJson<int>(json['tableId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tableId': serializer.toJson<int>(tableId),
      'name': serializer.toJson<String>(name),
    };
  }

  DbColumn copyWith({int? id, int? tableId, String? name}) => DbColumn(
    id: id ?? this.id,
    tableId: tableId ?? this.tableId,
    name: name ?? this.name,
  );
  DbColumn copyWithCompanion(DbColumnsCompanion data) {
    return DbColumn(
      id: data.id.present ? data.id.value : this.id,
      tableId: data.tableId.present ? data.tableId.value : this.tableId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbColumn(')
          ..write('id: $id, ')
          ..write('tableId: $tableId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tableId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbColumn &&
          other.id == this.id &&
          other.tableId == this.tableId &&
          other.name == this.name);
}

class DbColumnsCompanion extends UpdateCompanion<DbColumn> {
  final Value<int> id;
  final Value<int> tableId;
  final Value<String> name;
  const DbColumnsCompanion({
    this.id = const Value.absent(),
    this.tableId = const Value.absent(),
    this.name = const Value.absent(),
  });
  DbColumnsCompanion.insert({
    this.id = const Value.absent(),
    required int tableId,
    required String name,
  }) : tableId = Value(tableId),
       name = Value(name);
  static Insertable<DbColumn> custom({
    Expression<int>? id,
    Expression<int>? tableId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tableId != null) 'table_id': tableId,
      if (name != null) 'name': name,
    });
  }

  DbColumnsCompanion copyWith({
    Value<int>? id,
    Value<int>? tableId,
    Value<String>? name,
  }) {
    return DbColumnsCompanion(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tableId.present) {
      map['table_id'] = Variable<int>(tableId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbColumnsCompanion(')
          ..write('id: $id, ')
          ..write('tableId: $tableId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $DbRowsTable extends DbRows with TableInfo<$DbRowsTable, DbRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tableIdMeta = const VerificationMeta(
    'tableId',
  );
  @override
  late final GeneratedColumn<int> tableId = GeneratedColumn<int>(
    'table_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tables (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, tableId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('table_id')) {
      context.handle(
        _tableIdMeta,
        tableId.isAcceptableOrUnknown(data['table_id']!, _tableIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tableIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      tableId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}table_id'],
          )!,
    );
  }

  @override
  $DbRowsTable createAlias(String alias) {
    return $DbRowsTable(attachedDatabase, alias);
  }
}

class DbRow extends DataClass implements Insertable<DbRow> {
  final int id;
  final int tableId;
  const DbRow({required this.id, required this.tableId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['table_id'] = Variable<int>(tableId);
    return map;
  }

  DbRowsCompanion toCompanion(bool nullToAbsent) {
    return DbRowsCompanion(id: Value(id), tableId: Value(tableId));
  }

  factory DbRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbRow(
      id: serializer.fromJson<int>(json['id']),
      tableId: serializer.fromJson<int>(json['tableId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tableId': serializer.toJson<int>(tableId),
    };
  }

  DbRow copyWith({int? id, int? tableId}) =>
      DbRow(id: id ?? this.id, tableId: tableId ?? this.tableId);
  DbRow copyWithCompanion(DbRowsCompanion data) {
    return DbRow(
      id: data.id.present ? data.id.value : this.id,
      tableId: data.tableId.present ? data.tableId.value : this.tableId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbRow(')
          ..write('id: $id, ')
          ..write('tableId: $tableId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tableId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbRow && other.id == this.id && other.tableId == this.tableId);
}

class DbRowsCompanion extends UpdateCompanion<DbRow> {
  final Value<int> id;
  final Value<int> tableId;
  const DbRowsCompanion({
    this.id = const Value.absent(),
    this.tableId = const Value.absent(),
  });
  DbRowsCompanion.insert({this.id = const Value.absent(), required int tableId})
    : tableId = Value(tableId);
  static Insertable<DbRow> custom({
    Expression<int>? id,
    Expression<int>? tableId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tableId != null) 'table_id': tableId,
    });
  }

  DbRowsCompanion copyWith({Value<int>? id, Value<int>? tableId}) {
    return DbRowsCompanion(id: id ?? this.id, tableId: tableId ?? this.tableId);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tableId.present) {
      map['table_id'] = Variable<int>(tableId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbRowsCompanion(')
          ..write('id: $id, ')
          ..write('tableId: $tableId')
          ..write(')'))
        .toString();
  }
}

class $DbCellsTable extends DbCells with TableInfo<$DbCellsTable, DbCell> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbCellsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "rows" (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _columnIdMeta = const VerificationMeta(
    'columnId',
  );
  @override
  late final GeneratedColumn<int> columnId = GeneratedColumn<int>(
    'column_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES columns (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, rowId, columnId, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cells';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbCell> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rowIdMeta);
    }
    if (data.containsKey('column_id')) {
      context.handle(
        _columnIdMeta,
        columnId.isAcceptableOrUnknown(data['column_id']!, _columnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_columnIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {rowId, columnId},
  ];
  @override
  DbCell map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbCell(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      rowId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}row_id'],
          )!,
      columnId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}column_id'],
          )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  @override
  $DbCellsTable createAlias(String alias) {
    return $DbCellsTable(attachedDatabase, alias);
  }
}

class DbCell extends DataClass implements Insertable<DbCell> {
  final int id;
  final int rowId;
  final int columnId;
  final String? value;
  const DbCell({
    required this.id,
    required this.rowId,
    required this.columnId,
    this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['row_id'] = Variable<int>(rowId);
    map['column_id'] = Variable<int>(columnId);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  DbCellsCompanion toCompanion(bool nullToAbsent) {
    return DbCellsCompanion(
      id: Value(id),
      rowId: Value(rowId),
      columnId: Value(columnId),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory DbCell.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbCell(
      id: serializer.fromJson<int>(json['id']),
      rowId: serializer.fromJson<int>(json['rowId']),
      columnId: serializer.fromJson<int>(json['columnId']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rowId': serializer.toJson<int>(rowId),
      'columnId': serializer.toJson<int>(columnId),
      'value': serializer.toJson<String?>(value),
    };
  }

  DbCell copyWith({
    int? id,
    int? rowId,
    int? columnId,
    Value<String?> value = const Value.absent(),
  }) => DbCell(
    id: id ?? this.id,
    rowId: rowId ?? this.rowId,
    columnId: columnId ?? this.columnId,
    value: value.present ? value.value : this.value,
  );
  DbCell copyWithCompanion(DbCellsCompanion data) {
    return DbCell(
      id: data.id.present ? data.id.value : this.id,
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      columnId: data.columnId.present ? data.columnId.value : this.columnId,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbCell(')
          ..write('id: $id, ')
          ..write('rowId: $rowId, ')
          ..write('columnId: $columnId, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, rowId, columnId, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbCell &&
          other.id == this.id &&
          other.rowId == this.rowId &&
          other.columnId == this.columnId &&
          other.value == this.value);
}

class DbCellsCompanion extends UpdateCompanion<DbCell> {
  final Value<int> id;
  final Value<int> rowId;
  final Value<int> columnId;
  final Value<String?> value;
  const DbCellsCompanion({
    this.id = const Value.absent(),
    this.rowId = const Value.absent(),
    this.columnId = const Value.absent(),
    this.value = const Value.absent(),
  });
  DbCellsCompanion.insert({
    this.id = const Value.absent(),
    required int rowId,
    required int columnId,
    this.value = const Value.absent(),
  }) : rowId = Value(rowId),
       columnId = Value(columnId);
  static Insertable<DbCell> custom({
    Expression<int>? id,
    Expression<int>? rowId,
    Expression<int>? columnId,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowId != null) 'row_id': rowId,
      if (columnId != null) 'column_id': columnId,
      if (value != null) 'value': value,
    });
  }

  DbCellsCompanion copyWith({
    Value<int>? id,
    Value<int>? rowId,
    Value<int>? columnId,
    Value<String?>? value,
  }) {
    return DbCellsCompanion(
      id: id ?? this.id,
      rowId: rowId ?? this.rowId,
      columnId: columnId ?? this.columnId,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (columnId.present) {
      map['column_id'] = Variable<int>(columnId.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbCellsCompanion(')
          ..write('id: $id, ')
          ..write('rowId: $rowId, ')
          ..write('columnId: $columnId, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDriftDatabase extends GeneratedDatabase {
  _$AppDriftDatabase(QueryExecutor e) : super(e);
  $AppDriftDatabaseManager get managers => $AppDriftDatabaseManager(this);
  late final $DbTablesTable dbTables = $DbTablesTable(this);
  late final $DbColumnsTable dbColumns = $DbColumnsTable(this);
  late final $DbRowsTable dbRows = $DbRowsTable(this);
  late final $DbCellsTable dbCells = $DbCellsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dbTables,
    dbColumns,
    dbRows,
    dbCells,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tables',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('columns', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tables',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('rows', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'rows',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cells', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'columns',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cells', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DbTablesTableCreateCompanionBuilder =
    DbTablesCompanion Function({Value<int> id, required String name});
typedef $$DbTablesTableUpdateCompanionBuilder =
    DbTablesCompanion Function({Value<int> id, Value<String> name});

final class $$DbTablesTableReferences
    extends BaseReferences<_$AppDriftDatabase, $DbTablesTable, DbTable> {
  $$DbTablesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DbColumnsTable, List<DbColumn>>
  _dbColumnsRefsTable(_$AppDriftDatabase db) => MultiTypedResultKey.fromTable(
    db.dbColumns,
    aliasName: $_aliasNameGenerator(db.dbTables.id, db.dbColumns.tableId),
  );

  $$DbColumnsTableProcessedTableManager get dbColumnsRefs {
    final manager = $$DbColumnsTableTableManager(
      $_db,
      $_db.dbColumns,
    ).filter((f) => f.tableId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dbColumnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DbRowsTable, List<DbRow>> _dbRowsRefsTable(
    _$AppDriftDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.dbRows,
    aliasName: $_aliasNameGenerator(db.dbTables.id, db.dbRows.tableId),
  );

  $$DbRowsTableProcessedTableManager get dbRowsRefs {
    final manager = $$DbRowsTableTableManager(
      $_db,
      $_db.dbRows,
    ).filter((f) => f.tableId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dbRowsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DbTablesTableFilterComposer
    extends Composer<_$AppDriftDatabase, $DbTablesTable> {
  $$DbTablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dbColumnsRefs(
    Expression<bool> Function($$DbColumnsTableFilterComposer f) f,
  ) {
    final $$DbColumnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbColumns,
      getReferencedColumn: (t) => t.tableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbColumnsTableFilterComposer(
            $db: $db,
            $table: $db.dbColumns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dbRowsRefs(
    Expression<bool> Function($$DbRowsTableFilterComposer f) f,
  ) {
    final $$DbRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbRows,
      getReferencedColumn: (t) => t.tableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbRowsTableFilterComposer(
            $db: $db,
            $table: $db.dbRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbTablesTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $DbTablesTable> {
  $$DbTablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbTablesTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $DbTablesTable> {
  $$DbTablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> dbColumnsRefs<T extends Object>(
    Expression<T> Function($$DbColumnsTableAnnotationComposer a) f,
  ) {
    final $$DbColumnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbColumns,
      getReferencedColumn: (t) => t.tableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbColumnsTableAnnotationComposer(
            $db: $db,
            $table: $db.dbColumns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dbRowsRefs<T extends Object>(
    Expression<T> Function($$DbRowsTableAnnotationComposer a) f,
  ) {
    final $$DbRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbRows,
      getReferencedColumn: (t) => t.tableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.dbRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbTablesTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $DbTablesTable,
          DbTable,
          $$DbTablesTableFilterComposer,
          $$DbTablesTableOrderingComposer,
          $$DbTablesTableAnnotationComposer,
          $$DbTablesTableCreateCompanionBuilder,
          $$DbTablesTableUpdateCompanionBuilder,
          (DbTable, $$DbTablesTableReferences),
          DbTable,
          PrefetchHooks Function({bool dbColumnsRefs, bool dbRowsRefs})
        > {
  $$DbTablesTableTableManager(_$AppDriftDatabase db, $DbTablesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DbTablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DbTablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DbTablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => DbTablesCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  DbTablesCompanion.insert(id: id, name: name),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DbTablesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({dbColumnsRefs = false, dbRowsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (dbColumnsRefs) db.dbColumns,
                if (dbRowsRefs) db.dbRows,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dbColumnsRefs)
                    await $_getPrefetchedData<
                      DbTable,
                      $DbTablesTable,
                      DbColumn
                    >(
                      currentTable: table,
                      referencedTable: $$DbTablesTableReferences
                          ._dbColumnsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DbTablesTableReferences(
                                db,
                                table,
                                p0,
                              ).dbColumnsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.tableId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (dbRowsRefs)
                    await $_getPrefetchedData<DbTable, $DbTablesTable, DbRow>(
                      currentTable: table,
                      referencedTable: $$DbTablesTableReferences
                          ._dbRowsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DbTablesTableReferences(
                                db,
                                table,
                                p0,
                              ).dbRowsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.tableId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DbTablesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $DbTablesTable,
      DbTable,
      $$DbTablesTableFilterComposer,
      $$DbTablesTableOrderingComposer,
      $$DbTablesTableAnnotationComposer,
      $$DbTablesTableCreateCompanionBuilder,
      $$DbTablesTableUpdateCompanionBuilder,
      (DbTable, $$DbTablesTableReferences),
      DbTable,
      PrefetchHooks Function({bool dbColumnsRefs, bool dbRowsRefs})
    >;
typedef $$DbColumnsTableCreateCompanionBuilder =
    DbColumnsCompanion Function({
      Value<int> id,
      required int tableId,
      required String name,
    });
typedef $$DbColumnsTableUpdateCompanionBuilder =
    DbColumnsCompanion Function({
      Value<int> id,
      Value<int> tableId,
      Value<String> name,
    });

final class $$DbColumnsTableReferences
    extends BaseReferences<_$AppDriftDatabase, $DbColumnsTable, DbColumn> {
  $$DbColumnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DbTablesTable _tableIdTable(_$AppDriftDatabase db) => db.dbTables
      .createAlias($_aliasNameGenerator(db.dbColumns.tableId, db.dbTables.id));

  $$DbTablesTableProcessedTableManager get tableId {
    final $_column = $_itemColumn<int>('table_id')!;

    final manager = $$DbTablesTableTableManager(
      $_db,
      $_db.dbTables,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tableIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DbCellsTable, List<DbCell>> _dbCellsRefsTable(
    _$AppDriftDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.dbCells,
    aliasName: $_aliasNameGenerator(db.dbColumns.id, db.dbCells.columnId),
  );

  $$DbCellsTableProcessedTableManager get dbCellsRefs {
    final manager = $$DbCellsTableTableManager(
      $_db,
      $_db.dbCells,
    ).filter((f) => f.columnId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dbCellsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DbColumnsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $DbColumnsTable> {
  $$DbColumnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$DbTablesTableFilterComposer get tableId {
    final $$DbTablesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tableId,
      referencedTable: $db.dbTables,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbTablesTableFilterComposer(
            $db: $db,
            $table: $db.dbTables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> dbCellsRefs(
    Expression<bool> Function($$DbCellsTableFilterComposer f) f,
  ) {
    final $$DbCellsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbCells,
      getReferencedColumn: (t) => t.columnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbCellsTableFilterComposer(
            $db: $db,
            $table: $db.dbCells,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbColumnsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $DbColumnsTable> {
  $$DbColumnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$DbTablesTableOrderingComposer get tableId {
    final $$DbTablesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tableId,
      referencedTable: $db.dbTables,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbTablesTableOrderingComposer(
            $db: $db,
            $table: $db.dbTables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbColumnsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $DbColumnsTable> {
  $$DbColumnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$DbTablesTableAnnotationComposer get tableId {
    final $$DbTablesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tableId,
      referencedTable: $db.dbTables,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbTablesTableAnnotationComposer(
            $db: $db,
            $table: $db.dbTables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> dbCellsRefs<T extends Object>(
    Expression<T> Function($$DbCellsTableAnnotationComposer a) f,
  ) {
    final $$DbCellsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbCells,
      getReferencedColumn: (t) => t.columnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbCellsTableAnnotationComposer(
            $db: $db,
            $table: $db.dbCells,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbColumnsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $DbColumnsTable,
          DbColumn,
          $$DbColumnsTableFilterComposer,
          $$DbColumnsTableOrderingComposer,
          $$DbColumnsTableAnnotationComposer,
          $$DbColumnsTableCreateCompanionBuilder,
          $$DbColumnsTableUpdateCompanionBuilder,
          (DbColumn, $$DbColumnsTableReferences),
          DbColumn,
          PrefetchHooks Function({bool tableId, bool dbCellsRefs})
        > {
  $$DbColumnsTableTableManager(_$AppDriftDatabase db, $DbColumnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DbColumnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DbColumnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DbColumnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tableId = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => DbColumnsCompanion(id: id, tableId: tableId, name: name),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tableId,
                required String name,
              }) => DbColumnsCompanion.insert(
                id: id,
                tableId: tableId,
                name: name,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DbColumnsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({tableId = false, dbCellsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dbCellsRefs) db.dbCells],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (tableId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.tableId,
                            referencedTable: $$DbColumnsTableReferences
                                ._tableIdTable(db),
                            referencedColumn:
                                $$DbColumnsTableReferences._tableIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dbCellsRefs)
                    await $_getPrefetchedData<
                      DbColumn,
                      $DbColumnsTable,
                      DbCell
                    >(
                      currentTable: table,
                      referencedTable: $$DbColumnsTableReferences
                          ._dbCellsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DbColumnsTableReferences(
                                db,
                                table,
                                p0,
                              ).dbCellsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.columnId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DbColumnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $DbColumnsTable,
      DbColumn,
      $$DbColumnsTableFilterComposer,
      $$DbColumnsTableOrderingComposer,
      $$DbColumnsTableAnnotationComposer,
      $$DbColumnsTableCreateCompanionBuilder,
      $$DbColumnsTableUpdateCompanionBuilder,
      (DbColumn, $$DbColumnsTableReferences),
      DbColumn,
      PrefetchHooks Function({bool tableId, bool dbCellsRefs})
    >;
typedef $$DbRowsTableCreateCompanionBuilder =
    DbRowsCompanion Function({Value<int> id, required int tableId});
typedef $$DbRowsTableUpdateCompanionBuilder =
    DbRowsCompanion Function({Value<int> id, Value<int> tableId});

final class $$DbRowsTableReferences
    extends BaseReferences<_$AppDriftDatabase, $DbRowsTable, DbRow> {
  $$DbRowsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DbTablesTable _tableIdTable(_$AppDriftDatabase db) => db.dbTables
      .createAlias($_aliasNameGenerator(db.dbRows.tableId, db.dbTables.id));

  $$DbTablesTableProcessedTableManager get tableId {
    final $_column = $_itemColumn<int>('table_id')!;

    final manager = $$DbTablesTableTableManager(
      $_db,
      $_db.dbTables,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tableIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DbCellsTable, List<DbCell>> _dbCellsRefsTable(
    _$AppDriftDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.dbCells,
    aliasName: $_aliasNameGenerator(db.dbRows.id, db.dbCells.rowId),
  );

  $$DbCellsTableProcessedTableManager get dbCellsRefs {
    final manager = $$DbCellsTableTableManager(
      $_db,
      $_db.dbCells,
    ).filter((f) => f.rowId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dbCellsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DbRowsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $DbRowsTable> {
  $$DbRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  $$DbTablesTableFilterComposer get tableId {
    final $$DbTablesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tableId,
      referencedTable: $db.dbTables,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbTablesTableFilterComposer(
            $db: $db,
            $table: $db.dbTables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> dbCellsRefs(
    Expression<bool> Function($$DbCellsTableFilterComposer f) f,
  ) {
    final $$DbCellsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbCells,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbCellsTableFilterComposer(
            $db: $db,
            $table: $db.dbCells,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbRowsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $DbRowsTable> {
  $$DbRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  $$DbTablesTableOrderingComposer get tableId {
    final $$DbTablesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tableId,
      referencedTable: $db.dbTables,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbTablesTableOrderingComposer(
            $db: $db,
            $table: $db.dbTables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbRowsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $DbRowsTable> {
  $$DbRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$DbTablesTableAnnotationComposer get tableId {
    final $$DbTablesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tableId,
      referencedTable: $db.dbTables,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbTablesTableAnnotationComposer(
            $db: $db,
            $table: $db.dbTables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> dbCellsRefs<T extends Object>(
    Expression<T> Function($$DbCellsTableAnnotationComposer a) f,
  ) {
    final $$DbCellsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbCells,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbCellsTableAnnotationComposer(
            $db: $db,
            $table: $db.dbCells,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbRowsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $DbRowsTable,
          DbRow,
          $$DbRowsTableFilterComposer,
          $$DbRowsTableOrderingComposer,
          $$DbRowsTableAnnotationComposer,
          $$DbRowsTableCreateCompanionBuilder,
          $$DbRowsTableUpdateCompanionBuilder,
          (DbRow, $$DbRowsTableReferences),
          DbRow,
          PrefetchHooks Function({bool tableId, bool dbCellsRefs})
        > {
  $$DbRowsTableTableManager(_$AppDriftDatabase db, $DbRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DbRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DbRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DbRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tableId = const Value.absent(),
              }) => DbRowsCompanion(id: id, tableId: tableId),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required int tableId}) =>
                  DbRowsCompanion.insert(id: id, tableId: tableId),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DbRowsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({tableId = false, dbCellsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dbCellsRefs) db.dbCells],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (tableId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.tableId,
                            referencedTable: $$DbRowsTableReferences
                                ._tableIdTable(db),
                            referencedColumn:
                                $$DbRowsTableReferences._tableIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dbCellsRefs)
                    await $_getPrefetchedData<DbRow, $DbRowsTable, DbCell>(
                      currentTable: table,
                      referencedTable: $$DbRowsTableReferences
                          ._dbCellsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DbRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).dbCellsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.rowId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DbRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $DbRowsTable,
      DbRow,
      $$DbRowsTableFilterComposer,
      $$DbRowsTableOrderingComposer,
      $$DbRowsTableAnnotationComposer,
      $$DbRowsTableCreateCompanionBuilder,
      $$DbRowsTableUpdateCompanionBuilder,
      (DbRow, $$DbRowsTableReferences),
      DbRow,
      PrefetchHooks Function({bool tableId, bool dbCellsRefs})
    >;
typedef $$DbCellsTableCreateCompanionBuilder =
    DbCellsCompanion Function({
      Value<int> id,
      required int rowId,
      required int columnId,
      Value<String?> value,
    });
typedef $$DbCellsTableUpdateCompanionBuilder =
    DbCellsCompanion Function({
      Value<int> id,
      Value<int> rowId,
      Value<int> columnId,
      Value<String?> value,
    });

final class $$DbCellsTableReferences
    extends BaseReferences<_$AppDriftDatabase, $DbCellsTable, DbCell> {
  $$DbCellsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DbRowsTable _rowIdTable(_$AppDriftDatabase db) => db.dbRows
      .createAlias($_aliasNameGenerator(db.dbCells.rowId, db.dbRows.id));

  $$DbRowsTableProcessedTableManager get rowId {
    final $_column = $_itemColumn<int>('row_id')!;

    final manager = $$DbRowsTableTableManager(
      $_db,
      $_db.dbRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rowIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DbColumnsTable _columnIdTable(_$AppDriftDatabase db) => db.dbColumns
      .createAlias($_aliasNameGenerator(db.dbCells.columnId, db.dbColumns.id));

  $$DbColumnsTableProcessedTableManager get columnId {
    final $_column = $_itemColumn<int>('column_id')!;

    final manager = $$DbColumnsTableTableManager(
      $_db,
      $_db.dbColumns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_columnIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DbCellsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $DbCellsTable> {
  $$DbCellsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  $$DbRowsTableFilterComposer get rowId {
    final $$DbRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.dbRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbRowsTableFilterComposer(
            $db: $db,
            $table: $db.dbRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DbColumnsTableFilterComposer get columnId {
    final $$DbColumnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.columnId,
      referencedTable: $db.dbColumns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbColumnsTableFilterComposer(
            $db: $db,
            $table: $db.dbColumns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbCellsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $DbCellsTable> {
  $$DbCellsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  $$DbRowsTableOrderingComposer get rowId {
    final $$DbRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.dbRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbRowsTableOrderingComposer(
            $db: $db,
            $table: $db.dbRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DbColumnsTableOrderingComposer get columnId {
    final $$DbColumnsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.columnId,
      referencedTable: $db.dbColumns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbColumnsTableOrderingComposer(
            $db: $db,
            $table: $db.dbColumns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbCellsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $DbCellsTable> {
  $$DbCellsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  $$DbRowsTableAnnotationComposer get rowId {
    final $$DbRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.dbRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.dbRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DbColumnsTableAnnotationComposer get columnId {
    final $$DbColumnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.columnId,
      referencedTable: $db.dbColumns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbColumnsTableAnnotationComposer(
            $db: $db,
            $table: $db.dbColumns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbCellsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $DbCellsTable,
          DbCell,
          $$DbCellsTableFilterComposer,
          $$DbCellsTableOrderingComposer,
          $$DbCellsTableAnnotationComposer,
          $$DbCellsTableCreateCompanionBuilder,
          $$DbCellsTableUpdateCompanionBuilder,
          (DbCell, $$DbCellsTableReferences),
          DbCell,
          PrefetchHooks Function({bool rowId, bool columnId})
        > {
  $$DbCellsTableTableManager(_$AppDriftDatabase db, $DbCellsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DbCellsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DbCellsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DbCellsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> rowId = const Value.absent(),
                Value<int> columnId = const Value.absent(),
                Value<String?> value = const Value.absent(),
              }) => DbCellsCompanion(
                id: id,
                rowId: rowId,
                columnId: columnId,
                value: value,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int rowId,
                required int columnId,
                Value<String?> value = const Value.absent(),
              }) => DbCellsCompanion.insert(
                id: id,
                rowId: rowId,
                columnId: columnId,
                value: value,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DbCellsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({rowId = false, columnId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (rowId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.rowId,
                            referencedTable: $$DbCellsTableReferences
                                ._rowIdTable(db),
                            referencedColumn:
                                $$DbCellsTableReferences._rowIdTable(db).id,
                          )
                          as T;
                }
                if (columnId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.columnId,
                            referencedTable: $$DbCellsTableReferences
                                ._columnIdTable(db),
                            referencedColumn:
                                $$DbCellsTableReferences._columnIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DbCellsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $DbCellsTable,
      DbCell,
      $$DbCellsTableFilterComposer,
      $$DbCellsTableOrderingComposer,
      $$DbCellsTableAnnotationComposer,
      $$DbCellsTableCreateCompanionBuilder,
      $$DbCellsTableUpdateCompanionBuilder,
      (DbCell, $$DbCellsTableReferences),
      DbCell,
      PrefetchHooks Function({bool rowId, bool columnId})
    >;

class $AppDriftDatabaseManager {
  final _$AppDriftDatabase _db;
  $AppDriftDatabaseManager(this._db);
  $$DbTablesTableTableManager get dbTables =>
      $$DbTablesTableTableManager(_db, _db.dbTables);
  $$DbColumnsTableTableManager get dbColumns =>
      $$DbColumnsTableTableManager(_db, _db.dbColumns);
  $$DbRowsTableTableManager get dbRows =>
      $$DbRowsTableTableManager(_db, _db.dbRows);
  $$DbCellsTableTableManager get dbCells =>
      $$DbCellsTableTableManager(_db, _db.dbCells);
}
