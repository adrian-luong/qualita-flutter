import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/projects/project_controller.dart';

class ProjectSelect extends StatefulWidget {
  const ProjectSelect({super.key});

  @override
  State<StatefulWidget> createState() => _SelectState();
}

class _SelectState extends State<ProjectSelect> {
  final _controller = ProjectController();
  List<ProjectModel> projects = [];

  Future<void> fetchColumns() async {
    final queriedProjects = await _controller.fetchProjects();
    if (mounted) {
      setState(() => projects = queriedProjects);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchColumns();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context, listen: false);
    var items =
        projects.map((project) {
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
      value: state.selectedProject,
      isExpanded: true, // To make the dropdown take full width
      items: items,
      onChanged: (newValue) {
        if (mounted) {
          state.selectProject(newValue);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a project';
        }
        return null;
      },
    );
  }
}
