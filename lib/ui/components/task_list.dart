import 'package:flutter/material.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/ui/components/task_tile.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: tasks.length,
      itemBuilder: (context, index) =>
          TaskTile(task: tasks[index], taskKey: index),
      separatorBuilder: (context, index) => SizedBox(height: 15),
    );
  }
}
