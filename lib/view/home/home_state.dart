import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  String? selectedProject;
  void select(String? id) {
    selectedProject = id;
    // print('Selected project: $selectedProject');
    notifyListeners();
  }
}
