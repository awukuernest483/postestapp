import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  /// Native font family bundled in `assets/fonts/`. Used as a fallback when
  /// `google_fonts` cannot resolve Urbanist at runtime.
  static const _fontFallback = <String>['Urbanist'];

  static ThemeData get light {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );

    return base.copyWith(
      textTheme: _withFallback(GoogleFonts.urbanistTextTheme(base.textTheme)),
      primaryTextTheme:
          _withFallback(GoogleFonts.urbanistTextTheme(base.primaryTextTheme)),
      appBarTheme: base.appBarTheme.copyWith(
        titleTextStyle: GoogleFonts.urbanist(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: base.colorScheme.onSurface,
        ).copyWith(fontFamilyFallback: _fontFallback),
      ),
    );
  }

  static TextTheme _withFallback(TextTheme theme) => theme.apply(
        fontFamilyFallback: _fontFallback,
      );
}
