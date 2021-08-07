import './listapacientes_screen.dart';
import './profile_fisio_screen.dart';
import 'package:flutter/material.dart';

import './sessoesfisioscreen.dart';

class HomeFisioScreen extends StatefulWidget {
  static const route = 'homefisio';
  HomeFisioScreen(this.userId, {Key key}) : super(key: key);
  final String userId;

  @override
  _HomeFisioScreenState createState() => _HomeFisioScreenState();
}

class _HomeFisioScreenState extends State<HomeFisioScreen> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      _selectedIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          SessoesFisioScreen(),
          PacientesFisioScreen(),
          ProfileFisioScreen(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.description_sharp),
            label: 'Sessões',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Pacientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Meu perfil',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
