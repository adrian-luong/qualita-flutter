import 'package:flutter/material.dart';
import 'package:qualita/data/auth_services.dart';
import 'package:qualita/ui/components/data_settings.dart';
import 'package:qualita/ui/components/visual_settings.dart';
import 'package:qualita/ui/screen_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      screen: Center(
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: "Visual", icon: Icon(Icons.palette)),
                  Tab(text: "Data", icon: Icon(Icons.storage)),
                  Tab(text: "Profile", icon: Icon(Icons.person)),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TabBarView(
                    children: [
                      VisualSettings(),
                      DataSettings(),
                      Column(
                        children: [
                          FilledButton(
                            onPressed: AuthServices.signout,
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
