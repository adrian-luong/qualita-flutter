import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/providers/base_provider.dart';
import 'package:qualita/data/services/project_services.dart';
import 'package:qualita/data/services/step_services.dart';
import 'package:qualita/data/services/task_services.dart';
import 'package:qualita/global_keys.dart';

class HomeProvider extends BaseProvider {
  final _projectServices = ProjectServices();
  final _stepServices = StepServices();
  final _taskServices = TaskServices();

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
    await super.operate(() async {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('No user has logged in');
      }
      final fetchResult = await _projectServices.fetchForUser(user.id);
      _projects = fetchResult;
    });
  }

  Future<void> addProject({required String name, String? description}) async {
    await super.operate(() async {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('No user has logged in');
      }
      var model = ProjectModel(
        name: name,
        fkUserId: user.id,
        description: description,
      );
      var newProject = await _projectServices.insert(model);
      if (newProject.id == null) {
        throw Exception('Project ID cannot be set');
      }

      // Create 3 new default task panels for every new project created
      await _stepServices.insert(
        StepModel(name: 'To-Do', fkProjectId: newProject.id!),
      );
      await _stepServices.insert(
        StepModel(name: 'Doing', fkProjectId: newProject.id!),
      );
      await _stepServices.insert(
        StepModel(name: 'Done', fkProjectId: newProject.id!),
      );

      _projects.add(newProject); // Add the new todo to the local list
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
      List<StepModel> newOrder = List.from(steps);
      newOrder.sort((a, b) => a.position.compareTo(b.position));

      if (oldPosition < newPosition) {
        newPosition -= 1;
      }
      final reorderTarget = newOrder.removeAt(oldPosition);
      newOrder.insert(newPosition, reorderTarget);

      newOrder.asMap().forEach((index, item) => item.position = index);
      newOrder.sort((a, b) => a.position.compareTo(b.position));
      await _stepServices.reposition(newOrder);
      _steps = newOrder;
    });
  }
}
