import 'package:flutter/material.dart';
import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/services/project_services.dart';
import 'package:qualita/data/services/step_services.dart';
import 'package:qualita/global_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectProvider extends ChangeNotifier {
  final _projectServices = ProjectServices();
  final _stepServices = StepServices();

  List<ProjectModel> _projects = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProjectModel> get projects => _projects;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Constructor to fetch initial data
  ProjectProvider() {
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify listeners that loading has started

    try {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('No user has logged in');
      }

      final fetchResult = await _projectServices.fetchForUser(user.id);
      _projects = fetchResult;
      notifyListeners(); // Notify listeners that data has been fetched
    } on PostgrestException catch (e) {
      _errorMessage = e.message;
      notifyListeners(); // Notify listeners about the error
    } catch (e) {
      _errorMessage =
          'An unexpected error occurred while fetching projects: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProject(String name, String? description) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners(); // Notify listeners that loading has started

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
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred while inserting : $e';
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners about the new todo
    }
  }
}
