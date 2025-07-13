import 'package:flutter/material.dart';
import 'package:qualita/view/common/common_layout.dart';
import 'package:qualita/view/home/search_area.dart';
import 'package:qualita/view/home/steps/step_area.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 16),
            SearchArea(),
            SizedBox(height: 16),
            StepArea(),
          ],
        ),
      ),
    );
  }
}
