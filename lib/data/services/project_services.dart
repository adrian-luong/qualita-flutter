import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/services/base_services.dart';
import 'package:qualita/global_keys.dart';

class ProjectServices extends BaseServices<ProjectModel> {
  ProjectServices() : super(fromMap: ProjectModel.fromMap, table: 'projects');

  Future<List<ProjectModel>> fetchForUser() async {
    try {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('Failed to fetch project: No user has logged in');
      }
      var response = await db.from(table).select().eq('fk_user_id', user.id);
      return response.map((map) => ProjectModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch project: $e');
    }
  }
}
