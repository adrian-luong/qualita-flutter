import 'package:flutter/material.dart';
import 'package:qualita/data/models/task_model.dart';

class TaskPanel extends StatefulWidget {
  final TaskModel task;
  const TaskPanel({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _PanelState();
}

class _PanelState extends State<TaskPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: 300,
        color: Colors.blueAccent,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.task.name} (${widget.task.value})',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
