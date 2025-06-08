import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/tasks/task_controller.dart';

class AddTaskForm extends StatefulWidget {
  final String stepId;
  const AddTaskForm({super.key, required this.stepId});

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<AddTaskForm> {
  final _controller = TaskController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context);
    Future<void> onSubmit() async {
      if (!_controller.formKey.currentState!.validate()) {
        return;
      }

      setState(() => isLoading = true);
      await _controller
          .addTask(projectId: state.selectedProject!, stepId: widget.stepId)
          .then((value) {
            if (value != 'OK') {
              displayMessage(SnackBar(content: Text(value)));
            }
            popContext();
          });
      setState(() => isLoading = false);
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add task form', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 40),

            TextFormField(
              controller: _controller.name,
              decoration: InputDecoration(
                label: Text('Task name'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            TextFormField(
              controller: _controller.value,
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

            TextFormField(
              controller: _controller.description,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Task description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            isLoading
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
                      ElevatedButton(onPressed: onSubmit, child: Text('ADD')),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
