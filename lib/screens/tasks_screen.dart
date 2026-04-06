import 'package:flutter/material.dart';
import 'package:qualita/layout.dart';
import 'package:qualita/models/task.dart';
import 'package:qualita/repositories/task_repository.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TasksScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    _tasks = TaskRepository.getAllTasks();
    super.initState();
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
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    color: Colors.blue[index],
                    child: Center(child: Text('Entry ${_tasks[index].title}')),
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
