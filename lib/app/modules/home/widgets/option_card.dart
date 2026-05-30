import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/models/payment_option.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({super.key, required this.option});

  final PaymentOption option;

  static const _borderRadius = 20.0;
  static const _padding = 15.0;
  static const _iconHeight = 50.0;
  static const _sideIconHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: DecoratedBox(
        decoration: _buildDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconRow(option: option),
              Text(option.title, style: _titleStyle),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: option.hasBackgroundImage ? null : option.color,
      gradient: option.hasBackgroundImage ? null : option.gradient,
      borderRadius: BorderRadius.circular(_borderRadius),
      image: option.hasBackgroundImage
          ? DecorationImage(
              image: AssetImage(option.backgroundImage!),
              fit: BoxFit.cover,
            )
          : null,
    );
  }

  TextStyle get _titleStyle => AppTextStyles.tileTitle.copyWith(
    color: option.hasBackgroundImage
        ? AppColors.tileTitleOnLight
        : AppColors.tileTitleOnDark,
  );
}

class _IconRow extends StatelessWidget {
  const _IconRow({required this.option});

  final PaymentOption option;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: option.hasSideIcon
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: [
        if (option.hasSideIcon)
          option.sideIcon!.endsWith('.png')
              ? Image.asset(
                  option.sideIcon!,
                  height: OptionCard._sideIconHeight,
                )
              : SvgPicture.asset(
                  option.sideIcon!,
                  height: OptionCard._sideIconHeight,
                ),
        SvgPicture.asset(option.icon, height: OptionCard._iconHeight),
      ],
    );
  }
}
