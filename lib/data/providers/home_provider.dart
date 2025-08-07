import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/models/tag_model.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/providers/base_provider.dart';
import 'package:qualita/data/repositories/step_repository.dart';
import 'package:qualita/data/repositories/tag_repository.dart';
import 'package:qualita/data/repositories/task_repository.dart';

class HomeProvider extends BaseProvider {
  final _stepRepo = StepRepository();
  final _taskRepo = TaskRepository();
  final _tagRepo = TagRepository();

  String? selectedProject;
  String? selectedStep;

  List<StepModel> _steps = [];
  List<StepModel> get steps => _steps;
  List<String> _projectSteps = [];

  final Map<String, List<TaskModel>> _tasks = {};
  Map<String, List<TaskModel>> get tasks => _tasks;

  List<TagModel> _tags = [];
  List<TagModel> get tags => _tags;
  final Map<String, List<TagModel>> _taskTags = {};
  Map<String, List<TagModel>> get taskTags => _taskTags;

  void selectProject(String? id) {
    selectedProject = id;
    if (selectedProject != null) {
      fetchSteps();
      fetchTags();
    }
    notifyListeners();
  }

  void editStep(String? id) {
    selectedStep = id;
    notifyListeners();
  }

  Future<void> fetchSteps() async {
    await super.operate(() async {
      if (selectedProject != null) {
        // Get all steps
        final fetchStepResult = await _stepRepo.fetchSteps(selectedProject!);
        if (fetchStepResult.hasError) {
          throw Exception(fetchStepResult.message ?? 'Unexpected error');
        } else {
          _steps = fetchStepResult.data;
          _projectSteps = fetchStepResult.data.map((step) => step.id!).toList();

          // Get tasks for each steps
          await fetchTasks(null);
        }
      }
    });
  }

  Future<void> addStep({required String name}) async {
    await super.operate(() async {
      if (selectedProject != null) {
        var response = await _stepRepo.addStep(name, selectedProject!);
        if (response.hasError || response.data == null) {
          throw Exception(response.message ?? 'Unexpected error');
        } else {
          _steps.add(response.data!);
        }
      }
    });
  }

  Future<void> renameStep(String stepId, String newName) async {
    await super.operate(() async {
      if (selectedProject != null) {
        var response = await _stepRepo.renameStep(
          stepId: stepId,
          newName: newName,
          projectId: selectedProject!,
        );
        if (response.hasError || response.data == null) {
          throw Exception(response.message ?? 'Unexpected error');
        } else {
          var correspondingStep = steps.firstWhere((step) => step.id == stepId);
          correspondingStep.name = newName;
        }
      }
    });
  }

