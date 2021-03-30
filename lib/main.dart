import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_page.dart';
import 'app/routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/theme/app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  runApp(GetMaterialApp(
    localizationsDelegates: [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
    ],
    supportedLocales: [
      Locale("pt", "BR"),
    ],
    title: 'Meus Cheques',
    debugShowCheckedModeBanner: false,
    getPages: AppPages.routes,
    initialRoute: Routes.HOME,
    theme: appThemeData,
  ));
}
