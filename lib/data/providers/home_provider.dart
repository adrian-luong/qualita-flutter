import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/providers/base_provider.dart';
import 'package:qualita/data/services/project_services.dart';
import 'package:qualita/data/services/step_services.dart';
import 'package:qualita/global_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeProvider extends BaseProvider {
  final _projectServices = ProjectServices();
  final _stepServices = StepServices();

  List<ProjectModel> _projects = [];
  List<ProjectModel> get projects => _projects;
  String? selectedProject;

  List<StepModel> _steps = [];
  List<StepModel> get steps => _steps;
  String? editingStep;

  // Constructor to fetch initial data
  HomeProvider() {
    fetchProjects();
  }

  void selectProject(String? id) {
    selectedProject = id;
    if (id != null) {
      fetchSteps(id);
    }
    notifyListeners();
  }

  void editStep(String? id) {
    editingStep = id;
    notifyListeners();
  }

  Future<void> fetchProjects() async {
    super.startOperation();
    try {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('No user has logged in');
      }

      final fetchResult = await _projectServices.fetchForUser(user.id);
      _projects = fetchResult;
      notifyListeners(); // Notify listeners that data has been fetched
    } on PostgrestException catch (e) {
      super.handleError(e.message);
    } catch (e) {
      var msg = 'An unexpected error occurred while fetching projects: $e';
      super.handleError(msg);
    } finally {
      super.endOperation();
    }
  }

  Future<void> addProject({required String name, String? description}) async {
    try {
      super.startOperation();

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
    } on PostgrestException catch (e) {
      super.handleError(e.message);
    } catch (e) {
      var message = 'An unexpected error occurred while inserting : $e';
      super.handleError(message);
    } finally {
      super.endOperation();
    }
  }

  Future<void> fetchSteps(String projectId) async {
    super.startOperation();
    try {
      final fetchResult = await _stepServices.getByProject(projectId);
      _steps = fetchResult;
      notifyListeners(); // Notify listeners that data has been fetched
    } on PostgrestException catch (e) {
      super.handleError(e.message);
    } catch (e) {
      var msg =
          'An unexpected error occurred while fetching steps from project (id=$projectId): $e';
      super.handleError(msg);
    } finally {
      super.endOperation();
    }
  }
}
