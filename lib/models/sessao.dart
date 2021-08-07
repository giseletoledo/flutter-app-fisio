import 'package:flutter/material.dart';

class Sessao {
  final String sessaoId;
  final String fisioId;
  final String fisioName;
  final String pacienteName;
  final String pacienteCpf;
  final int numerosessoes;
  final String description;
  final String exerciseUrl;

  Sessao(
      {this.fisioId,
      this.fisioName,
      this.pacienteName,
      this.pacienteCpf,
      this.numerosessoes,
      this.description,
      this.exerciseUrl,
      @required this.sessaoId});

  //função que transforma num objeto dart
  factory Sessao.fromJson(Map<String, dynamic> json) {
    return Sessao(
        fisioId: json['fisioId'],
        fisioName: json['fisioName'],
        pacienteName: json['pacienteName'],
        pacienteCpf: json['pacienteCpf'],
        numerosessoes: json['numerosessoes'],
        description: json['description'],
        exerciseUrl: json['exerciseUrl'],
        sessaoId: json['sessaoId']);
  }

//dados que serão gravados no banco do cloud firestore
  Map<String, dynamic> toMap() {
    return {
      'sessaoId': sessaoId,
      'fisioId': fisioId,
      'fisioName': fisioName,
      'pacienteName': pacienteName,
      'pacienteCpf': pacienteCpf,
      'numerosessoes': numerosessoes,
      'description': description,
      'exerciseUrl': exerciseUrl,
    };
  }
}
