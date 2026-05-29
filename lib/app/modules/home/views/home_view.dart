import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logo.png', height: 35),
            const SizedBox(height: 20),
            Obx(() => Text(
                  controller.greeting.value,
                  style: const TextStyle(fontSize: 13),
                )),
            const Text(
              'What will you like to do today?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.options.length,
                itemBuilder: (context, index) {
                  final option = controller.options[index];
                  return _OptionCard(
                    option: option,
                    onTap: () => controller.onOptionTap(option),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Powered by ', style: TextStyle(fontSize: 12)),
                  Image.asset('assets/images/plogo.png', height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({required this.option, required this.onTap});

  final PaymentOption option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasBgImage = option.bgImage != null;
    final hasColor = option.color != null;

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: hasBgImage
                ? null
                : hasColor
                    ? Color(
                        int.parse(
                          option.color!.replaceFirst('#', 'FF'),
                          radix: 16,
                        ),
                      )
                    : Colors.black,
            borderRadius: BorderRadius.circular(20),
            gradient: !hasBgImage && !hasColor
                ? const LinearGradient(
                    transform: GradientRotation(45),
                    colors: [Color(0xFF3FA3DB), Color(0xFF0F69E7)],
                  )
                : null,
            image: hasBgImage
                ? DecorationImage(
                    image: AssetImage(option.bgImage!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: option.image1.isNotEmpty
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (option.image1.isNotEmpty)
                      Image.asset(option.image1, height: 25),
                    SvgPicture.asset(option.image2, height: 50),
                  ],
                ),
                Text(
                  option.title,
                  style: TextStyle(
                    color: hasBgImage ? Colors.black : Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
