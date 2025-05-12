import 'package:flutter/material.dart';

// Source: https://stackoverflow.com/questions/57267165/how-to-show-snackbar-without-scaffold/57267370

final messenger = GlobalKey<ScaffoldMessengerState>();
final navigator = GlobalKey<NavigatorState>();

/// Using the global key to display a snackbar
void displayMessage(SnackBar snackbar) {
  messenger.currentState?.showSnackBar(snackbar);
}

/// Using the global key to navigate to page (a widget)
void navigate(Widget page) {
  navigator.currentState?.pushReplacement(
    MaterialPageRoute(builder: (context) => page),
  );
}
