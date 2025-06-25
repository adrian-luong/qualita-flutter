import 'package:flutter/material.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/utils/common_types.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/tasks/task_form.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                '${widget.task.name} (+${widget.task.value}) ',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed:
                    () => displayDialog(context, [
                      TaskForm(task: widget.task, formMode: FormTypes.edit),
                    ]),
                child: Icon(Icons.edit),
              ),
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
      feedback: SizedBox(width: 300, child: buildCard()),
      childWhenDragging: buildCard(color: Colors.grey[500]),
      child: buildCard(),
    );
  }
}
