import 'package:flutter/material.dart';
import 'package:qualita/data/services/auth_services.dart';

class ResetPasswordController {
  final _services = AuthServices();
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  void dispose() {
    email.dispose();
  }

  Future<String> resetPassword() async {
    try {
      await _services.resetPassword(email.text.trim());
      formKey.currentState?.reset();
      email.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }
}
