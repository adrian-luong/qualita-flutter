import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/ui/screen_layout.dart';
import 'package:qualita/ui/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeProvider.notifier);
    return ScreenLayout(
      screen: Center(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: "Appearance"),
                  Tab(text: "Data"),
                ],
                labelColor: Colors.blue,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              Text('Color mode'),
                              SegmentedButton<ThemeMode>(
                                segments: [
                                  ButtonSegment<ThemeMode>(
                                    value: ThemeMode.light,
                                    label: Text('Light'),
                                    icon: Icon(Icons.light_mode),
                                  ),
                                  ButtonSegment<ThemeMode>(
                                    value: ThemeMode.dark,
                                    label: Text('Dark'),
                                    icon: Icon(Icons.dark_mode),
                                  ),
                                ],
                                selected: {themeNotifier.currentMode},
                                onSelectionChanged: (Set<ThemeMode> value) =>
                                    themeNotifier.toggleTheme(value.first),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Center(child: Text("Data Management")),
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
