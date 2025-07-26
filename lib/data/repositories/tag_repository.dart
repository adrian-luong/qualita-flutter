import 'package:qualita/data/models/tag_model.dart';
import 'package:qualita/data/query_responses.dart';
import 'package:qualita/data/repositories/base_repository.dart';

class TagRepository extends BaseRepository {
  Future<MultipleDataResponse<TagModel>> fetchTags(String projectId) async {
    return await returnMany(
      () async => await tagServices.getByProject(projectId),
    );
  }
}
