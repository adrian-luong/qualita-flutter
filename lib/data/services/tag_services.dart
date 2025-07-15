import 'package:qualita/data/models/tag_model.dart';
import 'package:qualita/data/services/base_services.dart';

class TagServices extends BaseServices<TagModel> {
  TagServices() : super(fromMap: TagModel.fromMap, table: 'tags');

  Future<List<TagModel>> getByProject(String projectId) async {
    try {
      final response = await db
          .from(table)
          .select()
          .eq('fk_project_id', projectId);
      return response.map((map) => TagModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tags for project (id=$projectId): $e');
    }
  }
}
