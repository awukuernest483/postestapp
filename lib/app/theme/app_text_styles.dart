import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get greeting => GoogleFonts.urbanist(
        fontSize: 13,
      );

  static TextStyle get pageHeading => GoogleFonts.urbanist(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get tileTitle => GoogleFonts.urbanist(
        fontSize: 19,
        fontWeight: FontWeight.w900,
      );

  static TextStyle get footnote => GoogleFonts.urbanist(
        fontSize: 12,
      );

  static TextStyle get detailsTitle => GoogleFonts.urbanist(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get detailsBody => GoogleFonts.urbanist(
        fontSize: 14,
      );
}
