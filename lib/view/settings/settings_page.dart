import 'package:flutter/material.dart';
import 'package:qualita/view/common/common_layout.dart';
import 'package:qualita/view/settings/appearance_settings.dart';
import 'package:qualita/view/settings/profile_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    icon: Row(
                      children: [
                        Icon(Icons.palette),
                        SizedBox(width: 8),
                        Text('Appearance'),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 8),
                        Text('Profile'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  children: [AppearanceSettings(), ProfileSettings()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
