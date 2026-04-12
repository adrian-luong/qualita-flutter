import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/data/repositories/task_repository.dart';
import 'package:qualita/ui/screen_provider.dart';
import 'package:qualita/ui/screens/home_screen.dart';
import 'package:qualita/ui/screens/settings_screen.dart';
import 'package:qualita/ui/screens/tasks_screen.dart';
import 'package:qualita/utils/constant_enums.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<TaskStatus>(TaskStatusAdapter());
  await Hive.openBox<Task>('tasks');
  TaskRepository.setupTestData();

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Screen screen = ref.watch(screenProvider);
    Widget renderScreen(Screen screen) {
      switch (screen) {
        case Screen.home:
          return HomeScreen();
        case Screen.tasks:
          return TasksScreen();
        case Screen.settings:
          return SettingsScreen();
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: renderScreen(screen),
    );
  }
}
