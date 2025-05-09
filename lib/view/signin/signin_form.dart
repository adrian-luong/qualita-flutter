import 'package:flutter/material.dart';
import 'package:qualita/constants/sizes.dart';
import 'package:qualita/view/signin/signin_controller.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  createState() => _FormState();
}

class _FormState extends State<SigninForm> {
  final _controller = SigninController();
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

      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      String signinResult = await _controller.signin(
        () => {
          // 2. Navigate to another screen (e.g., HomeScreen)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Sign-in successful! Welcome back, ${_controller.email}',
              ),
            ),
          ),

          // Replace with your actual home screen navigation
          // Example: Check if the widget is still in the tree before navigating
          if (mounted)
            {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Placeholder(),
                ), // Replace with your actual HomeScreen
              ),
            },
        },
      );
      if (signinResult != 'OK') {
        setState(() => errorMessage = signinResult);
      }

      if (mounted) {
        setState(() => isLoading = false);
      }
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
                    child: Text('SIGN IN'),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
