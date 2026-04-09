import 'package:flutter/material.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/models/task_status.dart';
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
  late String formTitle;
  late DateTime formStartDate;
  late DateTime? formEndDate;
  late TaskStatus formStatus;

  final rangeStart = DateTime.now().subtract(const Duration(days: 30));
  final rangeEnd = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    setState(() {
      formTitle = widget.task.title;
      formStartDate = widget.task.startDate;
      formEndDate = widget.task.endDate;
      formStatus = widget.task.status;
    });
    super.initState();
  }

  void _submit() {
    final newTask = Task(
      title: formTitle,
      startDate: formStartDate,
      endDate: formEndDate,
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
                initialValue: formTitle,
                decoration: InputDecoration(labelText: 'Task title'),
                onChanged: (value) => setState(() => formTitle = value),
              ),
              InputDatePickerFormField(
                firstDate: rangeStart,
                lastDate: rangeEnd,
                initialDate: formStartDate,
                onDateSubmitted: (value) =>
                    setState(() => formStartDate = value),
                fieldLabelText: 'Task start date',
              ),
              InputDatePickerFormField(
                firstDate: rangeStart,
                lastDate: rangeEnd,
                initialDate: formEndDate,
                onDateSubmitted: (value) => setState(() => formEndDate = value),
                fieldLabelText: 'Task end date',
              ),

              DropdownMenu<TaskStatus>(
                initialSelection: formStatus,
                requestFocusOnTap: true,
                label: const Text('Select task status'),
                onSelected: (value) =>
                    setState(() => formStatus = value ?? TaskStatus.inProgress),
                dropdownMenuEntries: TaskStatus.values
                    .map(
                      (status) => DropdownMenuEntry(
                        value: status,
                        label: TaskStatus.getLabel(status),
                      ),
                    )
                    .toList(),
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
