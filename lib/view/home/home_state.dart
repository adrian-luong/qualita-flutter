import 'package:flutter/material.dart';
import 'package:qualita/data/models/project_model.dart';

class HomeState extends ChangeNotifier {
  String? selectedProject;
  String? editingStep;

  // Temporary storage of queried data
  List<ProjectModel> queriedProjects = [];
  List<StepModel> queriedSteps = [];

  void selectProject(String? id) {
    selectedProject = id;
    notifyListeners();
  }

  void editStep(String? id) {
    editingStep = id;
    notifyListeners();
  }

  void storeProjects(List<ProjectModel> data) {
    queriedProjects = data;
  }
}
