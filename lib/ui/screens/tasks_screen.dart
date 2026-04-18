import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
                  onSelectionChanged: (newSet) =>
                      setState(() => _filter = newSet.first),
                ),
              ],
            ),

            ValueListenableBuilder(
              valueListenable: TaskRepository.box.listenable(),
              builder: (context, box, child) {
                List<Task> tasks = box.values.toList();
                if (_filter != null) {
                  tasks = tasks
                      .where((task) => task.status == _filter)
                      .toList();
                }
                return Expanded(child: TaskList(tasks: tasks));
              },
            ),
          ],
        ),
      ),
    );
  }
}
