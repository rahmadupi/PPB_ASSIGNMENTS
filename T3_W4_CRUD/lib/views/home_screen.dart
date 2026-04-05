import 'package:flutter/material.dart';

import '../controllers/tables_controller.dart';
import '../models/app_table.dart';
import '../widgets/neo.dart';
import 'table_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TablesController controller;

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
    controller = TablesController();
    controller.load();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _createTableDialog() async {
    final textController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create table'),
          content: TextField(
            controller: textController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Table name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, textController.text),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    if (name == null) return;
    try {
      await controller.createTable(name);
    } catch (e) {
      if (!mounted) return;
      await _showErrorDialog(e);
    }
  }

  Future<void> _renameTableDialog(AppTable table) async {
    final textController = TextEditingController(text: table.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename table'),
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
      await controller.renameTable(table.id, name);
    } catch (e) {
      if (!mounted) return;
      await _showErrorDialog(e);
    }
  }

  Future<void> _confirmDelete(AppTable table) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete table?'),
          content: Text('This will remove "${table.name}" and all its data.'),
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
    await controller.deleteTable(table.id);
  }

  void _openTable(AppTable table) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TableScreen(table: table)),
    ).then((_) => controller.load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoColors.canvas,
      appBar: AppBar(
        title: const Text('Tables'),
        backgroundColor: NeoColors.header,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.isLoading && controller.tables.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.lastError != null && controller.tables.isEmpty) {
            return Center(
              child: Text(
                'Error: ${controller.lastError}',
                style: Neo.bodyBold(context),
              ),
            );
          }

          final tables = controller.tables;
          if (tables.isEmpty) {
            return Center(
              child: NeoBox(
                color: NeoColors.cell,
                child: Text(
                  'No tables yet. Create one!',
                  style: Neo.bodyBold(context),
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final table = tables[index];
              return InkWell(
                onTap: () => _openTable(table),
                child: NeoBox(
                  color: NeoColors.cell,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          table.name,
                          style: Neo.titleStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      PopupMenuButton<String>(
                        iconColor: Colors.black,
                        onSelected: (value) {
                          switch (value) {
                            case 'rename':
                              _renameTableDialog(table);
                              break;
                            case 'delete':
                              _confirmDelete(table);
                              break;
                          }
                        },
                        itemBuilder:
                            (context) => const [
                              PopupMenuItem(
                                value: 'rename',
                                child: Text('Rename'),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: tables.length,
          );
        },
      ),
      floatingActionButton: NeoButton(
        onPressed: _createTableDialog,
        text: '+ Create table',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
