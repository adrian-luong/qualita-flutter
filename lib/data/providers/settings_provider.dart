import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  Brightness _mode =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  Brightness get colorMode => _mode;

  void setMode(Brightness newMode) {
    _mode = newMode;
    notifyListeners();
  }

  void switchMode() {
    switch (_mode) {
      case Brightness.light:
        _mode = Brightness.dark;
        break;
      case Brightness.dark:
        _mode = Brightness.light;
        break;
    }
    notifyListeners();
  }

  bool isDarkMode() => _mode == Brightness.dark;
}
