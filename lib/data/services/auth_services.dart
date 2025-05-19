import 'package:firebase_auth/firebase_auth.dart';
import 'package:qualita/data/models/user_model.dart';
import 'package:qualita/data/services/user_services.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _services = UserServices();

  Future<void> signup(String email, String username, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      User? firebaseUser = cred.user;

      if (firebaseUser != null) {
        await _services.insert(
          UserModel(id: firebaseUser.uid, username: username, email: email),
        );
      } else {
        throw Exception('Unable to create user');
      }
    } catch (e) {
      throw Exception('Unable to create user: ${e.toString()}');
    }
  }

  Future<void> signin(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      User? firebaseUser = cred.user;

      if (firebaseUser == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }
    } catch (e) {
      throw Exception('Unable to login: ${e.toString()}');
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Stream<User?> onChange() {
    return _auth.authStateChanges();
  }
}
