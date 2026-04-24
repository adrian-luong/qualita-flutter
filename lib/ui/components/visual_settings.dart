import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/ui/providers/theme_provider.dart';

class VisualSettings extends ConsumerStatefulWidget {
  const VisualSettings({super.key});

  @override
  ConsumerState<VisualSettings> createState() => _VisualSettingsState();
}

class _VisualSettingsState extends ConsumerState<VisualSettings> {
  late ThemeMode _mode;

  @override
  void initState() {
    setState(() => _mode = ref.read(themeProvider.notifier).currentMode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.read(themeProvider.notifier);

    return Column(
      children: [
        Row(
          spacing: 10,
          children: [
            const Text('Color mode'),
            SegmentedButton<ThemeMode>(
              segments: const [
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
              selected: {_mode},
              onSelectionChanged: (Set<ThemeMode> value) {
                setState(() => _mode = value.first);
                themeNotifier.toggleTheme(value.first);
              },
            ),
          ],
        ),
      ],
    );
  }
}
