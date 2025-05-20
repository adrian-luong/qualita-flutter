import 'package:flutter/material.dart';

void displayDialog<T>(BuildContext context, List<Widget> content) {
  showDialog<T>(
    context: context,
    builder:
        (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: content,
            ),
          ),
        ),
  );
}
