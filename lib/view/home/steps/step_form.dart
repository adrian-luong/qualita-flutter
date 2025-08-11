import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/utils/common_types.dart';
import 'package:qualita/utils/display_dialog.dart';

class StepForm extends StatefulWidget {
  final FormTypes formMode;
  final StepModel step;
  const StepForm({super.key, required this.formMode, required this.step});

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<StepForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  bool isNotDeletable = true;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<HomeProvider>(context, listen: false);
    var existingTasks = provider.tasks[widget.step.id];
    setState(
      () => isNotDeletable = existingTasks != null && existingTasks.isNotEmpty,
    );
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    var buttonText = widget.formMode == FormTypes.create ? 'ADD' : 'EDIT';
    var formTitle =
        widget.formMode == FormTypes.create ? 'Add step' : 'Edit step';

    _name.text = widget.step.name;

    Future<void> onSubmit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      try {
        var stepName = _name.text.trim();
        var successDisplay =
            widget.formMode == FormTypes.create
                ? 'New step $stepName successfully added'
                : 'Step $stepName successfully edited';

        if (provider.selectedProject != null) {
          if (widget.formMode == FormTypes.create) {
            await provider.addStep(name: stepName);
          } else if (widget.step.id != null) {
            await provider.editStep(
              stepId: widget.step.id!,
              name: stepName,
              position: widget.step.position,
            );
          }

          displayMessage(SnackBar(content: Text(successDisplay)));
        } else {
          throw Exception('Please select a project before adding step');
        }
      } catch (e) {
        displayMessage(SnackBar(content: Text(e.toString())));
      } finally {
        popContext();
      }
    }

    Future<void> onDelete() async {
      if (widget.step.id != null) {
        try {
          await provider.deleteTask(widget.step.id!, widget.step.fkProjectId);
          displayMessage(
            SnackBar(
              content: Text(
                'Step ${widget.step.name} has been successfully deleted',
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
                label: Text('Step name'),
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
                              isNotDeletable
                                  ? null
                                  : () => confirmDelete(
                                    context,
                                    'Are you sure you want to delete this step?',
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
