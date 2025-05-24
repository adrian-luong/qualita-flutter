import 'package:flutter/material.dart';

class AddPanel extends StatelessWidget {
  const AddPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_box_outlined),
              selectedIcon: Icon(Icons.add_box),
            ),
          ),
        ],
      ),
    );
  }
}
