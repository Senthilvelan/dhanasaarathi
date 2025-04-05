import 'package:dhansaarathi/app/routes/app_pages.dart';
import 'package:dhansaarathi/app/utils/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/service/supabase_client.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  FocusNode focusNode = FocusNode();

  LoginController() {}

  RxBool isDisabled = false.obs;

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 300), () {
      try {
        focusNode ??= FocusNode();
        focusNode.requestFocus();
      } catch (e) {
        if (kDebugMode) print("exception");
      }
    });

    phoneController.addListener(() {
      if (phoneController == null) {
        return;
      }
      if (phoneController.text == null) {
        return;
      }
      if (phoneController.text.trim() == null) {
        return;
      }

      if (phoneController.text.trim().length == 10) {
        isDisabled.value = true;
      } else {
        isDisabled.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    try {
      if (focusNode != null) focusNode.dispose();
      if (phoneController != null) phoneController.dispose();
    } catch (e) {
      if (kDebugMode) print("exception");
    }

    super.onClose();
  }

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
        //todo: bypassed
        Get.toNamed(AppRoutes.screenOtp,
            arguments: phoneController.text.trim());
        // Utilities.showToast("Saarathi", "Failed to send OTP,try again !");
      }
    } else {
      Get.snackbar("Invalid Number", "Please enter a valid 10-digit number",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
