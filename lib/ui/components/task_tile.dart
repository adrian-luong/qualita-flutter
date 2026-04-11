import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qualita/ui/dialogs/task_upsert_dialog.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/utils/constant_enums.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int taskKey;

  const TaskTile({super.key, required this.task, required this.taskKey});

  @override
  Widget build(BuildContext context) {
    String? startDate = DateFormat.yMd().format(task.startDate);
    String? endDate = task.endDate != null
        ? DateFormat.yMd().format(task.endDate!)
        : '';

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, // Border color
          width: 2.0, // Border thickness
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          spacing: 10,
          children: [
            Column(
              spacing: 5,
              children: [Text(task.title), Text('($startDate - $endDate)')],
            ),
            Column(
              children: [
                Tooltip(
                  message: 'Edit this task',
                  child: IconButton.filled(
                    iconSize: 15,
                    icon: const Icon(Icons.edit),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => TaskUpsertDialog(
                        mode: FormMode.edit,
                        task: task,
                        taskKey: taskKey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Tooltip(
                  message: 'Put the task to be On-hold',
                  child: IconButton.filled(
                    iconSize: 15,
                    icon: const Icon(Icons.pause),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Tooltip(
                  message: 'Put the task to be Completed',
                  child: IconButton.filled(
                    iconSize: 15,
                    icon: const Icon(Icons.check),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
