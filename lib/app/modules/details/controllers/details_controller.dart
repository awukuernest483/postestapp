import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class DetailsController extends GetxController {
  late final PaymentOption? option;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    option = args is PaymentOption ? args : null;
  }
}
