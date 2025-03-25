import 'package:get/get.dart';

import '../../ui/1welcome/controller/welcome_controller.dart';
import '../../ui/2login/controller/login_controller.dart';
import '../../ui/3otp/controller/otp_controller.dart';
import '../../ui/4home/contrroller/watchlist_controller.dart';
import '../../ui/5fundfullscreen/controller/fund_fullscreen_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    //pre-login
    Get.lazyPut<WelcomeController>(() => WelcomeController());
    // Get.lazyPut<LoginController>(() => LoginController());
    // Get.lazyPut<OtpController>(() => OtpController());
    //
    // //post login
    // Get.lazyPut<WatchlistController>(() => WatchlistController());
    Get.lazyPut<FundFullscreenController>(() => FundFullscreenController());
  }
}
