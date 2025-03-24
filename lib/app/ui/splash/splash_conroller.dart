// import 'dart:io';
//
// import 'package:get/get.dart';
//
// import '../../routes/app_pages.dart';
// import '../../utils_res/string_helper.dart';
//
// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     // setChannel();
//     Future.delayed(const Duration(seconds: 3), () {
//       navigatePage();
//     });
//     // TODO: implement onInit
//     super.onInit();
//   }
//
//   navigatePage() async {
//     Get.offAndToNamed(Routes.introScreen);
//   }
//
//   Future displayNotification(Map<String, dynamic> message) async {
//     MessageData messageData = MessageData.fromJson(message);
//     String androidNotifyChannel;
//     String title;
//     String bodyNotify;
//     int NotificationLogId = 0;
//     if (Platform.isAndroid) {
//       androidNotifyChannel = (message['android_channel_id']);
//       NotificationLogId = int.parse(message['NotificationLogId']);
//       title = '${message['Title']}';
//       bodyNotify = '${message['message']}';
//     } else {
//       androidNotifyChannel = (message['android_channel_id']);
//       NotificationLogId = int.parse(message['NotificationLogId']);
//       title = '${message['Title']}';
//       bodyNotify = '${message['message']}';
//     }
//   }
//
//   Future onSelectNotification(String? payload) async {
//     if (payload != null) {}
//   }
//
//   Future onDidRecieveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//   }
// }
