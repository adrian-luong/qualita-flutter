import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qualita/data/models/user_model.dart';

class UserServices {
  final _firestore = FirebaseFirestore.instance.collection('users');

  Future<UserModel?> find(String userId) async {
    try {
      var snapshot = await _firestore.doc(userId).get();
      return snapshot.exists ? UserModel.fromSnapshot(snapshot) : null;
    } catch (e) {
      return null;
    }
  }

  Future<void> insert(UserModel user) async {
    try {
      await _firestore.doc(user.id).set(user.toJSON());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserModel>> list() async {
    try {
      var snapshot = await _firestore.get();
      return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    } catch (e) {
      return [];
    }
  }
}
