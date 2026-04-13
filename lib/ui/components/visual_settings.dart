import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/ui/theme_provider.dart';

class VisualSettings extends ConsumerWidget {
  const VisualSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeProvider.notifier);

    return Column(
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
    );
  }
}
