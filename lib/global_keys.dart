import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Source: https://stackoverflow.com/questions/57267165/how-to-show-snackbar-without-scaffold/57267370

// Get a reference your Supabase client
final supabase = Supabase.instance.client;
final messenger = GlobalKey<ScaffoldMessengerState>();
final navigator = GlobalKey<NavigatorState>();

/// Using the global key to display a snackbar
void displayMessage(SnackBar snackbar) {
  messenger.currentState?.showSnackBar(snackbar);
}

/// Using the global key to navigate to page (a widget)
void navigate(Widget page) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    navigator.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  });
}

void popContext() {
  navigator.currentState?.pop();
}

/// Using the global key to get the current logged user
User? getCurrentUser() => supabase.auth.currentUser;
