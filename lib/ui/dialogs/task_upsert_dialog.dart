import 'package:flutter/material.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/repositories/task_repository.dart';
import 'package:qualita/utils/constant_enums.dart';

class TaskUpsertDialog extends StatefulWidget {
  final FormMode mode;
  final Task task;
  final int? taskKey;
  const TaskUpsertDialog({
    super.key,
    required this.mode,
    required this.task,
    this.taskKey,
  });

  @override
  State<StatefulWidget> createState() => _TaskUpsertDialogState();
}

class _TaskUpsertDialogState extends State<TaskUpsertDialog> {
  late String newTitle;
  late DateTime newStartDate;
  late DateTime? newEndDate;

  final rangeStart = DateTime.now().subtract(const Duration(days: 30));
  final rangeEnd = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    setState(() {
      newTitle = widget.task.title;
      newStartDate = widget.task.startDate;
      newEndDate = widget.task.endDate;
    });
    super.initState();
  }

  void _submit() {
    final newTask = Task(
      title: newTitle,
      startDate: newStartDate,
      endDate: newEndDate,
    );

    if (widget.mode == FormMode.edit && widget.taskKey != null) {
      TaskRepository.editTask(widget.taskKey!, newTask);
    } else {
      TaskRepository.addTask(newTask);
    }

    Navigator.of(context).pop();
  }

  void _delete() {
    TaskRepository.deleteTask(widget.taskKey!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.mode == FormMode.create
            ? 'Add new task'
            : 'Edit ${widget.task.title}',
      ),
      content: Form(
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: [
              Divider(),
              TextFormField(
                initialValue: newTitle,
                decoration: InputDecoration(labelText: 'Task title'),
                onChanged: (value) => setState(() => newTitle = value),
              ),
              InputDatePickerFormField(
                firstDate: rangeStart,
                lastDate: rangeEnd,
                initialDate: newStartDate,
                onDateSubmitted: (value) =>
                    setState(() => newStartDate = value),
                fieldLabelText: 'Task start date',
              ),
              InputDatePickerFormField(
                firstDate: rangeStart,
                lastDate: rangeEnd,
                initialDate: newStartDate,
                onDateSubmitted: (value) => setState(() => newEndDate = value),
                fieldLabelText: 'Task end date',
              ),
              Divider(),
              Row(
                children: [
                  if (widget.mode == FormMode.edit)
                    FilledButton(
                      onPressed: widget.taskKey != null ? _delete : null,
                      child: Text('Delete'),
                    ),
                  Spacer(),
                  FilledButton(
                    onPressed: _submit,
                    child: Text(
                      widget.mode == FormMode.create ? 'Add' : 'Edit',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
