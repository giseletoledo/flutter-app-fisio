import 'package:cloud_firestore/cloud_firestore.dart';

class UserFisio {
  //construtor da classe de usuário
  UserFisio(
      {this.email,
      this.password,
      this.name,
      this.crefito,
      this.telephone,
      this.admin,
      this.id});

  UserFisio.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.data()['name'] ?? '';
    email = document.data()['email'] ?? '';
    crefito = document.data()['crefito'] ?? '';
    telephone = document.data()['telephone'] ?? '';
    admin = document.data()['admin'] ?? 'true';
  }

  String id;
  String name;
  String crefito;
  String email;
  int telephone;
  String password;

  bool admin;

  String confirmPassword;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('fisioterapeutas/$id');

  //salvando os dados no firebase
  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  //cria um mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'crefito': crefito,
      'telephone': telephone,
      'admin': true
    };
  }
}
