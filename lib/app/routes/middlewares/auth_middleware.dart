import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  List<String> publicRoutes = [
    Routes.LOGIN,
    Routes.SPLASH_SCREEN,
  ];
  dynamic arguments;
  @override
  RouteSettings? redirect(String? route) {
    return null;
      // RouteSettings(name: route);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    debugPrint('Page >> ${page.toString()} called');
    arguments = page?.arguments;
    return page;
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    // This function will be called right before the Bindings are initialize,
    // then bindings is null
    return bindings;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    debugPrint('Bindings of ${page.toString()} are ready');
    return page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    debugPrint('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    debugPrint('PageDisposed');
  }
}
