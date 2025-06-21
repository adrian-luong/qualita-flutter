import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/providers/base_provider.dart';
import 'package:qualita/data/repositories/project_repository.dart';
import 'package:qualita/data/services/step_services.dart';
import 'package:qualita/data/services/task_services.dart';
import 'package:qualita/utils/common_functions.dart';

class HomeProvider extends BaseProvider {
  final _stepServices = StepServices();
  final _taskServices = TaskServices();

  final _projectRepo = ProjectRepository();

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
      var response = await _projectRepo.fetch();
      if (response.hasError) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        _projects = response.data;
      }
    });
  }

  Future<void> addProject({required String name, String? description}) async {
    await operate(() async {
      var response = await _projectRepo.add(
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
        final fetchResult = await _stepServices.getByProject(selectedProject!);
        _steps = fetchResult;

        // Get tasks for each steps
        for (var step in fetchResult) {
          final queriedTasks = await _taskServices.getByProjectStep(
            selectedProject!,
            step.id!,
          );
          _tasks[step.id!] = queriedTasks;
        }
      }
    });
  }

  Future<void> addStep({required String name}) async {
    await super.operate(() async {
      if (selectedProject != null) {
        var newStep = await _stepServices.insert(
          StepModel(name: name, fkProjectId: selectedProject!),
        );
        _steps.add(newStep);
      }
    });
  }

  Future<void> renameStep(String stepId, String newName) async {
    await super.operate(() async {
      if (selectedProject != null) {
        await _stepServices.update(
          StepModel(id: stepId, name: newName, fkProjectId: selectedProject!),
        );
        var correspondingStep = steps.firstWhere((step) => step.id == stepId);
        correspondingStep.name = newName;
      }
    });
  }

  Future<void> reorderStep(int oldPosition, int newPosition) async {
    await super.operate(() async {
      List<StepModel> newOrder = reorder(
        oldPosition: oldPosition,
        newPosition: newPosition,
        oldOrder: steps,
      );
      await _stepServices.reposition(newOrder);
      _steps = newOrder;
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
        var model = TaskModel(
          name: name,
          value: value,
          description: description,
          fkProjectId: selectedProject!,
          fkStepId: stepId,
        );
        await _taskServices.insert(model);

        if (_tasks[stepId] != null) {
          _tasks[stepId]!.add(model);
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
        List<TaskModel> newOrder = reorder(
          oldPosition: oldPosition,
          newPosition: newPosition,
          oldOrder: _tasks[stepId]!,
        );
        await _taskServices.reposition(newOrder);
        _tasks[stepId] = newOrder;
      }
    });
  }

  Future<void> restepTask({
    required TaskModel task,
    required String newStepId,
  }) async {
    await super.operate(() async {
      if (_tasks[task.fkStepId] != null &&
          _tasks[newStepId] != null &&
          selectedProject != null) {
        var oldStepId = task.fkStepId;
        var newTaskModel = TaskModel(
          id: task.id,
          name: task.name,
          position: _tasks[newStepId]!.length - 1,
          description: task.description,
          fkProjectId: selectedProject!,
          fkStepId: newStepId,
        );
        await _taskServices.update(newTaskModel);

        _tasks[task.fkStepId] = await _taskServices.getByProjectStep(
          selectedProject!,
          oldStepId,
        );
        _tasks[newStepId] = await _taskServices.getByProjectStep(
          selectedProject!,
          newStepId,
        );
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
        var model = TaskModel(
          id: id,
          name: name,
          value: value,
          description: description,
          fkProjectId: selectedProject!,
          fkStepId: stepId,
        );
        await _taskServices.update(model);

        if (_tasks[stepId] != null) {
          var targetIndex = _tasks[stepId]!.indexWhere((task) => task.id == id);
          _tasks[stepId]![targetIndex] = model;
        }
      }
    });
  }

  Future<void> deleteTask(String id, String stepId) async {
    await super.operate(() async {
      await _taskServices.hardDelete(id);
      if (_tasks[stepId] != null) {
        var targetIndex = _tasks[stepId]!.indexWhere((task) => task.id == id);
        _tasks[stepId]!.removeAt(targetIndex);
      }
    });
  }
}
