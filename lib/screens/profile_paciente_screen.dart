import 'package:crud_firestore/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sessoespacientescreen.dart';

class ProfilePacienteScreen extends StatefulWidget {
  ProfilePacienteScreen({Key key}) : super(key: key);

  @override
  _ProfilePacienteScreenState createState() => _ProfilePacienteScreenState();
}

class _ProfilePacienteScreenState extends State<ProfilePacienteScreen> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.8, //ocupa 80% da tela
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      child: Consumer<UserManagerPaciente>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Área do paciente',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Olá, ${userManager.user?.name ?? 'Visitante'}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              userManager.isLoggedIn
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(38.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, SessoesPacienteScreen.route,
                              arguments: {'cpf': userManager.user.cpf});
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Minhas sessões",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    if (userManager.isLoggedIn) {
                      userManager.signOut();
                    } else {
                      Navigator.of(context).pushNamed('pacientelogin');
                    }
                  },
                  child: Text(
                    userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se >',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
