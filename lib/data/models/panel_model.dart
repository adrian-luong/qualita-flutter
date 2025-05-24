import 'package:cloud_firestore/cloud_firestore.dart';

class PanelModel {
  final Timestamp createdAt = Timestamp.now();
  final String name;
  final String project;

  PanelModel({required this.name, required this.project});
  factory PanelModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return PanelModel.fromJSON(data ?? {});
  }

  factory PanelModel.fromJSON(Map<String, dynamic> data) {
    return PanelModel(name: data['name'], project: data['project']);
  }

  Map<String, dynamic> toJSON() {
    return {'name': name, 'project': project, 'createdAt': createdAt};
  }
}
