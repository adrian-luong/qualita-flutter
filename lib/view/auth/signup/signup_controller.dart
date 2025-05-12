import 'package:firebase_auth/firebase_auth.dart';
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
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-_password':
          return 'The _password provided must be at least 6-character long';
        case '_email-already-in-use':
          return 'An account already exists for that email.';
        case 'invalid-email':
          return 'The email address is not valid.';
        default:
          return 'An error occurred. Please try again.';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
