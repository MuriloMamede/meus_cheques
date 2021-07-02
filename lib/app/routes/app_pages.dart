import 'package:get/get.dart';

import 'package:meuscheques/app/modules/home/bindings/home_binding.dart';
import 'package:meuscheques/app/modules/home/views/home_page.dart';
import 'package:meuscheques/app/modules/login/bindings/login_binding.dart';
import 'package:meuscheques/app/modules/login/views/login_view.dart';
import 'package:meuscheques/app/modules/singup/bindings/signup_binding.dart';
import 'package:meuscheques/app/modules/singup/views/signup_page.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SINGUP,
      page: () => SingupView(),
      binding: SignupBinding(),
    ),
  ];
}
