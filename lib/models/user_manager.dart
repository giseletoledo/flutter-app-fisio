import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helpers/firebase_erros.dart';

import '../models/user.dart';

class UserManagerPaciente extends ChangeNotifier {
  UserManagerPaciente() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserFb user; //Usuário do firebase

  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  bool admin = true;

  Future<void> signIn(
      {UserFb userfb, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: userfb.email,
          password: userfb.password); //Usuário da classe user.dart

      await _loadCurrentUser(firebaseUser: result.user); //

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp(
      {UserFb userfb, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: userfb.email, password: userfb.password);

      userfb.id = result.user.uid;
      this.user = user;

      //print(result);

      await userfb.saveData(); //salva os dados do usuário

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      //user = currentUser;
      //print(user.uid);
      final DocumentSnapshot docUser =
          await firestore.collection('pacientes').doc(currentUser.uid).get();
      user = UserFb.fromDocument(docUser);
      notifyListeners();
    }
  }
}
