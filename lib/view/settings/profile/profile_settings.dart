import 'package:flutter/material.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/auth/signin/signin_page.dart';
import 'package:qualita/view/settings/profile/change_password_form.dart';
import 'package:qualita/view/settings/profile/profile_controller.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<ProfileSettings> {
  final _controller = ProfileController();
  final user = getCurrentUser();
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
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            user != null
                ? [
                  // Row(
                  //   children: [
                  //     Text('Username'),
                  //     SizedBox(width: 8),
                  //     Text(
                  //       user!.userMetadata != null
                  //           ? user!.userMetadata!['username']
                  //           : '',
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Text('Email:'),
                      SizedBox(width: 8),
                      Text(user!.email ?? ''),
                    ],
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed:
                          () => displayDialog(context, [ChangePasswordForm()]),
                      child: Text('Change Password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 2),
                  ),
                  ElevatedButton(onPressed: onLogout, child: Text('Logout')),
                ]
                : [],
      ),
    );
  }
}
