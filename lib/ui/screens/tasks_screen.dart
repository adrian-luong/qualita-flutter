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
  TaskStatus? filter;
  // onChanged: (value) => setState(() => filter = value),
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
                  onPressed: () => setState(() => filter = null),
                  child: Text('All'),
                ),
                ...TaskStatus.values.map(
                  (status) => OutlinedButton(
                    onPressed: () => setState(() => filter = status),
                    child: Text(
                      TaskStatus.getLabel(status),
                      style: TextStyle(color: TaskStatus.getTextColor(status)),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: ValueListenableBuilder(
                valueListenable: TaskRepository.box.listenable(),
                builder: (context, box, child) {
                  List<Task> tasks = TaskRepository.getAllTasks();
                  if (filter != null) {
                    tasks = tasks
                        .where((task) => task.status == filter)
                        .toList();
                  }
                  return TaskList(tasks: tasks);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
