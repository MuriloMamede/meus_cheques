import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:meuscheques/app/modules/home/bindings/home_binding.dart';
import 'package:meuscheques/app/modules/home/views/home_page.dart';
import 'package:meuscheques/app/routes/app_routes.dart';

class AppPages {
  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
