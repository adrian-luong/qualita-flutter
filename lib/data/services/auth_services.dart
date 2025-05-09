import 'package:firebase_auth/firebase_auth.dart';
import 'package:qualita/data/models/user_model.dart';
import 'package:qualita/data/services/user_services.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _services = UserServices();

  Future<void> signup(
    String email,
    String username,
    String password,
    Function onSuccess,
  ) async {
    // 1. Create user with Firebase Authentication
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    User? firebaseUser = cred.user;

    if (firebaseUser != null) {
      // 2. Store additional user details in Firestore
      await _services.insert(
        UserModel(id: firebaseUser.uid, username: username, email: email),
      );
    }
    onSuccess();
  }

  Future<void> signin(String email, String password, Function onSuccess) async {
    // 1. Sign in user with Firebase Authentication
    UserCredential cred = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    User? firebaseUser = cred.user;

    if (firebaseUser != null) {
      onSuccess();
    }
  }
}
