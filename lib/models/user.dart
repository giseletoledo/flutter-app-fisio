import 'package:cloud_firestore/cloud_firestore.dart';

class UserFb {
  //construtor da classe de usuário
  UserFb(
      {this.name,
      this.cpf,
      this.email,
      this.telephone,
      this.password,
      this.admin,
      this.id});

  UserFb.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.data()['name'] ?? '';
    cpf = document.data()['cpf'] ?? '';
    email = document.data()['email'] ?? '';
    telephone = document.data()['telephone'] ?? '';
    admin = document.data()['admin'] ?? 'false';
  }

  String id;
  String name;
  String cpf;
  String email;
  int telephone;
  String password;
  bool admin;

  String confirmPassword;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('pacientes/$id');

  //salvando os dados no firebase
  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  //cria um mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'cpf': cpf,
      'telephone': telephone,
      'admin': false
    };
  }

  factory UserFb.fromJson(Map<String, dynamic> json) {
    return UserFb(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        cpf: json['cpf'],
        telephone: json['telephone']);
  }
}
