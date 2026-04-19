import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import 'package:qualita/data/models/tag.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/data/repositories/tag_repository.dart';
import 'package:qualita/data/repositories/task_repository.dart';
import 'package:qualita/utils/constant_enums.dart';
import 'package:qualita/utils/generate_id.dart';

class TaskUpsertDialog extends StatefulWidget {
  final FormMode mode;
  final Task task;
  const TaskUpsertDialog({super.key, required this.mode, required this.task});

  @override
  State<StatefulWidget> createState() => _TaskUpsertDialogState();
}

class _TaskUpsertDialogState extends State<TaskUpsertDialog> {
  late Task formTask;
  String titleError = '';

  final rangeStart = DateTime.now().subtract(const Duration(days: 30));
  final rangeEnd = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    setState(() {
      formTask = Task(
        id: widget.task.id != '' ? widget.task.id : generateID(),
        title: widget.task.title,
        startDate: widget.task.startDate,
        endDate: widget.task.endDate,
        tags: widget.task.tags,
        status: widget.task.status,
        order: widget.task.order,
      );
    });
    super.initState();
  }

  bool _validate() {
    if (formTask.title.isEmpty) {
      setState(() => titleError = 'A task must have a title');
      return false;
    }
    return true;
  }

  void _close(String message) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _submit() {
    if (_validate()) {
      if (widget.mode == FormMode.edit) {
        TaskRepository.editTask(formTask);
      } else {
        TaskRepository.addTask(formTask);
      }
      _close(
        widget.mode == FormMode.edit
            ? 'Successfully edited task'
            : 'Successfully created task',
      );
    }
  }

  void _delete() => TaskRepository.deleteTask(widget.task.id);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 15,
              children: [
                Text(
                  widget.mode == FormMode.create
                      ? 'Add new task'
                      : 'Edit ${formTask.title}',
                ),
                Divider(),
                TextFormField(
                  initialValue: formTask.title,
                  decoration: InputDecoration(
                    labelText: 'Task title',
                    errorText: titleError,
                  ),
                  onChanged: (value) => setState(() => formTask.title = value),
                ),
                InputDatePickerFormField(
                  firstDate: rangeStart,
                  lastDate: rangeEnd,
                  initialDate: formTask.startDate,
                  onDateSubmitted: (value) =>
                      setState(() => formTask.startDate = value),
                  fieldLabelText: 'Task start date',
                ),
                InputDatePickerFormField(
                  firstDate: rangeStart,
                  lastDate: rangeEnd,
                  initialDate: formTask.endDate,
                  onDateSubmitted: (value) =>
                      setState(() => formTask.endDate = value),
                  fieldLabelText: 'Task end date',
                ),
                DropdownMenu<TaskStatus>(
                  initialSelection: formTask.status,
                  requestFocusOnTap: true,
                  expandedInsets: EdgeInsets.zero,
                  label: const Text('Task status'),
                  onSelected: (value) => setState(
                    () => formTask.status = value ?? TaskStatus.inProgress,
                  ),
                  dropdownMenuEntries: TaskStatus.values
                      .map(
                        (status) => DropdownMenuEntry(
                          value: status,
                          label: TaskStatus.getLabel(status),
                        ),
                      )
                      .toList(),
                ),

                ValueListenableBuilder(
                  valueListenable: TagRepository.box.listenable(),
                  builder: (context, box, child) {
                    List<Tag> tags = TagRepository.getAllTags();
                    return MultiDropdown<String>(
                      fieldDecoration: FieldDecoration(
                        labelText: 'Task tags',
                        suffixIcon: const Icon(Icons.tag),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.secondary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                      ),
                      items: tags
                          .map(
                            (tag) => DropdownItem(
                              label: tag.label,
                              value: tag.id,
                              selected: formTask.tags.contains(tag.id),
                            ),
                          )
                          .toList(),
                      onSelectionChange: (selected) =>
                          setState(() => formTask.tags = selected),
                    );
                  },
                ),
                Divider(),
                Row(
                  children: [
                    if (widget.mode == FormMode.edit)
                      FilledButton(
                        onPressed: () {
                          _delete();
                          _close('Successfully removed task');
                        },
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
      ),
    );
  }
}
