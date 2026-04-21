import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qualita/data/auth_services.dart';
import 'package:qualita/ui/screen_provider.dart';
import 'package:qualita/utils/constant_enums.dart';

class SigninForm extends ConsumerStatefulWidget {
  const SigninForm({super.key});

  @override
  createState() => _FormState();
}

class _FormState extends ConsumerState<SigninForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<String> signin() async {
    try {
      await AuthServices.signin(emailController.text, passwordController.text);
      formKey.currentState?.reset();
      emailController.clear();
      passwordController.clear();
      return 'OK';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    final screenNotifier = ref.read(screenProvider.notifier);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) {
        return;
      }

      setState(() => isLoading = true);
      await signin().then((value) {
        if (value != 'OK') {
          messenger.showSnackBar(
            SnackBar(backgroundColor: Colors.red, content: Text(value)),
          );
        } else {
          screenNotifier.switchScreen(Screen.home);
          messenger.showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('Welcome back!'),
            ),
          );
        }
      });
      setState(() => isLoading = false);
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text('Email'),
                prefixIcon: Icon(Icons.mail_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            TextFormField(
              controller: passwordController,
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
                      onPressed: submit,
                      child: Text('SIGN IN'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
