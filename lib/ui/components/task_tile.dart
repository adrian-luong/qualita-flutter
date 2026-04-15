import 'package:flutter/material.dart';
import 'package:qualita/data/models/tag.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/data/repositories/tag_repository.dart';
import 'package:qualita/data/repositories/task_repository.dart';
import 'package:qualita/ui/dialogs/task_upsert_dialog.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/utils/constant_enums.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int taskKey;

  const TaskTile({super.key, required this.task, required this.taskKey});

  @override
  Widget build(BuildContext context) {
    bool isOnhold = task.status == TaskStatus.onHold;
    bool isCompleted = task.status == TaskStatus.completed;

    List<Widget> renderBadges(List<int> tagIndexes) {
      List<Widget> badges = [];
      for (int index in tagIndexes) {
        Tag? foundTag = TagRepository.findTag(index);
        if (foundTag != null) {
          badges.add(
            Badge(padding: EdgeInsets.all(5), label: Text(foundTag.label)),
          );
        }
      }
      return badges;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent, // Border color
          width: 2.0, // Border thickness
        ),
        color: TaskStatus.getColor(task.status),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          spacing: 10,
          children: [
            Column(
              spacing: 5,
              children: [
                Text(task.title, style: TextStyle(color: Colors.white)),
                Row(spacing: 10, children: renderBadges(task.tags)),
              ],
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
                      builder: (context) =>
                          TaskUpsertDialog(mode: FormMode.edit, task: task),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Tooltip(
                  message:
                      'Put the task to be ${!isOnhold ? "On-hold" : "In-progress"}',
                  child: IconButton.filled(
                    iconSize: 15,
                    icon: Icon(isOnhold ? Icons.play_arrow : Icons.pause),
                    onPressed: () {
                      task.status = !isOnhold
                          ? TaskStatus.onHold
                          : TaskStatus.inProgress;
                      TaskRepository.editTask(task);
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Tooltip(
                  message:
                      'Put the task to be ${!isCompleted ? "Completed" : "In-progress"}',
                  child: IconButton.filled(
                    iconSize: 15,
                    icon: Icon(isCompleted ? Icons.play_arrow : Icons.check),
                    onPressed: () {
                      task.status = !isCompleted
                          ? TaskStatus.completed
                          : TaskStatus.inProgress;
                      TaskRepository.editTask(task);
                    },
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
