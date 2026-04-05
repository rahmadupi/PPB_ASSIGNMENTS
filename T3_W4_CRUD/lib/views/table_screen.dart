import 'package:flutter/material.dart';

import '../controllers/table_controller.dart';
import '../models/app_table.dart';
import '../widgets/neo.dart';
import '../widgets/table_grid.dart';

class TableScreen extends StatefulWidget {
  final AppTable table;

  const TableScreen({super.key, required this.table});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  late final TableController controller;

  Future<void> _showErrorDialog(Object error) async {
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

  @override
  void initState() {
    super.initState();
    controller = TableController(tableId: widget.table.id);
    controller.load();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _addColumnDialog() async {
    final textController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add column'),
          content: TextField(
            controller: textController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Column name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, textController.text),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    if (name == null) return;
    try {
      await controller.addColumn(name);
    } catch (e) {
      if (!mounted) return;
      await _showErrorDialog(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoColors.canvas,
      appBar: AppBar(
        title: Text(widget.table.name),
        backgroundColor: NeoColors.header,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.isLoading &&
              controller.columns.isEmpty &&
              controller.rows.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.lastError != null &&
              controller.columns.isEmpty &&
              controller.rows.isEmpty) {
            return Center(
              child: Text(
                'Error: ${controller.lastError}',
                style: Neo.bodyBold(context),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: NeoBox(
                        color: NeoColors.cell,
                        child: Text(
                          'Columns: ${controller.columns.length}   Rows: ${controller.rows.length}',
                          style: Neo.bodyBold(context),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    NeoButton(onPressed: _addColumnDialog, text: '+ Column'),
                    const SizedBox(width: 12),
                    NeoButton(
                      onPressed: () => controller.addRow(),
                      text: '+ Row',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(child: TableGrid(controller: controller)),
              ],
            ),
          );
        },
      ),
    );
  }
}
