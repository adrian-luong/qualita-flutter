import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/data/providers/project_provider.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/projects/add_project_form.dart';

class ProjectSelect extends StatefulWidget {
  const ProjectSelect({super.key});

  @override
  State<StatefulWidget> createState() => _SelectState();
}

class _SelectState extends State<ProjectSelect> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Consumer<ProjectProvider>(
      builder: (context, projectProvider, child) {
        if (projectProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (projectProvider.errorMessage != null) {
          return Center(
            child: Text(
              projectProvider.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (projectProvider.projects.isEmpty) {
          return const Center(child: Text('No project available to select'));
        }

        var items =
            projectProvider.projects.map((project) {
              return DropdownMenuItem<String>(
                value: project.id,
                child: Text(project.name),
              );
            }).toList();
        items.add(
          DropdownMenuItem(value: 'add', child: Text('Add new project +')),
        );

        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Select project',
            border: OutlineInputBorder(),
          ),

          hint: Text('Please choose a project'),
          value: homeProvider.selectedProject,
          isExpanded: true, // To make the dropdown take full width
          items: items,
          onChanged: (newValue) {
            if (newValue != 'add') {
              homeProvider.selectProject(newValue);
            } else {
              displayDialog(context, [AddProjectForm()]);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a project';
            }
            return null;
          },
        );
      },
    );
  }
}
