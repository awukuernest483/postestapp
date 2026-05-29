import 'package:get/get.dart';

import '../modules/details/bindings/details_binding.dart';
import '../modules/details/views/details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.details,
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
  ];
}
