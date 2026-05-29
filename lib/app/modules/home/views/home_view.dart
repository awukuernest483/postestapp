import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../theme/app_text_styles.dart';
import '../controllers/home_controller.dart';
import '../widgets/option_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const _horizontalPadding = 15.0;
  static const _gridSpacing = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset(AppAssets.logo, height: 35),
              const SizedBox(height: 20),
              Text(controller.greeting, style: AppTextStyles.greeting),
              Text(
                'What will you like to do today?',
                style: AppTextStyles.pageHeading,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  crossAxisSpacing: _gridSpacing,
                  mainAxisSpacing: _gridSpacing,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.options.length,
                  itemBuilder: (context, index) {
                    final option = controller.options[index];
                    return OptionCard(
                      option: option,
                      onTap: () => controller.onOptionTap(option),
                    );
                  },
                ),
              ),
              const _PoweredByFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PoweredByFooter extends StatelessWidget {
  const _PoweredByFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Powered by ', style: AppTextStyles.footnote),
          Image.asset(AppAssets.poweredByLogo, height: 25),
        ],
      ),
    );
  }
}
