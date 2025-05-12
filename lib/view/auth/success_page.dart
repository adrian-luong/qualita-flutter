import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/auth/auth_layout.dart';
import 'package:qualita/view/auth/signin/signin_page.dart';

class SuccessPage extends StatelessWidget {
  final String text;
  const SuccessPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      body: Container(
        padding: const EdgeInsets.all(defaultPaddingSize),
        child: Text(text),
      ),
      textNavigations: TextButton(
        onPressed: () => navigate(SigninPage()),
        child: Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 10, color: Colors.grey),
            children: [
              TextSpan(text: 'Click here to sign in'),
              TextSpan(text: ' SIGN IN'),
            ],
          ),
        ),
      ),
    );
  }
}
