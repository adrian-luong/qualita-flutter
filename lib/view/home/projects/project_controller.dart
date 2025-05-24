import 'package:flutter/material.dart';
import 'package:qualita/data/models/panel_model.dart';
import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/services/panel_services.dart';
import 'package:qualita/data/services/project_services.dart';

class ProjectController {
  final _projectServices = ProjectServices();
  final _panelServices = PanelServices();

  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();

  void dispose() {
    title.dispose();
    description.dispose();
  }

  Future<String> addProject() async {
    try {
      var newProjectId = await _projectServices.insert(
        ProjectModel(
          title: title.text.trim(),
          description: description.text.trim(),
        ),
      );
      // Create 3 new default task panels for every new project created
      await _panelServices.insert(
        PanelModel(name: 'To-Do', project: newProjectId.id),
      );
      await _panelServices.insert(
        PanelModel(name: 'Doing', project: newProjectId.id),
      );
      await _panelServices.insert(
        PanelModel(name: 'Done', project: newProjectId.id),
      );

      formKey.currentState?.reset();
      title.clear();
      description.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }
}
