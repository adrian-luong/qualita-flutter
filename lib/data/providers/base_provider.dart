import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void startOperation() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify listeners that loading has started
  }

  void handleError(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners(); // Notify listeners about the error
  }

  void endOperation() {
    _isLoading = false;
    notifyListeners(); // Notify listeners about the new todo
  }
}
