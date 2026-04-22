import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:qualita/ui/components/home/date_filter.dart';
import 'package:qualita/ui/components/home/search_filter.dart';
import 'package:qualita/ui/components/home/status_filter.dart';
import 'package:qualita/ui/components/task_list.dart';
import 'package:qualita/ui/dialogs/task_upsert_dialog.dart';
import 'package:qualita/ui/providers/task_filter_provider.dart';
import 'package:qualita/ui/screen_layout.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/repositories/task_repository.dart';
import 'package:qualita/utils/constant_enums.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreentate();
}

class _HomeScreentate extends ConsumerState<HomeScreen> {
  final _tasks = ValueNotifier<List<Task>>([]);

  @override
  initState() {
    _tasks.value = TaskRepository.getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(taskFilterProvider);

    return ScreenLayout(
      screen: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DateFilter(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: const [SearchFilter(), StatusFilter()],
              ),
            ),

            ValueListenableBuilder(
              valueListenable: TaskRepository.box.listenable(),
              builder: (context, box, child) {
                List<Task> tasks = box.values.toList();

                // Filtering by search term
                if (filter.search.isNotEmpty) {
                  tasks = tasks
                      .where(
                        (task) => task.title.toLowerCase().contains(
                          filter.search.toLowerCase(),
                        ),
                      )
                      .toList();
                }

                // Filtering by date
                tasks = tasks.where((task) {
                  final startDate = task.startDate;
                  final endDate = task.endDate;
                  var condition =
                      startDate.isAfter(filter.date) ||
                      startDate.isAtSameMomentAs(filter.date);
                  if (endDate != null) {
                    condition =
                        condition &&
                        (endDate.isBefore(filter.date) ||
                            endDate.isAtSameMomentAs(filter.date));
                  }
                  return condition;
                }).toList();

                // Filtering by status
                if (filter.status != null) {
                  tasks = tasks
                      .where((task) => task.status == filter.status)
                      .toList();
                }

                return Expanded(child: TaskList(tasks: tasks));
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Tooltip(
                message: 'Create a new task',
                child: FilledButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => TaskUpsertDialog(
                      mode: FormMode.create,
                      task: Task.empty(),
                    ),
                  ),
                  child: const Text('+'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
