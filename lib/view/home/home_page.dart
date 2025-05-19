import 'package:flutter/material.dart';
import 'package:qualita/view/common/common_layout.dart';
import 'package:qualita/view/home/project_select.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(child: ProjectSelect()),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_circle_outline),
              selectedIcon: Icon(Icons.add_circle),
            ),
          ],
        ),
      ),
    );
  }
}
