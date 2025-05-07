import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String username;
  final String email;
  final Timestamp createdAt = Timestamp.now();

  UserModel({this.id, required this.username, required this.email});

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserModel.fromJSON(snapshot.id, data ?? {});
  }

  factory UserModel.fromJSON(String? id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      username: data['username'] as String? ?? '',
      email: data['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'createdAt': createdAt,
    };
  }
}
