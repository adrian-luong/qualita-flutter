import 'package:flutter/material.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/tasks/add_task_form.dart';

class TaskArea extends StatefulWidget {
  final String stepId;
  const TaskArea({super.key, required this.stepId});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<TaskArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed:
                () => displayDialog(context, [
                  AddTaskForm(stepId: widget.stepId),
                ]),
            icon: Icon(Icons.add_outlined),
            selectedIcon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
