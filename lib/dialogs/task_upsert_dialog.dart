import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qualita/models/task.dart';
import 'package:qualita/repositories/task_repository.dart';
import 'package:qualita/utils/constant_enums.dart';

class TaskUpsertDialog extends StatefulWidget {
  final BuildContext context;
  final FormMode mode;
  final Task task;
  const TaskUpsertDialog({
    super.key,
    required this.mode,
    required this.task,
    required this.context,
  });

  @override
  State<StatefulWidget> createState() => _TaskUpsertDialogState();
}

class _TaskUpsertDialogState extends State<TaskUpsertDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  final rangeStart = DateTime.now().subtract(const Duration(days: 30));
  final rangeEnd = DateTime.now().add(const Duration(days: 30));

  void _submit() {
    String newTitle = _titleController.text;
    DateTime? newStart = DateTime.tryParse(_startDateController.text);
    DateTime? newEnd = DateTime.tryParse(_endDateController.text);

    final newTask = Task(
      title: newTitle,
      startDate: newStart ?? DateTime.now(),
      endDate: newEnd,
    );
    TaskRepository.addTask(newTask);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.mode == FormMode.create ? 'Add new task' : 'Edit task',
              ),
              Divider(),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task title',
                  prefixIcon: Icon(Icons.task),
                ),
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                  labelText: 'Task start date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: widget.task.startDate,
                    firstDate: rangeStart,
                    lastDate: rangeEnd,
                  );
                  if (pickedDate != null) {
                    String date = DateFormat.yMd().format(pickedDate);
                    _startDateController.text = date;
                  }
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(
                  labelText: 'Task end date',
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: widget.task.endDate,
                    firstDate: rangeStart,
                    lastDate: rangeEnd,
                  );
                  if (pickedDate != null) {
                    String date = DateFormat.yMd().format(pickedDate);
                    _endDateController.text = date;
                  }
                },
              ),
              Divider(),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.mode == FormMode.create ? 'Add' : 'Edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
