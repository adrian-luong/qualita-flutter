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

  Future<void> removeTagFromTask(String taskId, String tagId) async {
    try {
      await db
          .from('task_tags')
          .delete()
          .eq('fk_task_id', taskId)
          .eq('fk_tag_id', tagId);
    } catch (e) {
      throw Exception(
        'Failed to remove tag (id=$tagId) from task (id=$taskId): $e',
      );
    }
  }

  Future<void> addTagToTask(String taskId, String tagId) async {
    try {
      await db.from('task_tags').insert({
        'fk_task_id': taskId,
        'fk_tag_id': tagId,
      });
    } catch (e) {
      throw Exception('Failed to add tag (id=$tagId) to task (id=$taskId): $e');
    }
  }
}
