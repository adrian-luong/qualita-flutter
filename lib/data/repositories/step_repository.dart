import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/repositories/base_repository.dart';
import 'package:qualita/utils/common_functions.dart';
import 'package:qualita/utils/query_responses.dart';

class StepRepository extends BaseRepository {
  Future<MultipleDataResponse<StepModel>> fetchSteps(String projectId) async {
    return await returnMany(
      () async => await stepServices.getByProject(projectId),
    );
  }

  Future<SingleDataResponse<StepModel>> addStep(
    String name,
    String projectId,
  ) async {
    return await returnOne(
      () async => await stepServices.insert(
        StepModel(name: name, fkProjectId: projectId),
      ),
    );
  }

  Future<SingleDataResponse<StepModel>> renameStep({
    required String stepId,
    required String newName,
    required String projectId,
  }) async {
    return await returnOne(
      () async => await stepServices.update(
        StepModel(id: stepId, name: newName, fkProjectId: projectId),
      ),
    );
  }

  Future<MultipleDataResponse<StepModel>> reorderStep(
    int oldPosition,
    int newPosition,
    List<StepModel> steps,
  ) async {
    return await returnMany(() async {
      List<StepModel> newOrder = reorder(
        oldPosition: oldPosition,
        newPosition: newPosition,
        oldOrder: steps,
      );
      await stepServices.reposition(newOrder);
      return newOrder;
    });
  }
}
