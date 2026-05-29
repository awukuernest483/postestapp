import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const _fontFamily = 'Urbanist';

  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: _fontFamily,
      );
}
