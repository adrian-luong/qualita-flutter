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
  TaskStatus? _filter;
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
                SegmentedButton<TaskStatus?>(
                  segments: [
                    ButtonSegment(value: null, label: Text('All')),
                    ...TaskStatus.values.map(
                      (status) => ButtonSegment(
                        value: status,
                        label: Text(
                          TaskStatus.getLabel(status),
                          style: TextStyle(
                            color: TaskStatus.getTextColor(status),
                          ),
                        ),
                      ),
                    ),
                  ],
                  selected: <TaskStatus?>{_filter},
                  onSelectionChanged: (newSet) {
                    if (newSet.first == null) {
                      _tasks.value = TaskRepository.getAllTasks();
                    } else {
                      _tasks.value = TaskRepository.getAllTasks()
                          .where((task) => task.status == newSet.first)
                          .toList();
                    }
                    setState(() => _filter = newSet.first);
                  },
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
