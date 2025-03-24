import 'package:dhansaarathi/ui/5fundfullscreen/fund_fullsceen.dart';
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
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.screenLogin,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.screenOtp,
      page: () => OtpScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.screenHome,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.screenFullFund,
      page: () => FundFullScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 900),
    ),
  ];
}
