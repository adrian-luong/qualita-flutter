import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget body;
  final Widget textNavigations;
  const AuthLayout({
    super.key,
    required this.body,
    required this.textNavigations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.sunny)),
          TextButton(onPressed: () {}, child: Text('English')),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Qualita', style: TextStyle(fontSize: 20))),
              body,
              textNavigations,
            ],
          ),
        ),
      ),
    );
  }
}
