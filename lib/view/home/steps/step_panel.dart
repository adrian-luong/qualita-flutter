import 'package:flutter/material.dart';

class StepPanel extends StatelessWidget {
  final String name;
  const StepPanel({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 32),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          ],
        ),
      ),
    );
  }
}
