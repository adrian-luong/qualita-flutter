import 'package:flutter/material.dart';
import 'package:qualita/ui/screen_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(screen: Center(child: Text('Dashboard & Help')));
  }
}
