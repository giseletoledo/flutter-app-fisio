import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/sessao.dart';

class DetalheSessaoScreen extends StatefulWidget {
  final Sessao sessao;

  DetalheSessaoScreen({this.sessao});
  static const route = '/detalhesessao';

  @override
  _DetalheSessaoScreenState createState() => _DetalheSessaoScreenState();
}

class _DetalheSessaoScreenState extends State<DetalheSessaoScreen> {
  Future<void> _launched;
  @override
  Widget build(BuildContext context) {
    var _launchUrl = widget.sessao.exerciseUrl;

    Future<void> _launchInBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sessão'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: _launched,
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: Text('Dados não puderam ser carregados'),
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome: ${widget.sessao.pacienteName}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'CPF: ${widget.sessao.pacienteCpf}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Fisioterapeuta: ${widget.sessao.fisioName}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Número de sessões: ${widget.sessao.numerosessoes.toString()}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Instruções: ${widget.sessao.description}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(38.0),
                      ),
                      child: const Text(
                        'Assistir ao vídeo',
                        style:
                            TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                      onPressed: () {
                        setState(() {
                          _launched = _launchInBrowser(_launchUrl);
                        });
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
