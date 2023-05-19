import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Colors.blue;

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primaryColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
  );
}
