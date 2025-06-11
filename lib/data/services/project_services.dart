import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/services/base_services.dart';

class ProjectServices extends BaseServices<ProjectModel> {
  ProjectServices() : super(fromMap: ProjectModel.fromMap, table: 'projects');

  Future<List<ProjectModel>> fetchForUser(String userId) async {
    try {
      var response = await db.from(table).select().eq('fk_user_id', userId);
      return response.map((map) => ProjectModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch project: $e');
    }
  }
}
