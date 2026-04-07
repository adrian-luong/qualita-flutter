import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:qualita/layout.dart';
import 'package:qualita/models/task.dart';
import 'package:qualita/repositories/task_repository.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TasksScreen> {
  @override
  void initState() {
    TaskRepository.setupTestData();
    super.initState();
  }

  @override
  void dispose() {
    TaskRepository.box.deleteAll(TaskRepository.box.keys);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      screen: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Task List'),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: TaskRepository.box.listenable(),
                builder: (context, box, child) {
                  List<Task> tasks = TaskRepository.getAllTasks();

                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Task task = tasks[index];
                      String? startDate = DateFormat.yMd().format(
                        task.startDate,
                      );
                      String? endDate = task.endDate != null
                          ? DateFormat.yMd().format(task.endDate!)
                          : '';

                      return Container(
                        height: 50,
                        color: Colors.blue[index],
                        child: Center(
                          child: Text('${task.title} ($startDate - $endDate)'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
