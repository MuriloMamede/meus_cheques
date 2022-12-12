// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:meuscheques/app/modules/auth/confirmEmail/page.dart';
import 'package:meuscheques/app/modules/auth/login/binding.dart';
import 'package:meuscheques/app/modules/auth/login/page.dart';
import 'package:meuscheques/app/modules/auth/splashScreen/binding.dart';
import 'package:meuscheques/app/modules/auth/splashScreen/page.dart';
import 'package:meuscheques/app/modules/home/bindings/home_binding.dart';
import 'package:meuscheques/app/modules/home/views/home_page.dart';
import 'package:meuscheques/app/routes/middlewares/auth_middleware.dart';

part 'app_routes.dart';



class AppPages {
  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => const SplashScreenView(),
        binding: SplashScreenBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.CONFIRM_EMAIL,
        page: () => ConfirmEmailView(),
        binding: LoginBinding(),
        middlewares: [AuthMiddleware()]),
  ];
}
