import 'package:flutter/material.dart';
import 'package:qualita/data/models/task_model.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _ItemState();
}

class _ItemState extends State<TaskItem> {
  Widget buildCard({Color? color}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: color ?? Colors.blue,
      elevation: 1.0,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(widget.task.name, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<TaskModel>(
      data: widget.task,
      feedback: SizedBox(width: 300, child: buildCard()),
      childWhenDragging: buildCard(color: Colors.grey[500]),
      child: buildCard(),
    );
  }
}
