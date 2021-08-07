import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sessao.dart';
import '../providers/sessao_provider.dart';

class EditaSessaoScreen extends StatefulWidget {
  final Sessao sessao;

  EditaSessaoScreen({this.sessao});
  static const route = '/editasessao';

  @override
  _EditaSessaoScreenState createState() => _EditaSessaoScreenState();
}

class _EditaSessaoScreenState extends State<EditaSessaoScreen> {
  final nameController = TextEditingController();
  final fisioIdController = TextEditingController();
  final fisioNameController = TextEditingController();
  final pacienteNameController = TextEditingController();
  final pacienteCpfController = TextEditingController();
  final numeroSessoesController = TextEditingController();
  final descriptionController = TextEditingController();
  final exerciseUrlController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    fisioIdController.dispose();
    fisioNameController.dispose();
    pacienteNameController.dispose();
    pacienteCpfController.dispose();
    numeroSessoesController.dispose();
    descriptionController.dispose();
    exerciseUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final sessaoProvider = Provider.of<SessaoProvider>(context, listen: false);
    if (widget.sessao != null) {
      //Edita
      fisioIdController.text = widget.sessao.fisioId;
      fisioNameController.text = widget.sessao.fisioName;
      pacienteNameController.text = widget.sessao.pacienteName;
      pacienteCpfController.text = widget.sessao.pacienteCpf;
      numeroSessoesController.text = widget.sessao.numerosessoes.toString();
      descriptionController.text = widget.sessao.description;
      exerciseUrlController.text = widget.sessao.exerciseUrl;

      sessaoProvider.loadAll(widget.sessao);
    } else {
      //Mostra campos vazios
      sessaoProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sessaoProvider = Provider.of<SessaoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Sessão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: fisioIdController,
              decoration: InputDecoration(
                  labelText: 'ID do Fisioterapeuta',
                  hintText: 'Escreva o seu id'),
              onChanged: (String value) => sessaoProvider.changeFisioId = value,
            ),
            TextField(
              controller: fisioNameController,
              decoration: InputDecoration(
                  labelText: 'Nome do Fisioterapeuta',
                  hintText: 'Escreva o nome completo'),
              onChanged: (String value) =>
                  sessaoProvider.changeFisioName = value,
            ),
            TextField(
              controller: pacienteNameController,
              decoration: InputDecoration(
                  labelText: 'Nome do Paciente',
                  hintText: 'Escreva o nome completo'),
              onChanged: (String value) =>
                  sessaoProvider.changePacienteName = value,
            ),
            TextField(
              controller: pacienteCpfController,
              decoration: InputDecoration(
                  labelText: 'CPF Paciente',
                  hintText: 'Escreva o cpf do paciente'),
              onChanged: (String value) =>
                  sessaoProvider.changePacienteCpf = value,
            ),
            TextField(
              controller: numeroSessoesController,
              decoration: InputDecoration(
                  labelText: 'Número de sessões',
                  hintText:
                      'Escreva a quantidade de dias para fazer os exercícios'),
              onChanged: (String value) =>
                  sessaoProvider.changeNumeroSessoes = value,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
              maxLines: 10,
              minLines: 8,
              onChanged: (String value) => sessaoProvider.changeDesc = value,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'URL do vídeo do youtube',
                  hintText: 'http://www.youtube.com.br/'),
              onChanged: (String value) =>
                  sessaoProvider.changeExercise = value,
              controller: exerciseUrlController,
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Save', style: TextStyle(color: Colors.white)),
              onPressed: () {
                sessaoProvider.saveSessao();
                Navigator.of(context).pop();
              },
            ),
            (widget.sessao != null)
                ? RaisedButton(
                    color: Colors.red,
                    child:
                        Text('Delete', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      sessaoProvider.removeSessao(widget.sessao.sessaoId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
