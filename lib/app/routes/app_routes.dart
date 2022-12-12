// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const CONFIRM_EMAIL = _Paths.CONFIRM_EMAIL;
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
}

abstract class _Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const SPLASH_SCREEN = '/splash_screen';
  static const CONFIRM_EMAIL = '/confirm-email';
}
