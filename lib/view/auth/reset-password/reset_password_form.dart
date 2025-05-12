import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/auth/reset-password/reset_password_controller.dart';
import 'package:qualita/view/auth/success_page.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  createState() => _FormState();
}

class _FormState extends State<ResetPasswordForm> {
  final _controller = ResetPasswordController();
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
      await _controller.resetPassword().then((value) {
        if (value != 'OK') {
          displayMessage(SnackBar(content: Text(value)));
        } else {
          navigate(
            SuccessPage(
              text:
                  "Successfully send the reset-password email to the provided address. Please check your inbox",
            ),
          );
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
            Text('Reset password form'),
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
