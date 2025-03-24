import 'dart:async';

import 'package:dhansaarathi/app/utils/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../app/utils_res/string_helper.dart';
import '../../4home/home_screen.dart';

class OtpController extends GetxController {
  FocusNode focusNode = FocusNode();

  final String phoneNumber = Get.arguments ?? '';

  final supabase = Supabase.instance.client;

  var isLoading = false.obs;
  var maskedPhoneNumber = ''.obs;
  var resendEnabled = false.obs;
  var resendTimer = 60.obs;
  Timer? _timer;

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      try {
        focusNode ??= FocusNode();
        focusNode.requestFocus();
        startResendCountdown();
        maskedPhoneNumber.value = maskPhoneNumber(phoneNumber);
      } catch (e) {
        if (kDebugMode) print("exception");
      }
    });
  }

  @override
  void onClose() {
    try {
      if (focusNode != null) focusNode.dispose();
    } catch (e) {
      if (kDebugMode) print("exception");
    }

    super.onClose();
  }

  void startResendCountdown() {
    resendEnabled.value = false;
    resendTimer.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        resendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  // Send OTP
  Future<void> reSendOTP(String phoneNumber) async {
    isLoading.value = true;
    try {
      maskedPhoneNumber.value = maskPhoneNumber(phoneNumber);
      await supabase.auth.signInWithOtp(phone: phoneNumber);
      // SupabaseMyClient.verifyOtpToMobile("91"+phoneNumber, otp)
      Get.snackbar('Success', 'OTP sent to $maskedPhoneNumber');
      startResendCountdown();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP
  Future<void> verifyOTP(String phoneNumber, String otp) async {
    isLoading.value = true;
    try {
      final response = await supabase.auth.verifyOTP(
        phone: "91$phoneNumber",
        token: otp,
        type: OtpType.sms,
      );

      if (response.session != null) {
        Utilities.showToast('Success', 'Login successful');
        await StringHelper.setLoggedIn("true");
        Get.offAll(() => HomeScreen());
      } else {
        Utilities.showToast('Error', 'Invalid OTP');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String maskPhoneNumber(String phone) {
    if (phone.length < 6) return phone;
    return phone.replaceRange(3, phone.length - 3, '*' * (phone.length - 6));
  }
}
