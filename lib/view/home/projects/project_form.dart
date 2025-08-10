import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/data/providers/project_provider.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/utils/common_types.dart';

class ProjectForm extends StatefulWidget {
  final FormTypes formMode;
  final ProjectModel project;
  const ProjectForm({super.key, required this.formMode, required this.project});

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<ProjectForm> {
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
    final projectProvider = Provider.of<ProjectProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    var buttonText = widget.formMode == FormTypes.create ? 'ADD' : 'EDIT';
    var formTitle =
        widget.formMode == FormTypes.create
            ? 'Add project'
            : 'Project Infomation';

    _name.text = widget.project.name;
    _desc.text = widget.project.description ?? '';

    Future<void> onSubmit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      try {
        var projectName = _name.text.trim();
        var successDisplay =
            widget.formMode == FormTypes.create
                ? 'New project $projectName successfully added'
                : 'Project $projectName successfully edited';

        if (widget.formMode == FormTypes.create) {
          await projectProvider.addProject(
            name: projectName,
            description: _desc.text.trim(),
          );
        } else if (homeProvider.selectedProject != null) {
          await projectProvider.editProject(
            projectId: homeProvider.selectedProject!,
            name: projectName,
            description: _desc.text,
          );
        }

        _formKey.currentState?.reset();
        _name.clear();
        _desc.clear();

        displayMessage(SnackBar(content: Text(successDisplay)));
      } catch (e) {
        displayMessage(SnackBar(content: Text(e.toString())));
      } finally {
        popContext();
      }
    }

    return Expanded(
      child: Container(
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
                  label: Text('Project name'),
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

              projectProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        if (widget.formMode == FormTypes.create)
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
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
