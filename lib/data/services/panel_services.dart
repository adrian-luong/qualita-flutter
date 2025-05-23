import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qualita/data/models/panel_model.dart';

class PanelServices {
  final _firestore = FirebaseFirestore.instance
      .collection('panels')
      .withConverter(
        fromFirestore: (snapshot, _) => PanelModel.fromSnapshot(snapshot),
        toFirestore: (model, _) => model.toJSON(),
      );

  Future<PanelModel?> find(String panelId) async {
    try {
      var snapshot = await _firestore.doc(panelId).get();
      return snapshot.exists ? snapshot.data() : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insert(PanelModel project) async {
    try {
      await _firestore.add(project);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PanelModel>> list() async {
    try {
      var snapshot = await _firestore.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      return [];
    }
  }

  Stream<QuerySnapshot<PanelModel>> streamAll() {
    try {
      return _firestore.snapshots();
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<QuerySnapshot<PanelModel>> streamByProject(String projectId) {
    try {
      return _firestore.where('project', isEqualTo: projectId).snapshots();
    } catch (e) {
      throw Exception(e);
    }
  }
}
