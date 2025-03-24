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



  static String getTimeStamp() {
    // DateTime dateTime = DateTime.now().toUtc();
    // String ts = dateTime.toString();
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static int getTimeStampAsInt() {
    // DateTime dateTime = DateTime.now().toUtc();
    // String ts = dateTime.toString();
    return DateTime.now().millisecondsSinceEpoch;
  }

  String getTimeAMPM(String time) {
    // print('time $time');
    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(3, 5));
    TimeOfDay time1 = TimeOfDay(hour: hour, minute: minute);
    String hour1 = "";
    if (time1.hourOfPeriod.toString().length == 1) {
      hour1 = "0${time1.hourOfPeriod.toString()}";
    } else {
      hour1 = time1.hourOfPeriod.toString();
    }
    String minute1 = "";
    if (time1.minute.toString().length == 1) {
      minute1 = "0${time1.minute.toString()}";
    } else {
      minute1 = time1.minute.toString();
    }
    String data =
        "${hour1}:${minute1}:${time1.period.toString().contains('am') ? 'AM' : 'PM'}";
    return data;
  }

  String getDateTimeAMPM(String time) {
    int hour = int.parse(time.substring(11, 13));
    int minute = int.parse(time.substring(14, 16));
    TimeOfDay time1 = TimeOfDay(hour: hour, minute: minute);
    String hour1 = "";
    if (time1.hourOfPeriod.toString().length == 1) {
      hour1 = "0${time1.hourOfPeriod.toString()}";
    } else {
      hour1 = time1.hourOfPeriod.toString();
    }
    String minute1 = "";
    if (time1.minute.toString().length == 1) {
      minute1 = "0${time1.minute.toString()}";
    } else {
      minute1 = time1.minute.toString();
    }
    String data =
        "$hour1:$minute1:${time1.period.toString().contains('am') ? 'AM' : 'PM'}";
    return time.substring(0, 11) + data;
  }

  getTimeStampNow() {
    return DateTime.now();
  }


// Future<String> getAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   if (App.currentVersion.isNotEmpty) {
  //     return "Version ${App.currentVersion}";
  //   }
  //   App.currentVersion = packageInfo.version;
  //   return "Version ${packageInfo.version}";
  // }
  //
  // Future<String> getAppBuildNumber() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   // The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  //   return packageInfo.buildNumber;
  // }

}
