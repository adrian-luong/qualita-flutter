import 'package:flutter/material.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/services/step_services.dart';
import 'package:qualita/data/services/project_services.dart';
import 'package:qualita/global_keys.dart';

class ProjectController {
  final _projectServices = ProjectServices();
  final _stepServices = StepServices();

  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();

  void dispose() {
    name.dispose();
    description.dispose();
  }

  Future<String> addProject() async {
    try {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('No user has logged in');
      }

      var newProjectId = await _projectServices.insert(
        ProjectModel(
          name: name.text.trim(),
          fkUserId: user.id,
          description: description.text.trim(),
        ),
      );
      // Create 3 new default task panels for every new project created
      await _stepServices.insert(
        StepModel(name: 'To-Do', fkProjectId: newProjectId),
      );
      await _stepServices.insert(
        StepModel(name: 'Doing', fkProjectId: newProjectId),
      );
      await _stepServices.insert(
        StepModel(name: 'Done', fkProjectId: newProjectId),
      );

      formKey.currentState?.reset();
      name.clear();
      description.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<ProjectModel>> fetchProjects() async {
    return await _projectServices.fetchForUser();
  }
}
