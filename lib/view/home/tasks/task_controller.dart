import 'package:flutter/material.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/services/task_services.dart';

class TaskController {
  final _services = TaskServices();
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final value = TextEditingController();
  final description = TextEditingController();

  void dispose() {
    name.dispose();
    value.dispose();
    description.dispose();
  }

  Future<String> addTask({
    required String projectId,
    required String stepId,
  }) async {
    try {
      // var user = getCurrentUser();
      // if (user == null) {
      //   throw Exception('No user has logged in');
      // }

      await _services.insert(
        TaskModel(
          name: name.text.trim(),
          value: int.parse(value.text.trim()),
          description: description.text.trim(),
          fkProjectId: projectId,
          fkStepId: stepId,
        ),
      );

      formKey.currentState?.reset();
      name.clear();
      description.clear();
      value.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<TaskModel>> fetchTasks({
    required String projectId,
    required String stepId,
  }) async {
    return await _services.getByProjectStep(projectId, stepId);
  }
}
