import 'package:flutter/material.dart';
import 'package:qualita/layout.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(screen: Center(child: Text('Task List')));
  }
}
