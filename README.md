## FisioControl - Projeto criado na faculdade

Aplicativo criado utilizando a linguagem de programação Dart e o framework multiplataforma Flutter e acesso ao cadastro através do firebase com banco de dados.
Tem funcionalidade de cadastro de usuários, cadastro de sessões, área de administrador e área do paciente, para acessar os vídeos cadastrados pelo app que ele consegue abrindo o app do Youtube.

<p align="center"><img src="https://github.com/gisesma/flutterappfisio/blob/main/telas_app_fisiocontrol.PNG"/></p>

<img src='https://github.com/gisesma/flutter-app-fisio/blob/main/app_fisio_video.gif'/> 

##### Protótipo das telas desenvolvidas no Figma

## Stacks
- Flutter - **environment sdk: 2.7.0 < 3.0.0**

- Dependências
  - firebase_core: ^0.5.0
  - cloud_firestore: ^0.14.0+2
  - provider: ^4.3.2+2
  - uuid: ^2.2.2
  - date_format: ^1.0.9
  - firebase: ^7.3.2
  - firebase_auth: ^0.18.1+1
  - firebase_auth_web: ^0.3.1+1
  - url_launcher: ^5.2.5

- Gerenciamento de estados - Provider

- Banco de Dados e Backend
  Firebase - Cloud Firestore (No SQL) - [Cloud Firestore](https://firebase.google.com/docs/firestore?hl=pt-br)

## Estrutura

```lib
  
| main.dart  
+---helpers
|       firebase_erros.dart
|       validators.dart
|       
+---models
|       sessao.dart
|       user.dart
|       userfisio_manager.dart
|       user_fisio.dart
|       user_manager.dart
|       
+---providers
|       sessao_provider.dart
|       
+---screens
|   |   addeditsessao_screen.dart
|   |   detalhesessao_screen.dart
|   |   homefisio_screen.dart
|   |   home_screen.dart
|   |   listapacientes_screen.dart
|   |   profile_fisio_screen.dart
|   |   profile_paciente_screen.dart
|   |   sessoesfisioscreen.dart
|   |   sessoespacientescreen.dart
|   |   usertype_screen.dart
|   |   
|   +---login
|   |       fisiologin_screen.dart
|   |       pacientelogin_screen.dart
|   |       
|   \---signup
|           signupfisio_screen.dart
|           signuppaciente_screen.dart
|           
\---services
        firestore_service.dart
```

Para utilizar o flutter é necessário ter instalado o Dart SDK

Para instalar, maiores instruções no link [Dart SDK](https://www.dartlang.org/downloads/):

- Mac: `brew tap dart-lang/dart && brew install dart`, ou então
  utilizar homebrew,  [latest stable channel build](https://www.dartlang.org/downloads/archive/)
- Linux: no link [www.dartlang.org/downloads/linux.html](https://www.dartlang.org/downloads/linux.html)
- Windows: instruções também na página oficial ou pode ser instalado utilizando chocolatey, comandos de linha de comando no Windows.

https://community.chocolatey.org/packages/dart-sdk

## Instalação do Flutter

https://flutter.dev/docs/get-started/install


Pode se utilizar tanto o Android Studio ou VScode

https://flutter.dev/docs/development/tools/android-studio

https://flutter.dev/docs/development/tools/vs-code

Clonando o repositório:

```
$ git clone https://github.com/gisesma/flutter-app-fisio
```

Baixar as dependências do projeto:

```
$ flutter pub get
```

Para rodar o app, digitar o comando na linha de comando, dentro do diretório raiz do app:

```
$ flutter run
```

Configuração do banco de dados, criar um novo:

[Android](https://firebase.google.com/docs/flutter/setup?platform=android)
[IOS](https://firebase.google.com/docs/flutter/setup?platform=ios)


## Sobre o Flutter

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
