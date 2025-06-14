import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/global_keys.dart';

class AddTaskForm extends StatefulWidget {
  final String stepId;
  const AddTaskForm({super.key, required this.stepId});

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _value = TextEditingController();
  final _desc = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    Future<void> onSubmit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      try {
        var newTaskName = _name.text.trim();
        await provider.addTask(
          name: newTaskName,
          value: int.parse(_value.text.trim()),
          description: _desc.text.trim(),
          stepId: widget.stepId,
        );
        displayMessage(
          SnackBar(content: Text('New task $newTaskName successfully added')),
        );
      } catch (e) {
        displayMessage(SnackBar(content: Text(e.toString())));
      } finally {
        popContext();
      }
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add task form', style: TextStyle(fontSize: 20)),
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
