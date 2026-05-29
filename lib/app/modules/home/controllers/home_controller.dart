import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../data/models/payment_option.dart';
import '../../../theme/app_colors.dart';

class HomeController extends GetxController {
  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  final options = const <PaymentOption>[
    PaymentOption(
      title: 'Mobile \nPayment',
      icon: AppAssets.momoIcon,
      sideIcon: AppAssets.momo,
      gradient: AppColors.mobilePaymentGradient,
    ),
    PaymentOption(
      title: 'Card \nPayment',
      icon: AppAssets.cardIcon,
      sideIcon: AppAssets.card,
      color: AppColors.tileSurface,
    ),
    PaymentOption(
      title: 'Qr \nPayment',
      icon: AppAssets.qr,
      color: AppColors.tileSurface,
    ),
    PaymentOption(
      title: 'Terminal \nManagement',
      icon: AppAssets.terminal,
      color: AppColors.tileSurface,
    ),
    PaymentOption(
      title: 'Toggle \nKiosk Mode',
      icon: AppAssets.kiosk,
      color: AppColors.tileSurface,
    ),
    PaymentOption(
      title: 'View \nHistory',
      icon: AppAssets.history,
      backgroundImage: AppAssets.historyBackground,
    ),
  ];
}
