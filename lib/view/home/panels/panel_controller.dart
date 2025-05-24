import 'package:flutter/material.dart';
import 'package:qualita/data/models/panel_model.dart';
import 'package:qualita/data/services/panel_services.dart';

class PanelController {
  final _services = PanelServices();
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();

  void dispose() {
    name.dispose();
  }

  Future<String> addPanel(String projectId) async {
    try {
      await _services.insert(
        PanelModel(name: name.text.trim(), project: projectId),
      );
      formKey.currentState?.reset();
      name.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }
}
