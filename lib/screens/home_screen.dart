import 'package:flutter/material.dart';
import 'package:qualita/layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(screen: Center(child: Text('Dashboard & Help')));
  }
}
