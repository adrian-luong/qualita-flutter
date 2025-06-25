import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/auth/signup/signup_controller.dart';
import 'package:qualita/view/auth/success_page.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  createState() => _FormState();
}

class _FormState extends State<SignupForm> {
  final _controller = SignupController();
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
      if (_controller.password != _controller.confirm) {
        displayMessage(SnackBar(content: Text('Passwords are not matched')));
      }

      setState(() => isLoading = true);
      await _controller.signup().then((value) {
        if (value != 'OK') {
          displayMessage(SnackBar(content: Text(value)));
        } else {
          navigate(SuccessPage(text: 'Successfully sign up!'));
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
            TextFormField(
              controller: _controller.username,
              decoration: InputDecoration(
                label: Text('Username'),
                prefixIcon: Icon(Icons.person_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

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

            TextFormField(
              controller: _controller.confirm,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Confirm password'),
                prefixIcon: Icon(Icons.lock),
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
                    child: Text('SIGN UP'),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
