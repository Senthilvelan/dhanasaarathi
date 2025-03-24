import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';

class WelcomeController extends GetxController {
  var logoOpacity = 0.0.obs;
  var buttonOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    animateLogo();
  }

  void animateLogo() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    logoOpacity.value = 1.0;

    await Future.delayed(const Duration(milliseconds: 900));
    buttonOpacity.value = 1.0;
  }

  void navigateToHome() {
    Get.offAllNamed(AppRoutes.screenLogin);
  }
}
