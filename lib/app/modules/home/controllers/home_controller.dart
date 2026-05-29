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
      image1: 'assets/icons/momo.svg',
      image2: 'assets/icons/momoicon.svg',
      title: 'Mobile \nPayment',
    ),
    const PaymentOption(
      image1: 'assets/icons/card.svg',
      image2: 'assets/icons/cardicon.svg',
      title: 'Card \nPayment',
      color: '#1D3854',
    ),
    const PaymentOption(
      image1: '',
      image2: 'assets/icons/qr.svg',
      title: 'Qr \nPayment',
      color: '#1D3854',
    ),
    const PaymentOption(
      image1: '',
      image2: 'assets/icons/terminal.svg',
      title: 'Terminal \nManagement',
      color: '#1D3854',
    ),
    const PaymentOption(
      image1: '',
      image2: 'assets/icons/kiosk.svg',
      title: 'Toggle \nKiosk Mode',
      color: '#1D3854',
    ),
    const PaymentOption(
      image1: '',
      image2: 'assets/icons/history.svg',
      title: 'View \nHistory',
      bgImage: 'assets/images/historyimage.png',
    ),
  ];

  void onOptionTap(PaymentOption option) {
    Get.toNamed('/details', arguments: option);
  }
}
