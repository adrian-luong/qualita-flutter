import 'package:flutter/material.dart';
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
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: "Visual", icon: const Icon(Icons.palette)),
                  Tab(text: "Data", icon: const Icon(Icons.storage)),
                ],
                labelColor: Colors.blue,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TabBarView(
                    children: [VisualSettings(), DataSettings()],
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