  Future<void> reorderStep(int oldPosition, int newPosition) async {
    await super.operate(() async {
      var response = await _stepRepo.reorderStep(
        oldPosition,
        newPosition,
        steps,
      );
      if (response.hasError || response.data.isEmpty) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        _steps = response.data;
      }
    });
  }

  Future<void> fetchTasks(String? searchTerm) async {
    await super.operate(() async {
      if (_projectSteps.isNotEmpty) {
        for (var step in _projectSteps) {
          final fetchTaskResult = await _taskRepo.fetchTasks(
            selectedProject!,
            step,
            searchTerm,
          );
          if (fetchTaskResult.hasError) {
            throw Exception(fetchTaskResult.message ?? 'Unexpected error');
          } else {
            _tasks[step] = fetchTaskResult.data;
          }
        }
      }
    });
  }

  Future<void> addTask({
    required String name,
    required int value,
    String? description,
    required String stepId,
    required List<String> tags,
  }) async {
    await super.operate(() async {
      if (selectedProject != null) {
        var response = await _taskRepo.addTask(
          name: name,
          description: description,
          value: value,
          stepId: stepId,
          projectId: selectedProject!,
          selectedTags: tags,
        );

        if (response.hasError || response.data == null) {
          throw Exception(response.message ?? 'Unexpected error');
        } else if (_tasks[stepId] != null) {
          _tasks[stepId]!.add(response.data!);
        }
      }
    });
  }

  Future<void> reorderTask({
    required int oldPosition,
    required int newPosition,
    required String stepId,
  }) async {
    await super.operate(() async {
      if (_tasks[stepId] != null) {
        var response = await _taskRepo.reorderTask(
          oldPosition: oldPosition,
          newPosition: newPosition,
          taskList: _tasks[stepId]!,
        );
        if (response.hasError || response.data.isEmpty) {
          throw Exception(response.message ?? 'Unexpected error');
        } else {
          _tasks[stepId] = response.data;
        }
      }
    });
  }

  Future<void> pinTask(TaskModel task) async {
    await super.operate(() async {
      if (_tasks[task.fkStepId] != null) {
        var response = await _taskRepo.reorderTask(
          oldPosition: task.position,
          newPosition: 0,
          taskList: _tasks[task.fkStepId]!,
          isPinning: true,
        );
        if (response.hasError || response.data.isEmpty) {
          throw Exception(response.message ?? 'Unexpected error');
        } else {
          _tasks[task.fkStepId] = response.data;
        }
      }
    });
  }

  Future<void> unpinTask(String taskId, String stepId) async {
    await super.operate(() async {
      if (_tasks[stepId] != null) {
        var theTask = _tasks[stepId]!.firstWhere((task) => task.id == taskId);
        theTask.isPinned = false;

        var response = await _taskRepo.updateTask(
          id: theTask.id!,
          name: theTask.name,
          value: theTask.value,
          projectId: theTask.fkProjectId,
          stepId: theTask.fkStepId,
          isPinned: theTask.isPinned,
          newTags: theTask.tags,
          currentTags: theTask.tags,
        );

        if (response.hasError || response.data == null) {
          throw Exception(response.message ?? 'Unexpected error');
        }
      }
    });
  }

  Future<void> restepTask({
    required TaskModel task,
    required String newStepId,
  }) async {
    await super.operate(() async {
      var oldStepId = task.fkStepId;

      if (_tasks[oldStepId] != null &&
          _tasks[newStepId] != null &&
          selectedProject != null) {
        var newPosition = _tasks[newStepId]!.length;
        var response = await _taskRepo.restepTask(
          task: task,
          newPosition: newPosition,
          projectId: selectedProject!,
          newStepId: newStepId,
        );
        if (response.hasError || response.data == null) {
          throw Exception(response.message ?? 'Unexpected error');
        } else {
          var oldIndex = _tasks[oldStepId]!.indexWhere(
            (model) => task.id == response.data!.id,
          );
          if (oldIndex > -1) {
            _tasks[oldStepId]!.removeAt(oldIndex);
          }

          var newIndex = _tasks[newStepId]!.indexWhere(
            (model) => task.id == model.id,
          );
          if (newIndex == -1) {
            _tasks[newStepId]!.add(response.data!);
          }
        }

        // _tasks[task.fkStepId] = await _taskServices.getByProjectStep(
        //   selectedProject!,
        //   oldStepId,
        // );
        // _tasks[newStepId] = await _taskServices.getByProjectStep(
        //   selectedProject!,
        //   newStepId,
        // );
      }
    });
  }

  Future<void> updateTask({
    required String id,
    required String name,
    required int value,
    String? description,
    required List<String> currentTags,
    required List<String> newTags,
    required String stepId,
  }) async {
    await super.operate(() async {
      if (selectedProject != null) {
        var response = await _taskRepo.updateTask(
          id: id,
          name: name,
          value: value,
          projectId: selectedProject!,
          stepId: stepId,
          currentTags: currentTags,
          newTags: newTags,
        );
        if (response.hasError || response.data == null) {
          throw Exception(response.message ?? 'Unexpected error');
        } else if (_tasks[stepId] != null) {
          var targetIndex = _tasks[stepId]!.indexWhere((task) => task.id == id);
          _tasks[stepId]![targetIndex] = response.data!;
        }
      }
    });
  }

  Future<void> deleteTask(String id, String stepId) async {
    await super.operate(() async {
      var response = await _taskRepo.deleteTask(id);
      if (response.hasError) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        if (_tasks[stepId] != null) {
          var targetIndex = _tasks[stepId]!.indexWhere((task) => task.id == id);
          _tasks[stepId]!.removeAt(targetIndex);
        }
      }
    });
  }

  Future<void> fetchTags() async {
    await super.operate(() async {
      if (selectedProject != null) {
        var response = await _tagRepo.fetchTags(selectedProject!);
        if (response.hasError) {
          throw Exception(response.message ?? 'Unexpected error');
        } else {
          _tags = response.data;
        }
      }
    });
  }

  Future<void> addTag({required String name, String? description}) async {
    await super.operate(() async {
      if (selectedProject != null) {
        var response = await _tagRepo.addTag(
          name: name,
          description: description,
          projectId: selectedProject!,
        );
        if (response.hasError || response.data == null) {
          throw Exception(response.message ?? 'Unexpected error');
        } else {
          _tags.add(response.data!);
        }
      }
    });
  }

  Future<void> updateTag({
    required String id,
    required String name,
    String? description,
  }) async {
    await super.operate(() async {
      if (selectedProject != null) {
        var response = await _tagRepo.updateTag(
          id: id,
          name: name,
          description: description,
          projectId: selectedProject!,
        );
        if (response.hasError || response.data == null) {
          throw Exception(response.message ?? 'Unexpected error');
        } else {
          var targetIndex = _tags.indexWhere((tag) => tag.id == id);
          _tags[targetIndex] = response.data!;
        }
      }
    });
  }

  Future<void> deleteTag(String id) async {
    await super.operate(() async {
      var response = await _tagRepo.deleteTag(id);
      if (response.hasError) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        var targetIndex = _tags.indexWhere((tag) => tag.id == id);
        _tags.removeAt(targetIndex);
      }
    });
  }
}
