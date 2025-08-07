import 'package:qualita/data/models/tag_model.dart';
import 'package:qualita/data/query_responses.dart';
import 'package:qualita/data/repositories/base_repository.dart';

class TagRepository extends BaseRepository {
  Future<MultipleDataResponse<TagModel>> fetchTags(String projectId) async {
    return await returnMany(
      () async => await tagServices.getByProject(projectId),
    );
  }

  Future<SingleDataResponse<TagModel>> addTag({
    required String name,
    String? description,
    required String projectId,
  }) async {
    return await returnOne(() async {
      var model = TagModel(
        name: name,
        description: description,
        fkProjectId: projectId,
      );
      await tagServices.insert(model);
      return model;
    });
  }

  Future<SingleDataResponse<TagModel>> updateTag({
    required String id,
    required String name,
    String? description,
    required String projectId,
  }) async {
    return await returnOne(() async {
      var model = TagModel(
        id: id,
        name: name,
        description: description,
        fkProjectId: projectId,
      );
      await tagServices.update(model);
      return model;
    });
  }

  Future<QueryResponse> deleteTag(String id) async {
    return await returnNone(() async => await tagServices.hardDelete(id));
  }
}
