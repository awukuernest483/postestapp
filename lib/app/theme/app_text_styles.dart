import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const _family = 'Urbanist';

  static const greeting = TextStyle(
    fontFamily: _family,
    fontSize: 13,
  );

  static const pageHeading = TextStyle(
    fontFamily: _family,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const tileTitle = TextStyle(
    fontFamily: _family,
    fontSize: 19,
    fontWeight: FontWeight.w900,
  );

  static const footnote = TextStyle(
    fontFamily: _family,
    fontSize: 12,
  );
}
