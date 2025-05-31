import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/global_keys.dart';

class StepServices {
  final _db = supabase.from('steps');

  Future<StepModel> find(String stepId) async {
    try {
      final res = await _db.select().eq('id', stepId).limit(1).single();
      return StepModel.fromMap(res);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> insert(StepModel step) async {
    int latestPosition = -1;
    try {
      final latestStep =
          await _db
              .select('position')
              .order('position', ascending: false)
              .limit(1)
              .single();
      latestPosition = latestStep['position'];
    } catch (e) {
      latestPosition = -1;
    }

    try {
      step.position = latestPosition + 1;
      final res =
          await _db.insert(step.toUpsertMap()).select('id').limit(1).single();
      return res['id'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> update(StepModel step) async {
    try {
      await _db.update(step.toUpdateMap()).eq('id', step.id!);
    } catch (e) {
      throw Exception(e.toString());
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

  Stream<List<Map<String, dynamic>>> streamByProject(String projectId) {
    try {
      return _db.stream(primaryKey: ['id']).eq('fk_project_id', projectId);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
