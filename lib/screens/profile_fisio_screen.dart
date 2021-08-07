import 'package:crud_firestore/models/userfisio_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'usertype_screen.dart';

class ProfileFisioScreen extends StatefulWidget {
  ProfileFisioScreen({Key key}) : super(key: key);

  @override
  _ProfileFisioScreenState createState() => _ProfileFisioScreenState();
}

class _ProfileFisioScreenState extends State<ProfileFisioScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      child: Consumer<UserFisioManager>(
        builder: (_, userManager, __) {
          if (userManager.adminEnabled) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Área do fisioterapeuta',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Olá, ${userManager.user?.name ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
                            Navigator.pushNamed(context, 'homefisio');
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "Administrar Sessões",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      )
                    : Container(),
                GestureDetector(
                  onTap: () {
                    if (userManager.isLoggedIn) {
                      userManager.signOut();
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => UserTypeScreen()));
                    } else {
                      Navigator.of(context).pop('fisiologin');
                    }
                  },
                  child: Text(
                    userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se >',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child:
                  Text('Você não é fisioterapeuta, acesse a área de paciente'),
            );
          }
        },
      ),
    );
  }
}
