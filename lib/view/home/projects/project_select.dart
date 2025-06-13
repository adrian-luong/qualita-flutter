import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';

class ProjectSelect extends StatefulWidget {
  const ProjectSelect({super.key});

  @override
  State<StatefulWidget> createState() => _SelectState();
}

class _SelectState extends State<ProjectSelect> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (provider.projects.isEmpty) {
          return const Center(child: Text('No project available to select'));
        }

        var items =
            provider.projects.map((project) {
              return DropdownMenuItem<String>(
                value: project.id,
                child: Text(project.name),
              );
            }).toList();

        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Select project',
            border: OutlineInputBorder(),
          ),

          hint: Text('Please choose a project'),
          value: provider.selectedProject,
          isExpanded: true, // To make the dropdown take full width
          items: items,
          onChanged: (newValue) {
            if (mounted) {
              provider.selectProject(newValue);
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
