import 'package:flutter/material.dart';
import 'package:qualita/data/services/auth_services.dart';
import 'package:qualita/view/auth/signin/signin_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScreenState();
}

class _ScreenState extends State<SplashScreen> {
  final _services = AuthServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _services.onChange(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return const SigninPage();
          }
          return const Placeholder();
        }

        // Show a loading indicator while waiting for auth state
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
