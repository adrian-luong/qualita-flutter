import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/services/base_services.dart';

class TaskServices extends BaseServices<TaskModel> {
  TaskServices() : super(fromMap: TaskModel.fromMap, table: 'tasks');

  Future<List<TaskModel>> getByProjectStep(
    String projectId,
    String stepId,
    String? term,
  ) async {
    try {
      List<Map<String, dynamic>> response;
      if (term != null && term.trim() != '') {
        response = await db
            .from('joined_tasks_view')
            .select()
            .eq('fk_project_id', projectId)
            .eq('fk_step_id', stepId)
            .textSearch('name', term);
      } else {
        response = await db
            .from('joined_tasks_view')
            .select()
            .eq('fk_project_id', projectId)
            .eq('fk_step_id', stepId);
      }
      return response.map((map) => TaskModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception(
        'Failed to fetch tasks for project (id=$projectId) at step (id=$stepId): $e',
      );
    }
  }

  Future<void> reposition(List<TaskModel> modelList) async {
    try {
      for (var model in modelList) {
        await update(model);
      }
    } catch (e) {
      throw Exception('Failed to update tasks: $e');
    }
  }
}
