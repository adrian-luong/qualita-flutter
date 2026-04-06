import 'package:flutter/material.dart';
import 'package:qualita/layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(screen: Center(child: Text('Settings & Stuff')));
  }
}
