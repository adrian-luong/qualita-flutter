import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/data/services/auth_services.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  createState() => _FormState();
}

class _FormState extends State<ResetPasswordForm> {
  final _services = AuthServices();
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onSubmit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      try {
        await _services.resetPassword(
          _email.text.trim(),
          () => {
            // 2. Navigate to another screen (e.g., HomeScreen)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'An email has been sent to: ${_email.text.trim()}. Click it to reset your password',
                ),
              ),
            ),
          },
        );
        _formKey.currentState?.reset();
        _email.clear();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'invalid-_email':
            setState(() => errorMessage = 'The _email address is not valid.');
          default:
            setState(
              () => errorMessage = 'An error occurred. Please try again.',
            );
        }
      } catch (e) {
        setState(() => errorMessage = e.toString());
      }

      if (mounted) {
        setState(() => isLoading = false);
      }
    }

    return Container(
      padding: const EdgeInsets.all(defaultPaddingSize),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reset password form'),
            const SizedBox(height: 40),

            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                label: Text('Email'),
                prefixIcon: Icon(Icons.mail_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

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
                    child: Text('SEND RESET PASSWORD EMAIL'),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
