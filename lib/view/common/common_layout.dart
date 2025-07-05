import 'package:flutter/material.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/home/home_page.dart';
import 'package:qualita/view/settings/settings_page.dart';

class CommonLayout extends StatelessWidget {
  final Widget body;
  final Widget? floatCTA;
  final PreferredSizeWidget? tabBar;
  const CommonLayout({
    super.key,
    required this.body,
    this.tabBar,
    this.floatCTA,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Qualita'), bottom: tabBar),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => navigate(HomePage()),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Calendar'),
              onTap: () => navigate(HomePage()),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => navigate(SettingsPage()),
            ),
          ],
        ),
      ),
      body: body,
      floatingActionButton: floatCTA,
    );
  }
}
