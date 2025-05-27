import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/global_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectServices {
  final _db = supabase.from('projects');

  Future<ProjectModel> find(String projectId) async {
    try {
      final res = await _db.select().eq('id', projectId).limit(1).single();
      return ProjectModel.fromMap(res);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> upsert(ProjectModel project) async {
    try {
      final res =
          await _db
              .upsert(project.toUpsertMap())
              .select('id')
              .limit(1)
              .single();
      return res['id'];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProjectModel>> fetch() async {
    try {
      final res = await _db.select();
      return res.map((row) => ProjectModel.fromMap(row)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  SupabaseStreamBuilder streamAll() {
    try {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('No user has logged in');
      }
      return _db.stream(primaryKey: ['id']).eq('fk_user_id', user.id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
