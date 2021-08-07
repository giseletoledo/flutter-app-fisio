import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore/models/user.dart';
import '../models/sessao.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  UserFb user2;

  Stream<List<Sessao>> getSessoes() {
    return _db.collection('sessoes').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Sessao.fromJson(doc.data())).toList());
  }

  Future<void> setSessao(Sessao sessao) {
    var options = SetOptions(merge: true);
    return _db
        .collection('sessoes')
        .doc(sessao.sessaoId)
        .set(sessao.toMap(), options);
  }

  Future<void> removeSessao(String sessaoId) {
    return _db.collection('sessoes').doc(sessaoId).delete();
  }
}
