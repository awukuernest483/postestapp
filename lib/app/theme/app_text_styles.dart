import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  /// Native font family bundled in `assets/fonts/`. Used as a fallback when
  /// `google_fonts` cannot resolve Urbanist (e.g. offline first launch or a
  /// failure inside the package).
  static const _fallback = <String>['Urbanist'];

  static TextStyle _urbanist({
    required double fontSize,
    FontWeight? fontWeight,
  }) =>
      GoogleFonts.urbanist(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ).copyWith(fontFamilyFallback: _fallback);

  static TextStyle get greeting => _urbanist(fontSize: 13);

  static TextStyle get pageHeading =>
      _urbanist(fontSize: 18, fontWeight: FontWeight.bold);

  static TextStyle get tileTitle =>
      _urbanist(fontSize: 19, fontWeight: FontWeight.w900);

  static TextStyle get footnote => _urbanist(fontSize: 12);

  static TextStyle get detailsTitle =>
      _urbanist(fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle get detailsBody => _urbanist(fontSize: 14);
}
