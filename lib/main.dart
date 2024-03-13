import 'package:flutter/material.dart';
import 'package:unibot_app/Screans/screen_chatbot.dart';
import 'package:unibot_app/Screans/screen_select.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaPrincial(),
    );
  }
}

class TelaPrincial extends StatefulWidget {
  const TelaPrincial({super.key});

  @override
  State<TelaPrincial> createState() => _TelaPrincialState();
}

class _TelaPrincialState extends State<TelaPrincial> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TelaSelect(),
    //ScreenChatbot(), // Adicione suas telas aqui
    ChatScreenDefault(), // Substitua Placeholder() pelas outras telas que você quer adicionar
    Placeholder(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('REVEMAR'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 167, 25, 32),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
