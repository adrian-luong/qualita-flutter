import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget body;
  final Widget? textNavigations;
  const AuthLayout({super.key, required this.body, this.textNavigations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Qualita', style: TextStyle(fontSize: 20))),
                body,
                ?textNavigations,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
