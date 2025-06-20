import 'package:flutter/material.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/auth/signin/signin_page.dart';
import 'package:qualita/view/settings/profile_controller.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<ProfileSettings> {
  final _controller = ProfileController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> onLogout() async {
      setState(() => isLoading = true);
      await _controller.signout().then((value) {
        if (value != 'OK') {
          displayMessage(SnackBar(content: Text('Successfully logging out!')));
        } else {
          navigate(SigninPage());
        }
      });
      setState(() => isLoading = false);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(
            child: ElevatedButton(onPressed: onLogout, child: Text('Logout')),
          ),
        ],
      ),
    );
  }
}
