import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/global_keys.dart';

class AddProjectForm extends StatefulWidget {
  const AddProjectForm({super.key});

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<AddProjectForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _desc = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    Future<void> onSubmit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      try {
        var newProjectName = _name.text.trim();
        await provider.addProject(
          name: newProjectName,
          description: _desc.text.trim(),
        );

        _formKey.currentState?.reset();
        _name.clear();
        _desc.clear();

        displayMessage(
          SnackBar(
            content: Text('New project $newProjectName successfully added'),
          ),
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
            Text('Add project form', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 40),

            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                label: Text('Step name'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            TextFormField(
              controller: _desc,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Project description',
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
