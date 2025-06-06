import 'package:qualita/data/models/base_model.dart';
import 'package:qualita/global_keys.dart';

class BaseServices<T extends BaseModel> {
  final db = supabase;
  final T Function(Map<String, dynamic>) fromMap;
  final String table;

  BaseServices({required this.fromMap, required this.table});

  Future<List<T>> getAll() async {
    try {
      final response = await db.from(table).select();
      return response.map((map) => fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<T> getById(String id) async {
    try {
      final response = await db.from(table).select().eq('id', id).single();
      return fromMap(response);
    } catch (e) {
      throw Exception('Failed to get data (id="$id"): $e');
    }
  }

  Future<String> insert(T model) async {
    try {
      var response =
          await db
              .from(table)
              .insert(model.toDTOMap())
              .select('id')
              .limit(1)
              .single();
      return response['id'];
    } catch (e) {
      throw Exception('Failed to insert data: $e');
    }
  }

  Future<void> update(T model) async {
    try {
      if (model.id != null) {
        await db.from(table).update(model.toMap()).eq('id', model.id!);
      } else {
        throw Exception('Failed to update data: ID is not provided');
      }
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<void> hardDelete(String id) async {
    try {
      await db.from(table).delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
