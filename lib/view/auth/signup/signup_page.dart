import 'package:flutter/material.dart';
import 'package:qualita/view/auth/auth_layout.dart';
import 'package:qualita/view/auth/signin/signin_page.dart';
import 'package:qualita/view/auth/signup/signup_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  createState() => _PageState();
}

class _PageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    void toSignin() {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SigninPage()),
        );
      }
    }

    return AuthLayout(
      body: SignupForm(),
      textNavigations: TextButton(
        onPressed: toSignin,
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
