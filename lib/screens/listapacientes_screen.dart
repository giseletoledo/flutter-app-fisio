import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore/models/user.dart';
import 'package:crud_firestore/models/user_manager.dart';
import 'package:flutter/material.dart';

class PacientesFisioScreen extends StatefulWidget {
  PacientesFisioScreen({Key key}) : super(key: key);

  @override
  _PacientesFisioScreenState createState() => _PacientesFisioScreenState();
}

class _PacientesFisioScreenState extends State<PacientesFisioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pacientes cadastrados'),
        ),
        body: StreamBuilder<List<UserFb>>(
          stream: FirebaseFirestore.instance
              .collection('pacientes')
              .snapshots()
              .map((snapshot) => snapshot.docs
                  .map((doc) => UserFb.fromJson(doc.data()))
                  .toList()),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Expanded(
                child: Center(
                  child: Text('Dados não puderam ser carregados'),
                ),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (!snapshot.hasData) {
                  return Text('Nenhum paciente cadastrado');
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data != null) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(
                              color: Color.fromRGBO(202, 15, 15, 1),
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.description_sharp,
                            color: Color.fromRGBO(202, 15, 15, 1),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Nome do paciente: ${snapshot.data[index].name}'),
                              Text(
                                  'CPF do paciente: ${snapshot.data[index].cpf}'),
                            ],
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("email:"),
                              Text(snapshot.data[index].email)
                            ],
                          ),
                          onTap: () {},
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
            }
          },
        ));
  }
}
