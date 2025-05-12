import 'package:flutter/material.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/auth/auth_layout.dart';
import 'package:qualita/view/auth/signin/signin_page.dart';
import 'package:qualita/view/auth/signup/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      body: SignupForm(),
      textNavigations: TextButton(
        onPressed: () => navigate(SigninPage()),
        child: Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 10, color: Colors.grey),
            children: [
              TextSpan(text: 'Already have an account? '),
              TextSpan(text: ' SIGN IN'),
            ],
          ),
        ),
      ),
    );
  }
}
