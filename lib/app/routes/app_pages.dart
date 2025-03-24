import 'package:dhansaarathi/ui/3otp/otp_screen.dart';
import 'package:get/get.dart';

import '../../ui/1welcome/welcome_screen.dart';
import '../../ui/2login/login_screen.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.screenWelcome,
      page: () => WelcomeScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 330),
    ),
    GetPage(
      name: AppRoutes.screenLogin,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 330),
    ),
    GetPage(
      name: AppRoutes.screenOtp,
      page: () => OtpScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 330),
    ),
  ];
}
