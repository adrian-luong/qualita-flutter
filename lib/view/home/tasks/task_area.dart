import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/tasks/add_task_form.dart';
import 'package:qualita/view/home/tasks/task_item.dart';

class TaskArea extends StatefulWidget {
  final String stepId;
  const TaskArea({super.key, required this.stepId});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<TaskArea> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (provider.selectedProject == null) {
          return const Text('Please select a project');
        }

        var tasks = provider.tasks[widget.stepId] ?? [];
        var taskBoxes =
            tasks
                .map((task) => TaskItem(key: ValueKey(task.id), task: task))
                .toList();

        return DragTarget<TaskModel>(
          onAcceptWithDetails:
              (details) async => await provider.restepTask(
                task: details.data,
                newStepId: widget.stepId,
              ),
          builder: (context, candidateData, rejectedData) {
            bool isHovering = candidateData.isNotEmpty;
            Color borderColor =
                isHovering ? Colors.blueAccent : Colors.transparent;
            double borderWidth = isHovering ? 3.0 : 1.0;
            Color? bgColor =
                isHovering
                    ? Colors.blue.withValues(alpha: 0.1)
                    : Colors.grey[200];

            return Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor, width: borderWidth),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ReorderableListView(
                scrollDirection: Axis.vertical,
                footer: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: IconButton(
                    onPressed:
                        () => displayDialog(context, [
                          AddTaskForm(stepId: widget.stepId),
                        ]),
                    icon: Icon(Icons.add_outlined),
                    selectedIcon: Icon(Icons.add),
                  ),
                ),
                onReorder:
                    (oldIndex, newIndex) async => await provider.reorderTask(
                      oldPosition: oldIndex,
                      newPosition: newIndex,
                      stepId: widget.stepId,
                    ),
                children: taskBoxes,
              ),
            );
          },
        );
      },
    );
  }
}
