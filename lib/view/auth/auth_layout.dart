import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/settings_provider.dart';

class AuthLayout extends StatelessWidget {
  final Widget body;
  final Widget? textNavigations;
  const AuthLayout({super.key, required this.body, this.textNavigations});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    var displayIcon =
        provider.colorMode == Brightness.light
            ? Icons.light_mode
            : Icons.dark_mode;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        actions: [
          IconButton(onPressed: provider.switchMode, icon: Icon(displayIcon)),
          // TextButton(onPressed: () {}, child: Text('English')),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Qualita', style: TextStyle(fontSize: 20))),
              const SizedBox(height: 40),
              body,
              if (textNavigations != null) textNavigations!,
            ],
          ),
        ),
      ),
    );
  }
}
