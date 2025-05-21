import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qualita/data/models/project_model.dart';

class ProjectServices {
  final _firestore = FirebaseFirestore.instance
      .collection('projects')
      .withConverter(
        fromFirestore: (snapshot, _) => ProjectModel.fromSnapshot(snapshot),
        toFirestore: (model, _) => model.toJSON(),
      );

  Future<ProjectModel?> find(String projectId) async {
    try {
      var snapshot = await _firestore.doc(projectId).get();
      return snapshot.exists ? snapshot.data() : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insert(ProjectModel project) async {
    try {
      await _firestore.add(project);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProjectModel>> list() async {
    try {
      var snapshot = await _firestore.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      return [];
    }
  }

  Stream<QuerySnapshot<ProjectModel>> streamAll() {
    try {
      return _firestore.snapshots();
    } catch (e) {
      throw Exception(e);
    }
  }
}
