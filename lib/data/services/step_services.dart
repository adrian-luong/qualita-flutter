import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/services/base_services.dart';

class StepServices extends BaseServices<StepModel> {
  StepServices() : super(fromMap: StepModel.fromMap, table: 'steps');

  Future<List<StepModel>> getByProject(String projectId) async {
    try {
      final response = await db
          .from(table)
          .select()
          .eq('fk_project_id', projectId);
      return response.map((map) => StepModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch steps for project (id=$projectId): $e');
    }
  }

  Future<void> reposition(List<StepModel> modelList) async {
    try {
      for (var model in modelList) {
        await update(model);
      }
    } catch (e) {
      throw Exception('Failed to update steps: $e');
    }
  }
}
