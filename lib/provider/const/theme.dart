import 'package:flutter/material.dart';

ThemeData temaawal = ThemeData(
  primaryColor: Colors.cyan,
  canvasColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.cyan,
    foregroundColor: Colors.yellow,
  ),
  textTheme: TextTheme(
    bodyLarge: const TextStyle(color: Colors.black),
    displayLarge: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    bodySmall: const TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.cyan[700], fontSize: 10),
  ),
);
