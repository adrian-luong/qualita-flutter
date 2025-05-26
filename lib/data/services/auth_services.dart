import 'package:qualita/global_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final _auth = supabase.auth;

  Future<void> signup(String email, String username, String password) async {
    try {
      AuthResponse response = await _auth.signUp(
        email: email.trim(),
        password: password,
        data: {'username': username},
      );

      if (response.user == null) {
        throw AuthException('Cannot create user');
      }
    } catch (e) {
      throw Exception('Unable to create user: ${e.toString()}');
    }
  }

  Future<void> signin(String email, String password) async {
    try {
      AuthResponse response = await _auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      if (response.user == null) {
        throw AuthException('User not found');
      }
    } catch (e) {
      throw Exception('Unable to login: ${e.toString()}');
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.resetPasswordForEmail(email);
  }

  User? isLoggedIn() {
    return _auth.currentUser;
  }

  Stream<AuthState> onChange() {
    return _auth.onAuthStateChange;
  }
}
