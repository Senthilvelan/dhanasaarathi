import 'dart:convert';
import 'dart:typed_data';

import 'package:dhansaarathi/ui/1welcome/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StringHelper {
  static String logedIn = "logedIn";

  //logedIn
  static Future setLoggedIn(String value) async {
    SingletonSecureStorage().write(key: logedIn, value: value);
  }

  static Future<String?> getLoggedIn() async {
    return SingletonSecureStorage().read(key: logedIn);
  }

  static Future clearPreferenceData() async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    return SingletonSecureStorage().deleteAll();
  }

  static Future clearPreferenceDataAndGetOff() async {
    SingletonSecureStorage().deleteAll().then((value) {
      // Get.offAllNamed(AppRoutes.screenWelcome);

      Get.offAll(() => WelcomeScreen());
    });
  }
}

class SingletonSecureStorage {
  static final SingletonSecureStorage _singleton =
      SingletonSecureStorage._internal();
  var storage;

  factory SingletonSecureStorage() {
    return _singleton;
  }

  getInstance() {
    if (_singleton != null) return _singleton;
  }

  init() {
    // Create storage
    storage = new FlutterSecureStorage();
  }

  Future write({required String key, required String value}) async {
    if (storage == null) init();

    String baseValue = base64.encode(value.codeUnits);
    // write value
    await storage.write(key: key, value: baseValue);
  }

  Future<String> read({required String key}) async {
    if (storage == null) init();
    // String? key = prefs.getString('${access_token}');
    // Read value

    String? value = await storage.read(key: key);
    Uint8List decodeValue = base64.decode(value == null ? "" : value);
    return String.fromCharCodes(decodeValue);
  }

  Future delete({required String key}) async {
    if (storage == null) init();
    // Delete value
    await storage.delete(key: key);
  }

  Future deleteAll() async {
    if (storage == null) init();
    // Delete value
    await storage.deleteAll();
  }

  Future<Map<String, String>> readAll() async {
    if (storage == null) init();
    // Read all value
    Map<String, String> allValues = await storage.readAll();
    return allValues;
  }

  SingletonSecureStorage._internal();
}
