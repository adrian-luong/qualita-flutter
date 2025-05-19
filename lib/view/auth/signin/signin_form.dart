import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/auth/signin/signin_controller.dart';
import 'package:qualita/view/home/home_page.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  createState() => _FormState();
}

class _FormState extends State<SigninForm> {
  final _controller = SigninController();
  bool isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onSubmit() async {
      if (!_controller.formKey.currentState!.validate()) {
        return;
      }

      setState(() => isLoading = true);
      await _controller.signin().then((value) {
        if (value != 'OK') {
          displayMessage(SnackBar(content: Text(value)));
        } else {
          navigate(HomePage());
        }
      });
      setState(() => isLoading = false);
    }

    return Container(
      padding: const EdgeInsets.all(defaultPaddingSize),
      child: Form(
        key: _controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign-in form'),
            const SizedBox(height: 40),

            TextFormField(
              controller: _controller.email,
              decoration: InputDecoration(
                label: Text('Email'),
                prefixIcon: Icon(Icons.mail_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            TextFormField(
              controller: _controller.password,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Password'),
                prefixIcon: Icon(Icons.password_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    child: Text('SIGN IN'),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
