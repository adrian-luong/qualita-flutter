import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/services/project_services.dart';
import 'package:qualita/utils/custom_builders.dart';
import 'package:qualita/view/home/home_state.dart';

class ProjectSelect extends StatefulWidget {
  const ProjectSelect({super.key});

  @override
  State<StatefulWidget> createState() => _SelectState();
}

class _SelectState extends State<ProjectSelect> {
  final _projectServices = ProjectServices();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context);

    return customStreamBuilder(
      stream: _projectServices.streamAll(),
      builder: (data) {
        var items =
            data.map((row) {
              var model = ProjectModel.fromMap(row);
              return DropdownMenuItem<String>(
                value: model.id,
                child: Text(model.name),
              );
            }).toList();

        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Select project',
            border: OutlineInputBorder(),
          ),

          hint: Text('Please choose a project'),
          value: state.selectedProject,
          isExpanded: true, // To make the dropdown take full width
          items: items,
          onChanged: (newValue) => state.select(newValue),
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
