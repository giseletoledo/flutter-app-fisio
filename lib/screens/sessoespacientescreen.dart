import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/sessao.dart';
import 'detalhesessao_screen.dart';

class SessoesPacienteScreen extends StatefulWidget {
  static const route = 'sessaopaciente';

  @override
  _SessoesPacienteScreenState createState() => _SessoesPacienteScreenState();
}

class _SessoesPacienteScreenState extends State<SessoesPacienteScreen> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    print(arguments);
    final _cpf = arguments['cpf'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Sessões'),
      ),
      body: StreamBuilder<List<Sessao>>(
          stream: _cpf != null
              ? FirebaseFirestore.instance
                  .collection('sessoes')
                  .where("pacienteCpf", isEqualTo: _cpf)
                  .snapshots()
                  .map((snapshot) => snapshot.docs
                      .map((doc) => Sessao.fromJson(doc.data()))
                      .toList())
              : null,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Expanded(
                child: Center(
                  child: Text('Dados não puderam ser carregados'),
                ),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data == null) {
                      return Center(
                        child: Container(
                          child: Text('Sem registros'),
                        ),
                      );
                    } else {
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
                          trailing: Icon(Icons.visibility,
                              color: Theme.of(context).accentColor),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Nome do paciente: ${snapshot.data[index].pacienteName}'),
                              Text(
                                  'CPF do paciente: ${snapshot.data[index].pacienteCpf}'),
                            ],
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ID da Sessão:"),
                              Text(snapshot.data[index].sessaoId)
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetalheSessaoScreen(
                                      sessao: snapshot.data[index],
                                    )));
                          },
                        ),
                      );
                    }
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
