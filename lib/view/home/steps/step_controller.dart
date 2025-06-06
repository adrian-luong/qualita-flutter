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

  Future<String> addStep(String projectId) async {
    try {
      await _services.insert(
        StepModel(name: name.text.trim(), fkProjectId: projectId),
      );
      formKey.currentState?.reset();
      name.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> renameStep(
    String stepId,
    String newName,
    String projectId,
  ) async {
    await _services.update(
      StepModel(id: stepId, name: newName, fkProjectId: projectId),
    );
  }

  Future<List<StepModel>> listStep(String projectId) async {
    return await _services.getByProject(projectId);
  }

  Future<void> repositionStep(List<StepModel> newOrder) async {
    await _services.reposition(newOrder);
  }
}
