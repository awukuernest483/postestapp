import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final option = controller.option;
    final title = option?.title.replaceAll('\n', '').trim() ?? 'Details';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (option != null) Image.asset(option.image2, height: 80),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Details screen — coming soon.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
