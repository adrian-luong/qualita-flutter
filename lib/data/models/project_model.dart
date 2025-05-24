import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String title;
  final String? description;
  final Timestamp createdAt = Timestamp.now();

  ProjectModel({required this.title, this.description});

  factory ProjectModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return ProjectModel.fromJSON(data ?? {});
  }

  factory ProjectModel.fromJSON(Map<String, dynamic> data) {
    return ProjectModel(title: data['title'], description: data['description']);
  }

  Map<String, dynamic> toJSON() {
    return {'title': title, 'description': description, 'createdAt': createdAt};
  }
}
