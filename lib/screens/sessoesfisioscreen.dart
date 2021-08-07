import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sessao_provider.dart';
import '../models/sessao.dart';
import 'addeditsessao_screen.dart';

class SessoesFisioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessaoProvider = Provider.of<SessaoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sessões'),
      ),
      body: StreamBuilder<List<Sessao>>(
          stream: sessaoProvider.sessoes,
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
                  return Text('Nenhuma sessão cadastrada');
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
                          trailing: Icon(Icons.edit,
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditaSessaoScreen(
                                  sessao: snapshot.data[index],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditaSessaoScreen()));
        },
      ),
    );
  }
}
