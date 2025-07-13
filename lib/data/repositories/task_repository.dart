import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/repositories/base_repository.dart';
import 'package:qualita/utils/common_functions.dart';
import 'package:qualita/utils/query_responses.dart';

class TaskRepository extends BaseRepository {
  Future<MultipleDataResponse<TaskModel>> fetchTasks(
    String projectId,
    String stepId,
    String? term,
  ) async {
    return await returnMany(() async {
      var many = await taskServices.getByProjectStep(projectId, stepId, term);
      return many;
    });
  }

  Future<SingleDataResponse<TaskModel>> addTask({
    required String name,
    required int value,
    String? description,
    required String stepId,
    required String projectId,
  }) async {
    return await returnOne(() async {
      var model = TaskModel(
        name: name,
        value: value,
        description: description,
        fkProjectId: projectId,
        fkStepId: stepId,
      );
      await taskServices.insert(model);
      return model;
    });
  }

  Future<MultipleDataResponse<TaskModel>> reorderTask({
    required int oldPosition,
    required int newPosition,
    required List<TaskModel> taskList,
    bool isPinning = false,
  }) async {
    return await returnMany(() async {
      List<TaskModel> newOrder = reorder(
        oldPosition: oldPosition,
        newPosition: newPosition,
        oldOrder: taskList,
      );

      // In case of pinning a task, the pinned task should be the only one which isPinned = True
      // This is temporary until allowable-pinned-tasks setting is available
      // Also, newPosition is always 0 (the first task to be rendered in the list)
      if (isPinning) {
        newOrder[newPosition].isPinned = true;
        for (var item in newOrder.sublist(1)) {
          item.isPinned = false;
        }
      }

      await taskServices.reposition(newOrder);
      return newOrder;
    });
  }

  Future<SingleDataResponse<TaskModel>> restepTask({
    required TaskModel task,
    required int newPosition,
    required String projectId,
    required String newStepId,
  }) async {
    return await returnOne(() async {
      var newTaskModel = TaskModel.clone(task);
      newTaskModel.fkStepId = newStepId;
      newTaskModel.position = newPosition > 0 ? newPosition : 0;
      await taskServices.update(newTaskModel);
      return newTaskModel;
    });
  }

  Future<SingleDataResponse<TaskModel>> updateTask({
    required String id,
    required String name,
    required int value,
    String? description,
    bool isPinned = false,
    required String projectId,
    required String stepId,
  }) async {
    return await returnOne(() async {
      var model = TaskModel(
        id: id,
        name: name,
        value: value,
        isPinned: isPinned,
        description: description,
        fkProjectId: projectId,
        fkStepId: stepId,
      );
      await taskServices.update(model);
      return model;
    });
  }

  Future<QueryResponse> deleteTask(String id) async {
    return await returnNone(() async => await taskServices.hardDelete(id));
  }
}
