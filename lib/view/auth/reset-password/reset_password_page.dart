import 'package:flutter/material.dart';
import 'package:qualita/view/auth/auth_layout.dart';
import 'package:qualita/view/auth/reset-password/reset_password_form.dart';
import 'package:qualita/view/auth/signin/signin_page.dart';
import 'package:qualita/view/auth/signup/signup_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  createState() => _PageState();
}

class _PageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    void toSignup() {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
      }
    }

    void toSignin() {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SigninPage()),
        );
      }
    }

    return AuthLayout(
      body: ResetPasswordForm(),
      textNavigations: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: toSignup,
            child: Text(
              "Don't have an account? SIGN UP",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: toSignin,
            child: Text(
              'Remember your password? SIGN IN',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
