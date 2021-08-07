import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../helpers/validators.dart';
import '../../models/user_manager.dart';
import '../../models/user.dart';

class SignUpPacienteScreen extends StatefulWidget {
  static const route = 'pacientesignup';
  @override
  _SignUpPacienteScreenState createState() => _SignUpPacienteScreenState();
}

class _SignUpPacienteScreenState extends State<SignUpPacienteScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final UserFb user =
      UserFb(); //variável local não aplica na instância do firebase

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: 'Nome Completo'),
                          validator: (name) {
                            if (name.isEmpty)
                              return 'Campo obrigatório';
                            else if (name.trim().split(' ').length <= 1)
                              return 'Preencha seu nome completo';
                            return null;
                          },
                          onSaved: (name) => user.name = name,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(hintText: 'CPF'),
                          validator: (cpf) {
                            if (cpf.isEmpty) return 'Campo obrigatório';
                            return null;
                          },
                          onSaved: (cpf) => user.cpf = cpf,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(hintText: 'E-mail'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email.isEmpty)
                              return 'Campo obrigatório';
                            else if (!emailValid(email))
                              return 'E-mail inválido';
                            return null;
                          },
                          onSaved: (email) => user.email = email,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Número de telefone'),
                          validator: (telephone) {
                            if (telephone.isEmpty) return 'Campo obrigatório';
                            return null;
                          },
                          onSaved: (telephone) =>
                              user.telephone = int.parse(telephone),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(hintText: 'Senha'),
                          obscureText: true,
                          validator: (pass) {
                            if (pass.isEmpty)
                              return 'Campo obrigatório';
                            else if (pass.length < 6)
                              return 'Senha muito curta';
                            return null;
                          },
                          onSaved: (pass) => user.password = pass,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: 'Repita a Senha'),
                          obscureText: true,
                          validator: (pass) {
                            if (pass.isEmpty)
                              return 'Campo obrigatório';
                            else if (pass.length < 6)
                              return 'Senha muito curta';
                            return null;
                          },
                          onSaved: (pass) => user.confirmPassword = pass,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 44,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            disabledColor:
                                Theme.of(context).primaryColor.withAlpha(100),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(38.0),
                            ),
                            textColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                if (user.password != user.confirmPassword) {
                                  scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Senhas não são idênticas!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                context.read<UserManagerPaciente>().signUp(
                                      userfb: user,
                                      onSuccess: () {
                                        Navigator.of(context)
                                            .pushNamed('pacientelogin');
                                        debugPrint('sucesso');
                                      },
                                      onFail: (e) {
                                        scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Falha ao cadastrar: $e'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                    );
                              }
                            },
                            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                            child: const Text(
                              'Criar Conta',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 44,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              disabledColor:
                                  Theme.of(context).primaryColor.withAlpha(100),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(38.0),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('pacientelogin');
                              },
                              padding:
                                  const EdgeInsets.fromLTRB(24, 12, 24, 12),
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
