import 'package:flutter/material.dart';
import 'package:qualita/data/services/auth_services.dart';

class SigninController {
  final _services = AuthServices();

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  void dispose() {
    email.dispose();
    password.dispose();
  }

  Future<String> signin() async {
    try {
      await _services.signin(email.text, password.text);
      formKey.currentState?.reset();
      email.clear();
      password.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }
}
