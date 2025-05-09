import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/view/signin/signin_form.dart';
import 'package:qualita/view/signup/signup_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  createState() => _PageState();
}

class _PageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    void toSignup() {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultPaddingSize),
            child: Column(
              children: [
                SigninForm(),
                Column(
                  children: [
                    const Text('OR'),
                    TextButton(
                      onPressed: toSignup,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(text: ' SIGN UP'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
