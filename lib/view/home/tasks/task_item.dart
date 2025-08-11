import 'package:flutter/material.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/view/home/tasks/task_buttons.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _ItemState();
}

class _ItemState extends State<TaskItem> {
  Widget buildCard(BuildContext context, {Color? color}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: color ?? Colors.blue,
      elevation: 1.0,
      child: Container(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '(+${widget.task.value}) ${widget.task.name} ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 1, child: TaskButtons(task: widget.task)),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<TaskModel>(
      data: widget.task,
      feedback: SizedBox(width: 300, child: buildCard(context)),
      childWhenDragging: buildCard(context, color: Colors.grey[500]),
      child: buildCard(context),
    );
  }
}
