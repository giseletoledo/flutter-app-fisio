import 'package:crud_firestore/models/user_fisio.dart';
import 'package:crud_firestore/models/userfisio_manager.dart';
import 'package:flutter/material.dart';
import '../../helpers/validators.dart';

import 'package:provider/provider.dart';

import '../home_screen.dart';

class FisioLoginScreen extends StatefulWidget {
  const FisioLoginScreen({Key key}) : super(key: key);

  static final String route = 'fisiologin';

  @override
  _FisioLoginScreenState createState() => _FisioLoginScreenState();
}

class _FisioLoginScreenState extends State<FisioLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fisiobg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 250, 8, 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text('Fisio'),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                hintText: 'E-mail',
                                icon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              validator: (email) {
                                if (!emailValid(email))
                                  return 'E-mail inválido';
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 10.0,
                            ),
                            child: TextFormField(
                              controller: passController,
                              decoration: const InputDecoration(
                                hintText: 'Senha',
                                icon: Icon(Icons.lock),
                              ),
                              autocorrect: false,
                              obscureText: true,
                              validator: (pass) {
                                if (pass.isEmpty || pass.length < 6)
                                  return 'Senha inválida';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(38.0),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  context.read<UserFisioManager>().signIn(
                                        userfisio: UserFisio(
                                            email: emailController.text,
                                            password: passController.text),
                                        onFail: (e) {
                                          scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Falha ao cadastrar: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        },
                                        onSuccess: () {
                                          //debugPrint('sucesso');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                          'fisioterapeutas')));
                                        },
                                      );
                                }
                              },
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'fisiosignup');
                            },
                            child: new Text(
                              "Cadastre-se",
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 51, 1, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: new Text(
                              "Trocar de perfil",
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 51, 1, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
