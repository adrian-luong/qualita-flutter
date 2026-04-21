import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:qualita/data/auth_services.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/data/models/tag.dart';
import 'package:qualita/data/repositories/tag_repository.dart';
import 'package:qualita/data/repositories/task_repository.dart';

import 'package:qualita/ui/screens/auth/signin_screen.dart';
import 'package:qualita/ui/screen_provider.dart';
import 'package:qualita/ui/screens/home_screen.dart';
import 'package:qualita/ui/screens/settings_screen.dart';
import 'package:qualita/ui/screens/tasks_screen.dart';
import 'package:qualita/ui/theme_provider.dart';

import 'package:qualita/utils/constant_enums.dart';
import 'package:qualita/global_keys.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async loading
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<TaskStatus>(TaskStatusAdapter());
  Hive.registerAdapter<Tag>(TagAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<Tag>('tags');
  TaskRepository.setupTestData();
  TagRepository.setupTestData();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Screen screen = ref.watch(screenProvider);
    final ThemeMode mode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: AuthServices.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for auth state
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.session == null) {
              return const SigninScreen();
            }
            switch (screen) {
              case Screen.home:
                return HomeScreen();
              case Screen.tasks:
                return TasksScreen();
              case Screen.settings:
                return SettingsScreen();
            }
          }

          // Show a loading indicator while waiting for auth state
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: mode,
    );
  }
}
