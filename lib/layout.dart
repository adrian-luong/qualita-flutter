import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qualita/dialogs/task_upsert_dialog.dart';
import 'package:qualita/models/task.dart';
import 'package:qualita/utils/constant_enums.dart';

class Layout extends StatelessWidget {
  final Widget screen;
  const Layout({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Qualita'),
      ),
      body: screen,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TaskUpsertDialog(
              mode: FormMode.create,
              task: Task.empty(),
              context: context,
            ),
          );
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 2500),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          elevation: 0.1,
          color: Colors.blue,
          child: IconTheme(
            data: IconThemeData(color: scheme.onPrimary),
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Home',
                  icon: const Icon(Icons.home),
                  onPressed: () => context.go('/'),
                ),
                IconButton(
                  tooltip: 'Tasks',
                  icon: const Icon(Icons.checklist),
                  onPressed: () => context.go('/tasks'),
                ),
                IconButton(
                  tooltip: 'Settings',
                  icon: const Icon(Icons.settings),
                  onPressed: () => context.go('/settings'),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
