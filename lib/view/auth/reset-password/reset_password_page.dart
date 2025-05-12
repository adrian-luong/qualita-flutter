import 'package:flutter/material.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/auth/auth_layout.dart';
import 'package:qualita/view/auth/reset-password/reset_password_form.dart';
import 'package:qualita/view/auth/signin/signin_page.dart';
import 'package:qualita/view/auth/signup/signup_page.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      body: ResetPasswordForm(),
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
            onPressed: () => navigate(SigninPage()),
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
