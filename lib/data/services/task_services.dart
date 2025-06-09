import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/services/base_services.dart';

class TaskServices extends BaseServices<TaskModel> {
  TaskServices() : super(fromMap: TaskModel.fromMap, table: 'tasks');

  Future<List<TaskModel>> getByProjectStep(
    String projectId,
    String stepId,
  ) async {
    try {
      final response = await db
          .from(table)
          .select()
          .eq('fk_project_id', projectId)
          .eq('fk_step_id', stepId);
      return response.map((map) => TaskModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception(
        'Failed to fetch tasks for project (id=$projectId) at step (id=$stepId): $e',
      );
    }
  }
}
