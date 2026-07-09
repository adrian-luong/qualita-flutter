import 'package:flutter/material.dart';
import 'package:qualita/screens/home.dart';
import 'package:qualita/screens/settings.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Layout> {
  int _index = 0;
  void _onTap(int index) {
    setState(() => _index = index);
  }

  static const List<Widget> _screens = [Home(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qualita')),
      body: _screens.elementAt(_index),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _index,
        selectedItemColor: Colors.amber[800],
        onTap: _onTap,
      ),
    );
  }
}
