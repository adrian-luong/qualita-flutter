import 'package:flutter/material.dart';
import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/services/project_services.dart';

class ProjectController {
  final _services = ProjectServices();
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();

  void dispose() {
    title.dispose();
    description.dispose();
  }

  Future<String> addProject() async {
    try {
      var model = ProjectModel(
        title: title.text.trim(),
        description: description.text.trim(),
      );
      await _services.insert(model);

      formKey.currentState?.reset();
      title.clear();
      description.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }
}
