import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../../app/utils_res/string_helper.dart';

class WelcomeController extends GetxController {
  RxDouble logoOpacity = 0.3.obs;

  // var buttonOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    animateLogo();
  }

  void animateLogo() async {
    await Future.delayed(const Duration(milliseconds: 900));
    logoOpacity.value = 1.0;

    // await Future.delayed(const Duration(milliseconds: 900));
    // buttonOpacity.value = 1.0;
  }

  void navigateToHome() async {
    StringHelper.getLoggedIn().then((value) {
      if (value != null) {
        if (value == "true") {
          Get.offAllNamed(AppRoutes.screenHome);
        } else {
          Get.offAllNamed(AppRoutes.screenLogin);
        }
      } else {
        Get.offAllNamed(AppRoutes.screenLogin);
      }
    });
  }
}
