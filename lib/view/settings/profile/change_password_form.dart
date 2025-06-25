import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/settings/profile/profile_controller.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<ChangePasswordForm> {
  final _controller = ProfileController();
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  // final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    // _oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onSubmit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      if (_newPassword.text.trim() != _confirmPassword.text.trim()) {
        displayMessage(
          SnackBar(
            content: Text(
              'Please re-enter the new password again to confirm the change',
            ),
          ),
        );
        return;
      }

      setState(() => isLoading = true);
      try {
        await _controller.changePassword(_newPassword.text.trim()).then((
          value,
        ) {
          if (value != 'OK') {
            displayMessage(SnackBar(content: Text(value)));
          } else {
            displayMessage(
              SnackBar(content: Text('Successfully changed password')),
            );
          }
        });
      } catch (e) {
        displayMessage(SnackBar(content: Text(e.toString())));
      } finally {
        popContext();
      }
      setState(() => isLoading = false);
    }

    return Container(
      padding: const EdgeInsets.all(defaultPaddingSize),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // TextFormField(
            //   controller: _oldPassword,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     label: Text('Current password'),
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // const SizedBox(height: 30),
            TextFormField(
              controller: _newPassword,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('New password'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _confirmPassword,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Confirm new password'),
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
