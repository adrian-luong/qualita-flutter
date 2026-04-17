import 'package:flutter/material.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/repositories/task_repository.dart';
import 'package:qualita/ui/components/task_tile.dart';

class TaskList extends StatefulWidget {
  final List<Task> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  State<StatefulWidget> createState() => _TaskList();
}

class _TaskList extends State<TaskList> {
  List<Task> taskList = [];

  @override
  void initState() {
    setState(() {
      taskList = widget.tasks;
      taskList.sort((taskA, taskB) => taskA.order.compareTo(taskB.order));
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TaskList oldWidget) {
    setState(() {
      taskList = widget.tasks;
      taskList.sort((taskA, taskB) => taskA.order.compareTo(taskB.order));
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (taskList.isEmpty) {
      return Center(child: Text('No task found.'));
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) => Padding(
        key: ValueKey(taskList[index].id),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TaskTile(task: taskList[index]),
      ),
      itemCount: taskList.length,
      onReorder: (oldIndex, newIndex) {
        List<Task> clonedList = List.from(taskList);
        clonedList.sort((taskA, taskB) => taskA.order.compareTo(taskB.order));

        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        final reorderTarget = clonedList.removeAt(oldIndex);
        print(
          'Target: ${reorderTarget.title} previously at $oldIndex, now at $newIndex',
        );
        clonedList.insert(newIndex, reorderTarget);
        clonedList.asMap().forEach((index, item) async {
          item.order = index;
          await TaskRepository.editTask(item);
        });
        clonedList.sort((taskA, taskB) => taskA.order.compareTo(taskB.order));
        print(
          'Sorted list: ${clonedList.map((t) => "Task ${t.title} at ${t.order}")}',
        );

        setState(() => taskList = clonedList);
      },
    );
  }
}
