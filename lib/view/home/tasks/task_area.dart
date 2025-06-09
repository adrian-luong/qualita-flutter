import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/tasks/add_task_form.dart';
import 'package:qualita/view/home/tasks/task_controller.dart';
import 'package:qualita/view/home/tasks/task_panel.dart';

class TaskArea extends StatefulWidget {
  final String stepId;
  const TaskArea({super.key, required this.stepId});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<TaskArea> {
  final _controller = TaskController();
  List<TaskModel> tasks = [];

  Future<void> fetchTasks() async {
    if (mounted) {
      final state = Provider.of<HomeState>(context, listen: false);
      if (state.selectedProject != null) {
        final queriedTasks = await _controller.fetchTasks(
          projectId: state.selectedProject!,
          stepId: widget.stepId,
        );
        setState(() => tasks = queriedTasks);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    var taskBoxes =
        tasks
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
  }
}
