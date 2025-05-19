import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qualita/data/models/project_model.dart';

class ProjectServices {
  final _firestore = FirebaseFirestore.instance.collection('projects');

  Future<ProjectModel?> find(String projectId) async {
    try {
      var snapshot = await _firestore.doc(projectId).get();
      return snapshot.exists ? ProjectModel.fromSnapshot(snapshot) : null;
    } catch (e) {
      return null;
    }
  }

  Future<void> insert(ProjectModel project) async {
    try {
      await _firestore.doc(project.id).set(project.toJSON());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProjectModel>> list() async {
    try {
      var snapshot = await _firestore.get();
      return snapshot.docs
          .map((doc) => ProjectModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAll() {
    try {
      var snapshot = _firestore.snapshots();
      return snapshot;
    } catch (e) {
      throw Exception(e);
    }
  }
}
