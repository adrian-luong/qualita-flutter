import 'package:flutter/material.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/services/step_services.dart';

class StepController {
  final _services = StepServices();
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();

  void dispose() {
    name.dispose();
  }

  Future<String> addPanel(String projectId) async {
    try {
      await _services.upsert(
        StepModel(name: name.text.trim(), fkProjectId: projectId),
      );
      formKey.currentState?.reset();
      name.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }
}
