import 'package:flutter/material.dart';

import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/ui/components/task_list.dart';
import 'package:qualita/ui/screen_layout.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/repositories/task_repository.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TaskScreentate();
}

class _TaskScreentate extends State<TasksScreen> {
  final _tasks = ValueNotifier<List<Task>>([]);

  @override
  initState() {
    _tasks.value = TaskRepository.getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      screen: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                OutlinedButton(
                  onPressed: () => _tasks.value = TaskRepository.getAllTasks(),
                  child: Text('All'),
                ),
                ...TaskStatus.values.map(
                  (status) => OutlinedButton(
                    onPressed: () => _tasks.value = TaskRepository.getAllTasks()
                        .where((task) => task.status == status)
                        .toList(),
                    child: Text(
                      TaskStatus.getLabel(status),
                      style: TextStyle(color: TaskStatus.getTextColor(status)),
                    ),
                  ),
                ),
              ],
            ),

            ValueListenableBuilder(
              valueListenable: _tasks,
              builder: (context, tasks, child) =>
                  Expanded(child: TaskList(tasks: tasks)),
            ),
          ],
        ),
      ),
    );
  }
}
