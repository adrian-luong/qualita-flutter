import 'package:flutter/material.dart';
import 'package:qualita/data/services/auth_services.dart';

class SignupController {
  final _services = AuthServices();
  final formKey = GlobalKey<FormState>();

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirm.dispose();
  }

  Future<String> signup() async {
    try {
      await _services.signup(email.text, username.text, password.text);
      formKey.currentState?.reset();
      username.clear();
      email.clear();
      password.clear();
      confirm.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }
}
