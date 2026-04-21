// Color themes
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Source: https://stackoverflow.com/questions/57267165/how-to-show-snackbar-without-scaffold/57267370

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.blueAccent.shade400,
    secondary: Colors.lightBlue.shade500,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  useMaterial3: true,
  textTheme: TextTheme(),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.blueAccent.shade400,
    secondary: Colors.lightBlue.shade500,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
  textTheme: const TextTheme(),
);
