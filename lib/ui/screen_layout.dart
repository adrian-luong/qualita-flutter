import 'package:flutter/material.dart';

import 'package:qualita/ui/screens/home_screen.dart';
import 'package:qualita/ui/screens/settings_screen.dart';
import 'package:qualita/ui/screens/task_screen.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<StatefulWidget> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  int _screenIndex = 0;
  final screens = [HomeScreen(), TaskScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          tooltip: 'Home',
          onPressed: () => setState(() => _screenIndex = 0),
          icon: const FlutterLogo(),
        ),
        title: const Text('Qualita Demo'),
      ),
      body: screens[_screenIndex],
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        tooltip: 'Help',
        child: const Icon(Icons.help),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.1,
        currentIndex: _screenIndex,
        onTap: (index) => setState(() => _screenIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Tasks'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
