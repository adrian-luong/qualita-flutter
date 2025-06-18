import 'package:flutter/material.dart';
import 'package:qualita/global_keys.dart';

/// An extension to Material's showDialog for a unified dialog/modal layout
void displayDialog(BuildContext context, List<Widget> content) {
  showDialog(
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

void confirmDelete(
  BuildContext context,
  String formTitle,
  VoidCallback onConfirmed,
) {
  displayDialog(context, [
    Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formTitle, style: TextStyle(fontSize: 20)),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    popContext();
                  },
                  child: Text('No'),
                ),
                ElevatedButton(onPressed: onConfirmed, child: Text('Confirm')),
              ],
            ),
          ),
        ],
      ),
    ),
  ]);
}
