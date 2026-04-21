import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qualita/ui/screen_provider.dart';
import 'package:qualita/utils/constant_enums.dart';

class ScreenLayout extends ConsumerWidget {
  final Widget screen;
  const ScreenLayout({super.key, required this.screen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenNotifier = ref.read(screenProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          tooltip: 'Home',
          onPressed: () => screenNotifier.switchScreen(Screen.home),
          icon: const FlutterLogo(),
        ),
        title: const Text('Qualita'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
            onPressed: () => screenNotifier.switchScreen(Screen.settings),
          ),
        ],
      ),
      body: screen,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        tooltip: 'Help',
        child: const Icon(Icons.help),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        elevation: 0.1,
      ),
    );
  }
}
