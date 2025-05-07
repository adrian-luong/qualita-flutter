import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/view/auth/signup_form_controller.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<SignupForm> {
  final controller = SignupFormController();
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    if (!controller.formKey.currentState!.validate() ||
        !controller.isSamePassword()) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    String result = await controller.signup();
    if (result != 'OK') {
      setState(() => errorMessage = result);
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPaddingSize),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign-up form'),
            const SizedBox(height: 40),

            TextFormField(
              controller: controller.username,
              decoration: InputDecoration(
                label: Text('Username'),
                prefixIcon: Icon(Icons.person_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: controller.email,
              decoration: InputDecoration(
                label: Text('Email'),
                prefixIcon: Icon(Icons.mail_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: controller.password,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Password'),
                prefixIcon: Icon(Icons.password_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: controller.confirmPassword,
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
