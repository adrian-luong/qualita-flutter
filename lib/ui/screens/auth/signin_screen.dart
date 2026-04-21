import 'package:flutter/material.dart';
import 'package:qualita/ui/screens/auth/auth_layout.dart';
import 'package:qualita/ui/screens/auth/signin_form.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      body: SigninForm(),
      textNavigations: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // children: [
        //   TextButton(
        //     onPressed: () => navigate(SignupPage()),
        //     child: Text(
        //       "Don't have an account? SIGN UP",
        //       style: TextStyle(fontSize: 10, color: Colors.grey),
        //     ),
        //   ),
        //   TextButton(
        //     onPressed: () => navigate(ResetPasswordPage()),
        //     child: Text(
        //       'Forgot your password? RESET IT',
        //       style: TextStyle(fontSize: 10, color: Colors.grey),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
