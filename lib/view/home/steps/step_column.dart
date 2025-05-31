import 'package:flutter/material.dart';
import 'package:qualita/view/home/steps/step_panel.dart';
import 'package:qualita/view/home/tasks/task_area.dart';

class StepColumn extends StatelessWidget {
  final String id;
  final String name;
  const StepColumn({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StepPanel(id: id, name: name),
          SizedBox(height: 16),
          TaskArea(),
        ],
      ),
    );
  }
}
