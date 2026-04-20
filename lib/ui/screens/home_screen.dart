import 'package:flutter/material.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/ui/components/dashboard_box.dart';
import 'package:qualita/ui/screen_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      screen: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: DashboardBox(status: TaskStatus.onHold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: DashboardBox(status: TaskStatus.inProgress),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: DashboardBox(status: TaskStatus.completed),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
