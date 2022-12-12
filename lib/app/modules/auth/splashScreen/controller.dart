import 'package:get/get.dart';
import 'package:meuscheques/app/data/provider/login_provider.dart';
import 'package:meuscheques/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() async {
    var user = LoginProvider.user;
    if (user != null) {
      await LoginProvider.user!.reload();
      if (LoginProvider.user!.emailVerified) {
        LoginProvider loginProvider = LoginProvider();
        await loginProvider.setSignedUser();
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.CONFIRM_EMAIL);
      }
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
