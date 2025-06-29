import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/providers/base_provider.dart';
import 'package:qualita/data/repositories/project_repository.dart';
import 'package:qualita/data/repositories/step_repository.dart';
import 'package:qualita/data/repositories/task_repository.dart';

class HomeProvider extends BaseProvider {
  final _projectRepo = ProjectRepository();
  final _stepRepo = StepRepository();
  final _taskRepo = TaskRepository();

  List<ProjectModel> _projects = [];
  List<ProjectModel> get projects => _projects;
  String? selectedProject;

  List<StepModel> _steps = [];
  List<StepModel> get steps => _steps;
  String? selectedStep;

  final Map<String, List<TaskModel>> _tasks = {};
  Map<String, List<TaskModel>> get tasks => _tasks;

  // Constructor to fetch initial data
  HomeProvider() {
    fetchProjects();
  }

  void selectProject(String? id) {
    selectedProject = id;
    if (selectedProject != null) {
      fetchSteps();
    }
    notifyListeners();
  }

  void editStep(String? id) {
    selectedStep = id;
    notifyListeners();
  }

  Future<void> fetchProjects() async {
    await operate(() async {
      var response = await _projectRepo.fetchProjects();
      if (response.hasError) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        _projects = response.data;
      }
    });
  }

  Future<void> addProject({required String name, String? description}) async {
    await operate(() async {
      var response = await _projectRepo.addProject(
        name: name,
        description: description,
      );
      if (response.hasError || response.data == null) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        _projects.add(response.data!); // Add the new todo to the local list
      }
    });
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
        }

        // Get tasks for each steps
        for (var step in fetchStepResult.data) {
          final fetchTaskResult = await _taskRepo.fetchTasks(
            selectedProject!,
            step.id!,
          );
          if (fetchTaskResult.hasError) {
            throw Exception(fetchTaskResult.message ?? 'Unexpected error');
          } else {
            _tasks[step.id!] = fetchTaskResult.data;
          }
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

  Future<void> addTask({
    required String name,
    required int value,
    String? description,
    required String stepId,
  }) async {
    await super.operate(() async {
      if (selectedProject != null) {
        var response = await _taskRepo.addTask(
          name: name,
          description: description,
          value: value,
          stepId: stepId,
          projectId: selectedProject!,
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
}
