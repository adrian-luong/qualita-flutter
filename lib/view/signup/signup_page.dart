import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/view/signin/signin_page.dart';
import 'package:qualita/view/signup/signup_form.dart';

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

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultPaddingSize),
            child: Column(
              children: [
                SignupForm(),
                Column(
                  children: [
                    const Text('OR'),
                    TextButton(
                      onPressed: toSignin,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Already have an account? '),
                            TextSpan(text: ' SIGN IN'),
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
