import 'package:dhansaarathi/app/routes/app_pages.dart';
import 'package:dhansaarathi/app/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/service/supabase_client.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();

  LoginController() {}

  void proceedToOtp() async {
    if (phoneController == null) {
      Utilities.showToast("Error", "Invalid Number !");
      return;
    }
    if (phoneController.text == null) {
      Utilities.showToast("Error", "Invalid Number !");
      return;
    }
    if (phoneController.text.trim() == null) {
      Utilities.showToast("Error", "Invalid Number !");
      return;
    }

    // Get.toNamed(AppRoutes.screenOtp);
    if (phoneController.text.trim().length == 10) {
      bool success = await SupabaseMyClient.sendOtpToMobile(
          "91${phoneController.text.trim()}");

      if (success) {
        Utilities.showToast("Saarathi", "OTP sent successfully !");
        Get.toNamed(AppRoutes.screenOtp,
            arguments: phoneController.text.trim());
      } else {
        Utilities.showToast("Saarathi", "Failed to send OTP,try again !");
      }
    } else {
      Get.snackbar("Invalid Number", "Please enter a valid 10-digit number",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
