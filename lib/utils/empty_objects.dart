import 'package:qualita/data/models/task_model.dart';

TaskModel getEmptyTask({
  required String customStepId,
  required String customProjectId,
}) => TaskModel(name: '', fkProjectId: customProjectId, fkStepId: customStepId);
