import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/table_controller.dart';
import 'neo.dart';
import 'table_cell.dart';
import 'table_header.dart';

class TableGrid extends StatefulWidget {
  final TableController controller;

  const TableGrid({super.key, required this.controller});

  @override
  State<TableGrid> createState() => _TableGridState();
}

class _TableGridState extends State<TableGrid> {
  late final FocusNode _focusNode;

  TableController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: 'table-grid');
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _focusGrid() {
    if (!_focusNode.hasFocus) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  Future<void> _showFullValueDialog(BuildContext context, String value) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Full value'),
          content: SingleChildScrollView(
            child: SelectableText(value.isEmpty ? '(empty)' : value),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(BuildContext context, Object error) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cannot save'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _renameColumnDialog({
    required BuildContext context,
    required int columnId,
    required String currentName,
  }) async {
    final textController = TextEditingController(text: currentName);
    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename column'),
          content: TextField(
            controller: textController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'New name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, textController.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    if (name == null) return;
    try {
      await controller.renameColumn(columnId, name);
    } catch (e) {
      if (!mounted) return;
      await _showErrorDialog(context, e);
    }
  }

  Future<void> _confirmDeleteColumn({
    required BuildContext context,
    required int columnId,
    required String columnName,
  }) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete column?'),
          content: Text('This will remove "$columnName" and its cells.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    if (ok != true) return;
    await controller.deleteColumn(columnId);
  }

  Future<void> _confirmDeleteRow({
    required BuildContext context,
    required int rowId,
    required String rowLabel,
  }) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete row?'),
          content: Text('This will remove row $rowLabel and its cells.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    if (ok != true) return;
    await controller.deleteRow(rowId);
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (controller.isEditingAny) return KeyEventResult.ignored;

    final columns = controller.columns;
    final rows = controller.rows;
    if (columns.isEmpty || rows.isEmpty) return KeyEventResult.ignored;

    var rowIndex = rows.indexWhere((r) => r.id == controller.selectedRowId);
    var colIndex = columns.indexWhere(
      (c) => c.id == controller.selectedColumnId,
    );
    if (rowIndex < 0 || colIndex < 0) {
      rowIndex = 0;
      colIndex = 0;
      controller.selectCell(rows[rowIndex].id, columns[colIndex].id);
      return KeyEventResult.handled;
    }

    final key = event.logicalKey;
    final isLeft = key == LogicalKeyboardKey.arrowLeft;
    final isRight = key == LogicalKeyboardKey.arrowRight;
    final isUp = key == LogicalKeyboardKey.arrowUp;
    final isDown = key == LogicalKeyboardKey.arrowDown;

    if (isLeft || isRight || isUp || isDown) {
      final nextRow = (rowIndex +
              (isDown
                  ? 1
                  : isUp
                  ? -1
                  : 0))
          .clamp(0, rows.length - 1);
      final nextCol = (colIndex +
              (isRight
                  ? 1
                  : isLeft
                  ? -1
                  : 0))
          .clamp(0, columns.length - 1);
      controller.selectCell(rows[nextRow].id, columns[nextCol].id);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.f2) {
      controller.startEditing(rows[rowIndex].id, columns[colIndex].id);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.escape) {
      controller.cancelEditing();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final columns = controller.columns;
    final rows = controller.rows;

    const rowHeaderWidth = 70.0;
    const columnWidth = 180.0;
    const headerHeight = 56.0;
    const rowHeight = 56.0;

    if (columns.isEmpty || rows.isEmpty) {
      return NeoBox(
        color: NeoColors.cell,
        child: Text(
          columns.isEmpty && rows.isEmpty
              ? 'Add a column and a row to start.'
              : columns.isEmpty
              ? 'Add at least one column.'
              : 'Add at least one row.',
          style: Neo.bodyBold(context),
        ),
      );
    }

    // Nested scrolling per spec: vertical + horizontal SingleChildScrollView.
    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _onKeyEvent,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  const TableHeaderCell(
                    text: '#',
                    width: rowHeaderWidth,
                    height: headerHeight,
                  ),
                  for (final col in columns)
                    TableHeaderCell(
                      text: col.name,
                      width: columnWidth,
                      height: headerHeight,
                      menuItems: const [
                        PopupMenuItem(value: 'rename', child: Text('Rename')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                      onMenuSelected: (value) {
                        switch (value) {
                          case 'rename':
                            _renameColumnDialog(
                              context: context,
                              columnId: col.id,
                              currentName: col.name,
                            );
                            break;
                          case 'delete':
                            _confirmDeleteColumn(
                              context: context,
                              columnId: col.id,
                              columnName: col.name,
                            );
                            break;
                        }
                      },
                    ),
                ],
              ),

              // Data rows
              for (final entry in rows.asMap().entries)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TableHeaderCell(
                      text: '${entry.key + 1}',
                      width: rowHeaderWidth,
                      height: rowHeight,
                      menuItems: const [
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete row'),
                        ),
                      ],
                      onMenuSelected: (value) {
                        if (value == 'delete') {
                          _confirmDeleteRow(
                            context: context,
                            rowId: entry.value.id,
                            rowLabel: '${entry.key + 1}',
                          );
                        }
                      },
                    ),
                    for (final col in columns)
                      TableCellWidget(
                        key: ValueKey('${entry.value.id}-${col.id}'),
                        rowId: entry.value.id,
                        columnId: col.id,
                        value: controller.getCellValue(entry.value.id, col.id),
                        isSelected: controller.isSelected(
                          entry.value.id,
                          col.id,
                        ),
                        isEditing: controller.isEditing(entry.value.id, col.id),
                        width: columnWidth,
                        height: rowHeight,
                        onSelect: () {
                          _focusGrid();
                          controller.selectCell(entry.value.id, col.id);
                        },
                        onStartEdit: () {
                          _focusGrid();
                          controller.startEditing(entry.value.id, col.id);
                        },
                        onShowFullValue:
                            () => _showFullValueDialog(
                              context,
                              controller.getCellValue(entry.value.id, col.id),
                            ),
                        onCommit: (value) => controller.commitEditing(value),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
