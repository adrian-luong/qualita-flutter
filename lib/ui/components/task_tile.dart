import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:qualita/data/models/tag.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/data/repositories/tag_repository.dart';
import 'package:qualita/data/repositories/task_repository.dart';
import 'package:qualita/ui/dialogs/task_upsert_dialog.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/utils/constant_enums.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Color tileColor;

  const TaskTile({super.key, required this.task, required this.tileColor});

  List<Widget> renderBadges(List<String> tagIds) {
    List<Widget> badges = [];
    for (String tagId in tagIds) {
      Tag? foundTag = TagRepository.findTag(id: tagId);
      if (foundTag != null) {
        badges.add(
          Badge(padding: EdgeInsets.all(5), label: Text(foundTag.label)),
        );
      }
    }
    return badges;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: task.status == TaskStatus.onHold
                ? (context) {
                    final newTask = task;
                    newTask.status = TaskStatus.inProgress;
                    TaskRepository.editTask(newTask);
                  }
                : (context) {
                    final newTask = task;
                    newTask.status = TaskStatus.onHold;
                    TaskRepository.editTask(newTask);
                  },
            backgroundColor: TaskStatus.getColor(
              task.status != TaskStatus.onHold
                  ? TaskStatus.onHold
                  : TaskStatus.inProgress,
            ),
            foregroundColor: Colors.white,
            icon: task.status != TaskStatus.onHold
                ? Icons.pause
                : Icons.play_arrow,
            label: task.status != TaskStatus.onHold
                ? 'Put on-hold'
                : 'Put in-progress',
          ),
          SlidableAction(
            onPressed: task.status == TaskStatus.completed
                ? (context) {
                    final newTask = task;
                    newTask.status = TaskStatus.inProgress;
                    TaskRepository.editTask(newTask);
                  }
                : (context) {
                    final newTask = task;
                    newTask.status = TaskStatus.completed;
                    TaskRepository.editTask(newTask);
                  },
            backgroundColor: TaskStatus.getColor(
              task.status != TaskStatus.completed
                  ? TaskStatus.completed
                  : TaskStatus.inProgress,
            ),
            foregroundColor: Colors.white,
            icon: task.status != TaskStatus.inProgress
                ? Icons.check
                : Icons.play_arrow,
            label: task.status != TaskStatus.completed
                ? 'Mark as completed'
                : 'Put in-progress',
          ),
        ],
      ),
      child: ListTile(
        tileColor: tileColor,
        contentPadding: const EdgeInsets.all(0),
        leading: Container(color: TaskStatus.getColor(task.status), width: 15),
        title: Text(task.title),
        subtitle: Row(spacing: 10, children: renderBadges(task.tags)),
        onTap: () => showDialog(
          context: context,
          builder: (context) =>
              TaskUpsertDialog(mode: FormMode.edit, task: task),
        ),
      ),
    );
  }
}
