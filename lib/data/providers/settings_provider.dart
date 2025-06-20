import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  Brightness _mode =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  Brightness get colorMode => _mode;

  void setMode(Brightness newMode) {
    _mode = newMode;
    notifyListeners();
  }
}
