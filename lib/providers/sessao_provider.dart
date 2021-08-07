import 'package:crud_firestore/models/user.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import '../services/firestore_service.dart';
import '../models/sessao.dart';

class SessaoProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  UserFb userfilter;

  String _sessaoId;
  String _fisioId;
  String _fisioName;
  String _pacienteName;
  String _pacienteCpf;
  int _numerosessoes;
  String _description;
  String _exerciseUrl;
  var uuid = Uuid();

  //Getters
  String get fisioId => _fisioId;
  String get fisioName => _fisioName;
  String get pacienteName => _pacienteName;
  String get pacienteCpf => _pacienteCpf;
  int get numerosessoes => _numerosessoes;
  String get description => _description;
  String get exerciseUrl => _exerciseUrl;
  Stream<List<Sessao>> get sessoes => firestoreService.getSessoes();

  //Setters
  set changeFisioId(String fisioId) {
    _fisioId = fisioId;
    notifyListeners();
  }

  set changeFisioName(String fisioName) {
    _fisioName = fisioName;
    notifyListeners();
  }

  set changePacienteName(String pacienteName) {
    _pacienteName = pacienteName;
    notifyListeners();
  }

  set changePacienteCpf(String pacienteCpf) {
    _pacienteCpf = pacienteCpf;
    notifyListeners();
  }

  set changeNumeroSessoes(String numerosessoes) {
    _numerosessoes = int.parse(numerosessoes);
    notifyListeners();
  }

  set changeDesc(String value) {
    _description = value;
    notifyListeners();
  }

  set changeExercise(String value) {
    _exerciseUrl = value;
    notifyListeners();
  }

//Funções
  loadAll(Sessao sessao) {
    print(UserFb);
    if (sessao != null) {
      _fisioId = sessao.fisioId;
      _fisioName = sessao.fisioName;
      _pacienteName = sessao.pacienteName;
      _pacienteCpf = sessao.pacienteCpf;
      _numerosessoes = sessao.numerosessoes;
      _description = sessao.description;
      _exerciseUrl = sessao.exerciseUrl;
      _sessaoId = sessao.sessaoId;
    } else {
      _fisioId = null;
      _fisioName = null;
      _pacienteName = null;
      _pacienteCpf = null;
      _numerosessoes = null;
      _description = null;
      _exerciseUrl = null;
      _sessaoId = null;
    }
  }

  saveSessao() {
    print("$_sessaoId,$_fisioName");
    //Adiciona
    if (_sessaoId == null) {
      var novaSessao = Sessao(
          fisioId: _fisioId,
          fisioName: _fisioName,
          pacienteName: _pacienteName,
          pacienteCpf: _pacienteCpf,
          numerosessoes: _numerosessoes,
          description: _description,
          exerciseUrl: _exerciseUrl,
          sessaoId: uuid.v1());
      firestoreService.setSessao(novaSessao);
      //print(novaSessao.toMap().toString());
    } else {
      //Atualiza a sessao
      var updateSessao = Sessao(
          fisioId: _fisioId,
          fisioName: _fisioName,
          pacienteName: _pacienteName,
          pacienteCpf: _pacienteCpf,
          numerosessoes: _numerosessoes,
          description: _description,
          exerciseUrl: _exerciseUrl,
          sessaoId: _sessaoId);
      firestoreService.setSessao(updateSessao);
    }
  }

//Deleta a sessao
  removeSessao(String sessaoId) {
    firestoreService.removeSessao(sessaoId);
  }
}
