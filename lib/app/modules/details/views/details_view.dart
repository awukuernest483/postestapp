import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_text_styles.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final option = controller.option;
    final title = controller.displayTitle;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (option != null) SvgPicture.asset(option.icon, height: 100),
              const SizedBox(height: 24),
              Text(title, style: AppTextStyles.detailsTitle),
              const SizedBox(height: 12),
              Text(
                'Details screen — coming soon.',
                textAlign: TextAlign.center,
                style: AppTextStyles.detailsBody,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
