import 'package:get/get.dart';

import '../../ui/1welcome/welcome_screen.dart';
import '../../ui/2login/login_screen.dart';
import '../../ui/3otp/otp_screen.dart';
import '../../ui/4home/home_screen.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.screenWelcome,
      page: () => WelcomeScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.screenLogin,
      page: () => LoginScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.screenOtp,
      page: () => OtpScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.screenHome,
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 900),
    ),
  ];
}
