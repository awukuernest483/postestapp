import 'package:get/get.dart';

import '../../../data/models/payment_option.dart';

class DetailsController extends GetxController {
  late final PaymentOption? option;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    option = args is PaymentOption ? args : null;
  }

  String get displayTitle =>
      option?.title.replaceAll('\n', '').trim() ?? 'Details';
}
