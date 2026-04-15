import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qualita/ui/dialogs/task_upsert_dialog.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/ui/screen_provider.dart';
import 'package:qualita/utils/constant_enums.dart';

class ScreenLayout extends ConsumerWidget {
  final Widget screen;
  const ScreenLayout({super.key, required this.screen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final screenNotifier = ref.read(screenProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Qualita'),
      ),
      body: screen,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: scheme.primary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                TaskUpsertDialog(mode: FormMode.create, task: Task.empty()),
          );
        },
        tooltip: 'Create a new task',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 2500),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          elevation: 0.1,
          color: scheme.primary,
          child: IconTheme(
            data: IconThemeData(color: scheme.onPrimary),
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Home',
                  icon: const Icon(Icons.home),
                  // onPressed: () => context.go('/'),
                  onPressed: () => screenNotifier.switchScreen(Screen.home),
                ),
                IconButton(
                  tooltip: 'Tasks',
                  icon: const Icon(Icons.checklist),
                  // onPressed: () => context.go('/tasks'),
                  onPressed: () => screenNotifier.switchScreen(Screen.tasks),
                ),
                IconButton(
                  tooltip: 'Settings',
                  icon: const Icon(Icons.settings),
                  // onPressed: () => context.go('/settings'),
                  onPressed: () => screenNotifier.switchScreen(Screen.settings),
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
