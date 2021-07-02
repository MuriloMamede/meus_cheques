import 'package:get/get.dart';
import 'package:meuscheques/app/modules/login/controllers/login_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
