import 'package:firebase_auth/firebase_auth.dart';
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
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found' || 'wrong-password' || 'invalid-credential':
          return 'Invalid email or password.';
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
