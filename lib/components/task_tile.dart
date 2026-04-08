import 'package:intl/intl.dart';
import 'package:qualita/dialogs/task_upsert_dialog.dart';
import 'package:qualita/models/task.dart';
import 'package:qualita/utils/constant_enums.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int taskKey;

  const TaskTile({super.key, required this.task, required this.taskKey});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    String? startDate = DateFormat.yMd().format(task.startDate);
    String? endDate = task.endDate != null
        ? DateFormat.yMd().format(task.endDate!)
        : '';

    return OutlinedContainer(
      height: 75,
      clipBehavior: Clip.antiAlias,
      child: AppBar(
        title: Text(task.title),
        subtitle: Text('($startDate - $endDate)'),
        leading: [
          Tooltip(
            tooltip: TooltipContainer(
              backgroundColor: scheme.foreground,
              child: Text('Edit this task'),
            ).call,
            child: OutlineButton(
              density: ButtonDensity.icon,
              onPressed: () => showDialog(
                context: context,
                builder: (context) => TaskUpsertDialog(
                  mode: FormMode.edit,
                  task: task,
                  taskKey: taskKey,
                  context: context,
                ),
              ),
              child: const Icon(Icons.edit),
            ),
          ),
        ],
        trailing: [
          Tooltip(
            tooltip: TooltipContainer(
              backgroundColor: scheme.foreground,
              child: Text('Put the task to be On-hold'),
            ).call,
            child: OutlineButton(
              density: ButtonDensity.icon,
              onPressed: () {},
              child: const Icon(Icons.pause),
            ),
          ),
          Tooltip(
            tooltip: TooltipContainer(
              backgroundColor: scheme.foreground,
              child: Text('Put the task to be Completed'),
            ).call,
            child: OutlineButton(
              density: ButtonDensity.icon,
              onPressed: () {},
              child: const Icon(Icons.check),
            ),
          ),
        ],
      ),
      // child: Center(
      //   child: Text('${task.title} ),
      // ),
    );
  }
}
