import 'package:flutter/material.dart';

class TaskArea extends StatefulWidget {
  const TaskArea({super.key});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<TaskArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
    );
  }
}
