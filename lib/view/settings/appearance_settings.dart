import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/settings_provider.dart';

class AppearanceSettings extends StatefulWidget {
  const AppearanceSettings({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<AppearanceSettings> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 8),
              Text('Color theme'),
              SizedBox(width: 8),
              SegmentedButton<Brightness>(
                segments: [
                  ButtonSegment<Brightness>(
                    value: Brightness.light,
                    label: Text('Light'),
                    icon: Icon(Icons.light_mode),
                  ),
                  ButtonSegment<Brightness>(
                    value: Brightness.dark,
                    label: Text('Dark'),
                    icon: Icon(Icons.dark_mode),
                  ),
                ],
                selected: {provider.colorMode},
                onSelectionChanged:
                    (Set<Brightness> value) => provider.setMode(value.first),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
