import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/tasks/add_task_form.dart';
import 'package:qualita/view/home/tasks/task_panel.dart';

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

        var getTasks = provider.tasks[widget.stepId] ?? [];
        var taskBoxes =
            getTasks
                .map(
                  (task) => Padding(
                    key: ValueKey(task.id),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TaskPanel(task: task),
                  ),
                )
                .toList();

        return Container(
          width: 300,
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...taskBoxes,
              Padding(
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
            ],
          ),
        );
      },
    );
  }
}
