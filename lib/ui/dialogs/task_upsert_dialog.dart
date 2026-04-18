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
  late String formTitle;
  late DateTime formStartDate;
  late DateTime? formEndDate;
  late TaskStatus formStatus;
  late List<String> formTags;

  final rangeStart = DateTime.now().subtract(const Duration(days: 30));
  final rangeEnd = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    setState(() {
      formTitle = widget.task.title;
      formStartDate = widget.task.startDate;
      formEndDate = widget.task.endDate;
      formStatus = widget.task.status;
      formTags = widget.task.tags;
    });
    super.initState();
  }

  void _submit() {
    final newTask = Task(
      id: widget.task.id != '' ? widget.task.id : generateID(),
      title: formTitle,
      startDate: formStartDate,
      endDate: formEndDate,
      status: formStatus,
      tags: formTags,
      order: widget.task.order,
    );

    if (widget.mode == FormMode.edit) {
      TaskRepository.editTask(newTask);
    } else {
      TaskRepository.addTask(newTask);
    }
  }

  void _delete() => TaskRepository.deleteTask(widget.task.id);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final messenger = ScaffoldMessenger.of(context);

    void closeDialog(String message) {
      Navigator.of(context).pop();
      messenger.showSnackBar(SnackBar(content: Text(message)));
    }

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
                      : 'Edit $formTitle',
                ),
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
                  onDateSubmitted: (value) =>
                      setState(() => formEndDate = value),
                  fieldLabelText: 'Task end date',
                ),
                DropdownMenu<TaskStatus>(
                  initialSelection: formStatus,
                  requestFocusOnTap: true,
                  expandedInsets: EdgeInsets.zero,
                  label: const Text('Task status'),
                  onSelected: (value) => setState(
                    () => formStatus = value ?? TaskStatus.inProgress,
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
                              selected: formTags.contains(tag.id),
                            ),
                          )
                          .toList(),
                      onSelectionChange: (selected) =>
                          setState(() => formTags = selected),
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
                          closeDialog('Successfully removed task');
                        },
                        child: Text('Delete'),
                      ),
                    Spacer(),
                    FilledButton(
                      onPressed: () {
                        _submit();
                        closeDialog(
                          widget.mode == FormMode.edit
                              ? 'Successfully edited task'
                              : 'Successfully created task',
                        );
                      },
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
