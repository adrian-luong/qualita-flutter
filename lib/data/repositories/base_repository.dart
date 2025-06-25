import 'package:qualita/data/models/base_model.dart';
import 'package:qualita/data/services/project_services.dart';
import 'package:qualita/data/services/step_services.dart';
import 'package:qualita/data/services/task_services.dart';
import 'package:qualita/utils/query_responses.dart';

class BaseRepository {
  final projectServices = ProjectServices();
  final stepServices = StepServices();
  final taskServices = TaskServices();

  Future<MultipleDataResponse<T>> returnMany<T extends BaseModel>(
    Future Function() query,
  ) async {
    var response = MultipleDataResponse<T>();
    try {
      response.data = await query();
      response.message = 'OK';
    } catch (e) {
      response.hasError = true;
      response.message = e.toString();
    }
    return response;
  }

  Future<SingleDataResponse<T>> returnOne<T extends BaseModel>(
    Future Function() query,
  ) async {
    var response = SingleDataResponse<T>();
    try {
      response.data = await query();
      response.message = 'OK';
    } catch (e) {
      response.hasError = true;
      response.message = e.toString();
    }
    return response;
  }

  Future<QueryResponse> returnNone(Future Function() query) async {
    var response = QueryResponse();
    try {
      await query();
      response.message = 'OK';
    } catch (e) {
      response.hasError = true;
      response.message = e.toString();
    }
    return response;
  }
}
