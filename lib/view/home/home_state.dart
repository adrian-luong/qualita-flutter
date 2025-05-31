import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  String? selectedProject;
  void selectProject(String? id) {
    selectedProject = id;
    notifyListeners();
  }

    notifyListeners();
  }
}
