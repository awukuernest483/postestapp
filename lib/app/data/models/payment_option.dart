import 'package:flutter/material.dart';

@immutable
class PaymentOption {
  const PaymentOption({
    required this.title,
    required this.icon,
    this.sideIcon,
    this.color,
    this.backgroundImage,
    this.gradient,
  });

  final String title;
  final String icon;
  final String? sideIcon;
  final Color? color;
  final String? backgroundImage;
  final Gradient? gradient;

  bool get hasSideIcon => sideIcon != null;
  bool get hasBackgroundImage => backgroundImage != null;
}
