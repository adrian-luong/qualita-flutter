import 'package:flutter/material.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/auth/auth_layout.dart';
import 'package:qualita/view/auth/reset-password/reset_password_page.dart';
import 'package:qualita/view/auth/signin/signin_form.dart';
import 'package:qualita/view/auth/signup/signup_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  createState() => _PageState();
}

class _PageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      body: SigninForm(),
      textNavigations: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => navigate(SignupPage()),
            child: Text(
              "Don't have an account? SIGN UP",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () => navigate(ResetPasswordPage()),
            child: Text(
              'Forgot your password? RESET IT',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
