import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'color_helper.dart';

class SnackBarHelper {
  static late Timer _timer;
  static ValueNotifier<bool> isToastShowing = ValueNotifier<bool>(true);

  static errorSnackbar(
      {required String msg,
      required String content,
      Color? color,
      int secd = 4}) {
    return Get.rawSnackbar(
      message: "$content",
      titleText: Text(msg),
      // color: White,
      margin: const EdgeInsets.all(1),
      borderRadius: 0.0,
      duration: Duration(seconds: secd),
      backgroundColor: color == null ? Colors.red : color,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
    );
  }

  static successSnackbar(
      {required String msg, required String content, Color? color}) {
    return Get.rawSnackbar(
      message: "$content",
      titleText: Text(msg),
      borderRadius: 0.0,
      margin: const EdgeInsets.all(1),
      duration: const Duration(seconds: 4),
      backgroundColor: color == null ? blueMarine : color,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
    );
  }

  static getInternetConnectionStatus() async {
    return await InternetConnectionCheckerPlus().hasConnection;
  }

  static showNoInternet(
      {String content = "No Internet connection",
      Color? color,
      int seconds = 3}) {
/*    if (getInternetConnectionStatus() == false) {
      content = "No Internet connection";
    } else {
      if (kDebugMode) {
        if (content == "No Internet connection") {
          content = "Url is not reachable";
        }
      } else {
        content = "";
      }
    }*/

    if (isToastShowing.value = false) return;
    isToastShowing.value = false;

    // ToastView.showNoInternet(NavigationService.navigatorKey.currentContext!);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color(0xff263545),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 8.0,
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xffffffff),
            ),
          ),
        ],
      ),
    );

    _timer = Timer(
        const Duration(milliseconds: 3030), () => isToastShowing.value = true);
    return Get.snackbar(
      "",
      '',
      messageText: toast,
      titleText: Container(),
      // colorText: textColorMain,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.transparent,
      // borderColor: Colors.transparent,
      // colorText: Colors.transparent,
      overlayColor: Colors.transparent,
      barBlur: 0,
      overlayBlur: 0,

      isDismissible: true,
    );
  }

  static showRestoreInternet(
      {String content = "Internet connection restored",
      Color? color,
      int secd = 4}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color(0xff263545),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 8.0,
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xffffffff),
            ),
          ),
        ],
      ),
    );

    return Get.snackbar(
      "",
      '',
      messageText: toast,
      titleText: Container(),
      // colorText: textColorMain,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.transparent,
      // borderColor: Colors.transparent,
      // colorText: Colors.transparent,
      overlayColor: Colors.transparent,
      barBlur: 0,
      overlayBlur: 0,
      // padding: const EdgeInsets.all(16),
      // margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      isDismissible: true,
    );
  }

  static showNewError(String content, {Color? color, int seconds = 3}) {
    if (isToastShowing.value = false) return;
    isToastShowing.value = false;

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color(0xff263545),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 8.0,
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xffffffff),
            ),
          ),
        ],
      ),
    );

    _timer = Timer(
        const Duration(milliseconds: 3030), () => isToastShowing.value = true);
    return Get.snackbar(
      "",
      '',
      messageText: toast,
      titleText: Container(),
      // colorText: textColorMain,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.transparent,
      // borderColor: Colors.transparent,
      // colorText: Colors.transparent,
      overlayColor: Colors.transparent,
      barBlur: 0,
      overlayBlur: 0,
      // padding: const EdgeInsets.all(16),
      // margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      isDismissible: true,
    );
  }
}
