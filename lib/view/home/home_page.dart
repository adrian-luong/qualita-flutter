import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/view/common/common_layout.dart';
import 'package:qualita/view/home/projects/project_settings.dart';
import 'package:qualita/view/home/search_area.dart';
import 'package:qualita/view/home/steps/step_area.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<HomePage> {
  int _selectedTab = 0;
  final actualBodies = const [StepArea(), ProjectSettings()];

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.of(context);
    final provider = Provider.of<HomeProvider>(context);
    var tabs = [
      BottomNavigationBarItem(icon: Icon(Icons.view_kanban), label: 'Kanban'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ];

    return CommonLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 16),
            SearchArea(),
            SizedBox(height: 16),
            actualBodies.elementAt(_selectedTab),
          ],
        ),
      ),
      bottomNavBar:
          provider.selectedProject != null
              ? BottomNavigationBar(
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: tabs,
                currentIndex: _selectedTab,
                selectedItemColor: scheme.primary,
                onTap: (index) => setState(() => _selectedTab = index),
              )
              : null,
    );
  }
}
