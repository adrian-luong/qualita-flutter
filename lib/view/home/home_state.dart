import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  String? selectedProject;
  String? editingStep;

  void selectProject(String? id) {
    selectedProject = id;
    notifyListeners();
  }

  void editStep(String? id) {
    editingStep = id;
    notifyListeners();
  }
}
