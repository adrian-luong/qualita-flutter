import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/global_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StepServices {
  final _db = supabase.from('steps');

  Future<StepModel> find(String stepId) async {
    try {
      final res = await _db.select().eq('id', stepId).limit(1).single();
      return StepModel.fromMap(res);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> upsert(StepModel step) async {
    try {
      final res =
          await _db.upsert(step.toUpsertMap()).select('id').limit(1).single();
      return res['id'];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<StepModel>> list() async {
    try {
      var snapshot = await _db.select();
      return snapshot.map((row) => StepModel.fromMap(row)).toList();
    } catch (e) {
      return [];
    }
  }

  SupabaseStreamBuilder streamByProject(String projectId) {
    try {
      return _db.stream(primaryKey: ['id']).eq('fk_project_id', projectId);
    } catch (e) {
      throw Exception(e);
    }
  }
}
