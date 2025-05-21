import 'package:flutter/material.dart';
import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/services/project_services.dart';
import 'package:qualita/utils/custom_builders.dart';

class ProjectSelect extends StatefulWidget {
  const ProjectSelect({super.key});

  @override
  State<StatefulWidget> createState() => _SelectState();
}

class _SelectState extends State<ProjectSelect> {
  String? selectedProjectId;
  final _projectServices = ProjectServices();

  @override
  Widget build(BuildContext context) {
    return customStreamBuilder<ProjectModel>(
      stream: _projectServices.streamAll(),
      builder: (data) {
        var items =
            data.map((document) {
              var data = document.data();
              return DropdownMenuItem<String>(
                value: document.id,
                child: Text(data.title),
              );
            }).toList();

        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Select project',
            border: OutlineInputBorder(),
          ),

          hint: Text('Please choose a project'),
          value: selectedProjectId,
          isExpanded: true, // To make the dropdown take full width
          items: items,
          onChanged: (newValue) => selectedProjectId = newValue,
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
