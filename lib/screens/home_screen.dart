import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/fisiologin_screen.dart';
import 'login/pacientelogin_screen.dart';
import 'profile_fisio_screen.dart';
import 'profile_paciente_screen.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  final String usertype;
  HomeScreen(this.usertype, {Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            if (widget.usertype == 'fisioterapeutas') {
              return ProfileFisioScreen();
            } else if (widget.usertype == 'pacientes') {
              return ProfilePacienteScreen();
            }
            print('Dados${snapshot.data.uid}');
            //print('Tipo de usuário: ${widget.usertype}');
          } else if (widget.usertype == 'fisioterapeutas') {
            return FisioLoginScreen();
          } else {
            return PacienteLoginScreen();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
/* 
  Center checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot.data['role'] == 'admin') {
      return adminPage(snapshot);
    } else {
      return userPage(snapshot);
    }
  } */

  /*  Center adminPage(DocumentSnapshot snapshot) {
    return Center(
        child: Text('${snapshot.data['role']} ${snapshot.data['name']}'));
  } */

/*   Center userPage(DocumentSnapshot snapshot) {
    return Center(child: Text(snapshot.data['name']));
  } */
}
