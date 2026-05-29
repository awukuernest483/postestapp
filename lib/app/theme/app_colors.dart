import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const tileSurface = Color(0xFF1D3854);
  static const mobilePaymentGradientStart = Color(0xFF3FA3DB);
  static const mobilePaymentGradientEnd = Color(0xFF0F69E7);

  static const tileTitleOnDark = Colors.white;
  static const tileTitleOnLight = Colors.black;

  static const mobilePaymentGradient = LinearGradient(
    transform: GradientRotation(45),
    colors: [mobilePaymentGradientStart, mobilePaymentGradientEnd],
  );
}
