import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/utils/common_types.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/tag_select.dart';

class TaskForm extends StatefulWidget {
  final FormTypes formMode;
  final TaskModel task;

  const TaskForm({super.key, required this.task, required this.formMode});

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _value = TextEditingController();
  final _desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    var buttonText = widget.formMode == FormTypes.create ? 'ADD' : 'EDIT';
    var formTitle =
        widget.formMode == FormTypes.create ? 'Add task' : 'Edit task';

    _name.text = widget.task.name;
    _desc.text = widget.task.description ?? '';
    _value.text = widget.task.value.toString();

    Future<void> onSubmit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      try {
        var inputTaskName = _name.text.trim();
        var successDisplay =
            widget.formMode == FormTypes.create
                ? 'New task $inputTaskName successfully added'
                : 'Task $inputTaskName successfully edited';

        if (widget.formMode == FormTypes.create) {
          await provider.addTask(
            name: inputTaskName,
            value: int.parse(_value.text.trim()),
            description: _desc.text.trim(),
            stepId: widget.task.fkStepId,
          );
        } else if (widget.task.id != null) {
          await provider.updateTask(
            id: widget.task.id!,
            name: inputTaskName,
            value: int.parse(_value.text.trim()),
            description: _desc.text.trim(),
            stepId: widget.task.fkStepId,
          );
        }

        displayMessage(SnackBar(content: Text(successDisplay)));
      } catch (e) {
        displayMessage(SnackBar(content: Text(e.toString())));
      } finally {
        popContext();
      }
    }

    Future<void> onDelete() async {
      if (widget.task.id != null) {
        try {
          await provider.deleteTask(widget.task.id!, widget.task.fkStepId);
          displayMessage(
            SnackBar(
              content: Text(
                'Task ${widget.task.name} has been successfully deleted',
              ),
            ),
          );
        } catch (e) {
          displayMessage(SnackBar(content: Text(e.toString())));
        } finally {
          popContext(); // Close the confirmation dialog
          popContext(); // Close the Edit task dialog
        }
      }
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formTitle, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 40),

            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                label: Text('Task name'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            TextFormField(
              controller: _value,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text('Task value'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                var input = int.tryParse(value ?? '');
                if (input == null) {
                  return 'Please input a numeric value';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),

            TagSelect(onPickingTags: (tags) {}),
            const SizedBox(height: 30),

            TextFormField(
              controller: _desc,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Task description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          dispose();
                          popContext();
                        },
                        child: Text('CLOSE'),
                      ),
                      ElevatedButton(
                        onPressed: onSubmit,
                        child: Text(buttonText),
                      ),
                      if (widget.formMode == FormTypes.edit)
                        ElevatedButton(
                          onPressed:
                              () => confirmDelete(
                                context,
                                'Are you sure you want to delete this task?',
                                onDelete,
                              ),
                          child: Text('DELETE'),
                        ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
