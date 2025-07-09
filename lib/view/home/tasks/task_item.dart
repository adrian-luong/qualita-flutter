import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/providers/home_provider.dart';
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
  Widget buildCard(BuildContext context, {Color? color}) {
    final provider = Provider.of<HomeProvider>(context);

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
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      onPressed:
                          () => displayDialog(context, [
                            TaskForm(
                              task: widget.task,
                              formMode: FormTypes.edit,
                            ),
                          ]),
                      icon: Icon(Icons.edit),
                    ),
                    widget.task.isPinned
                        ? IconButton.filled(
                          onPressed:
                              () => provider.unpinTask(
                                widget.task.id!,
                                widget.task.fkStepId,
                              ),
                          icon: Icon(Icons.pin_drop),
                        )
                        : IconButton.outlined(
                          onPressed: () => provider.pinTask(widget.task),
                          icon: Icon(Icons.pin_drop_outlined),
                        ),
                  ],
                ),
              ),
              SizedBox(width: 30),
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
