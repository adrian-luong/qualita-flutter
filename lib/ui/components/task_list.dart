import 'dart:ui';

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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withValues(alpha: 0.05);
    final Color evenItemColor = colorScheme.primary.withValues(alpha: 0.15);
    final Color draggableItemColor = colorScheme.secondary;

    if (taskList.isEmpty) {
      return Center(child: Text('No task found.'));
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      proxyDecorator: (child, index, animation) => AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      ),
      itemBuilder: (context, index) => Padding(
        key: ValueKey(taskList[index].id),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TaskTile(
          task: taskList[index],
          tileColor: index.isOdd ? oddItemColor : evenItemColor,
        ),
      ),
      itemCount: taskList.length,
      onReorder: (oldIndex, newIndex) {
        List<Task> clonedList = List.from(taskList);
        clonedList.sort((taskA, taskB) => taskA.order.compareTo(taskB.order));

        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        final reorderTarget = clonedList.removeAt(oldIndex);
        clonedList.insert(newIndex, reorderTarget);
        clonedList.asMap().forEach((index, item) async {
          item.order = index;
          await TaskRepository.editTask(item);
        });
        clonedList.sort((taskA, taskB) => taskA.order.compareTo(taskB.order));

        setState(() => taskList = clonedList);
      },
    );
  }
}
