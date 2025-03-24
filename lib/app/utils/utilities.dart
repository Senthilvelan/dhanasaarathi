import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart' as lockSync;

class Utilities {
  static int badgeCount = 0;

  static showBadge() async {
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        badgeCount = badgeCount + 1;
        if (badgeCount <= 0) badgeCount = 1;
        FlutterAppBadger.updateBadgeCount(badgeCount);
      }
    } catch (e) {
      if (kDebugMode)
        print("FlutterAppBadger PlatformException " + e.toString());
    }
  }

  static clearBadge() {
    try {
      // FlutterAppBadger.isAppBadgeSupported().then((res) {
      try {
        if (true) FlutterAppBadger.removeBadge();
      } catch (e) {
        if (kDebugMode) print("PlatformException for FlutterAppBadger");
      }
      // });
    } catch (e) {
      if (kDebugMode) print("PlatformException for FlutterAppBadger");
    }
  }

  static showToast(String title, String message) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      // Show at the bottom
      backgroundColor: Colors.blueGrey.withOpacity(.6),
      // Red background for error
      colorText: Colors.white,
      // White text for contrast
      borderRadius: 8,
      // Rounded corners
      margin: const EdgeInsets.all(8),
      // Add some margin
      duration: const Duration(seconds: 3),
      // Show for 3 seconds
      icon: const Icon(Icons.info, color: Colors.white), // Add error icon
    );
  }

}
