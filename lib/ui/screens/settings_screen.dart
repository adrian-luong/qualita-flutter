import 'package:flutter/material.dart';
import 'package:qualita/ui/screen_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(screen: Center(child: Text('Settings & Stuff')));
  }
}
