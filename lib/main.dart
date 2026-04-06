import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Qualita'),
        ),
        body: Center(child: Text('Hello World!')),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {},
          tooltip: 'Create',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: .endDocked,
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 2500),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            elevation: 0.1,
            color: Colors.blue,
            child: IconTheme(
              data: IconThemeData(color: scheme.onPrimary),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Home',
                    icon: const Icon(Icons.home),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'Tasks',
                    icon: const Icon(Icons.checklist),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'Settings',
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
