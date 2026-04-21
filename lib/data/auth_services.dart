import 'package:qualita/global_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  static final _auth = supabase.auth;

  static Future<void> signup(
    String email,
    String username,
    String password,
  ) async {
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

  static Future<void> signin(String email, String password) async {
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

  static Future<void> resetPassword(String email) async {
    await _auth.resetPasswordForEmail(email);
  }

  static Future<void> changePassword(String newPassword) async {
    final response = await _auth.updateUser(
      UserAttributes(password: newPassword),
    );
    final User? updatedUser = response.user;
    if (updatedUser == null) {
      throw Exception(
        'Failed to update password. User not found or not authenticated.',
      );
    }
  }

  static Future<void> signout() async {
    await _auth.signOut();
  }

  static Stream<AuthState> get stream => _auth.onAuthStateChange;
}
