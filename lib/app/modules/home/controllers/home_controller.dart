import 'package:get/get.dart';

class PaymentOption {
  const PaymentOption({
    required this.image1,
    required this.image2,
    required this.title,
    this.color,
    this.bgImage,
  });

  final String image1;
  final String image2;
  final String title;
  final String? color;
  final String? bgImage;
}

class HomeController extends GetxController {
  final greeting = 'Good Morning'.obs;

  final options = <PaymentOption>[
    const PaymentOption(
      image1: 'assets/images/momo.png',
      image2: 'assets/images/momoicon.png',
      title: 'Mobile \nPayment',
    ),
    const PaymentOption(
      image1: 'assets/images/card.png',
      image2: 'assets/images/cardicon.png',
      title: 'Card \nPayment',
      color: '#1D3854',
    ),
    const PaymentOption(
      image1: '',
      image2: 'assets/images/qr.png',
      title: 'Qr \nPayment',
      color: '#1D3854',
    ),
    const PaymentOption(
      image1: '',
      image2: 'assets/images/terminal.png',
      title: 'Terminal \nManagement',
      color: '#1D3854',
    ),
    const PaymentOption(
      image1: '',
      image2: 'assets/images/kiosk.png',
      title: 'Toggle \nKiosk Mode',
      color: '#1D3854',
    ),
    const PaymentOption(
      image1: '',
      image2: 'assets/images/history.png',
      title: 'View \nHistory',
      bgImage: 'assets/images/historyimage.png',
    ),
  ];

  void onOptionTap(PaymentOption option) {
    Get.toNamed('/details', arguments: option);
  }
}
