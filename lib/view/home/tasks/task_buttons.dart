import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/utils/common_types.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/tasks/task_form.dart';

class TaskButtons extends StatelessWidget {
  final TaskModel task;
  const TaskButtons({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.of(context);
    final provider = Provider.of<HomeProvider>(context);

    final roundedTopStyle = ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.directional(
            topStart: Radius.circular(4),
            topEnd: Radius.circular(4),
          ),
        ),
      ),
    );
    // final roundedMidStyle = ButtonStyle(
    //   shape: WidgetStateProperty.all(
    //     RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.zero),
    //   ),
    // );
    final roundedEndStyle = ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.directional(
            bottomStart: Radius.circular(4),
            bottomEnd: Radius.circular(4),
          ),
        ),
      ),
    );
    final roundedEndFilledStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      foregroundColor: WidgetStateProperty.all(scheme.primary),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.directional(
            bottomStart: Radius.circular(4),
            bottomEnd: Radius.circular(4),
          ),
        ),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton.outlined(
          style: roundedTopStyle,
          onPressed:
              () => displayDialog(context, [
                TaskForm(task: task, formMode: FormTypes.edit),
              ]),
          icon: Icon(Icons.edit, size: 20),
        ),
        task.isPinned
            ? IconButton.filled(
              style: roundedEndFilledStyle,
              onPressed: () => provider.unpinTask(task.id!, task.fkStepId),
              icon: Icon(Icons.pin_drop, size: 20),
            )
            : IconButton.outlined(
              style: roundedEndStyle,
              onPressed: () => provider.pinTask(task),
              icon: Icon(Icons.pin_drop_outlined, size: 20),
            ),
      ],
    );
  }
}
