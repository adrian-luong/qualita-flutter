import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/view/signup/signup_controller.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  createState() => _FormState();
}

class _FormState extends State<SignupForm> {
  final _controller = SignupController();
  bool isLoading = false;
  String? errorMessage;

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
        setState(() => errorMessage = 'Passwords are not matched');
      }

      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      String signupResult = await _controller.signup(
        () => {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signup successful! Welcome ${_controller.email}'),
            ),
          ),
        },
      );
      if (signupResult != 'OK') {
        setState(() => errorMessage = signupResult);
      }

      setState(() => isLoading = false);
    }

    return Container(
      padding: const EdgeInsets.all(defaultPaddingSize),
      child: Form(
        key: _controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign-up form'),
            const SizedBox(height: 40),

            TextFormField(
              controller: _controller.username,
              decoration: InputDecoration(
                label: Text('Username'),
                prefixIcon: Icon(Icons.person_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: _controller.email,
              decoration: InputDecoration(
                label: Text('Email'),
                prefixIcon: Icon(Icons.mail_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: _controller.password,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Password'),
                prefixIcon: Icon(Icons.password_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

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

            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
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
