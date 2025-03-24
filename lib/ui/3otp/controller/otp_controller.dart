import 'dart:async';

import 'package:dhansaarathi/app/utils/utilities.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpController extends GetxController {
  // String phoneNumber = "";
  // dynamic profileData = Get.arguments;
  final String phoneNumber = Get.arguments ?? '';

  final supabase = Supabase.instance.client;

  var isLoading = false.obs;
  var maskedPhoneNumber = ''.obs;
  var resendEnabled = false.obs;
  var resendTimer = 30.obs;
  Timer? _timer;

  // Start countdown for resend button
  void startResendCountdown() {
    resendEnabled.value = false;
    resendTimer.value = 30;
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
        phone: phoneNumber,
        token: otp,
        type: OtpType.sms,
      );

      if (response.session != null) {
        Utilities.showToast('Success', 'Login successful');
        // Get.offAll(() => HomeScreen());
      } else {
        Utilities.showToast('Error', 'Invalid OTP');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Mask phone number (e.g., 964*****405)
  String maskPhoneNumber(String phone) {
    if (phone.length < 6) return phone;
    return phone.replaceRange(3, phone.length - 3, '*' * (phone.length - 6));
  }
}

/*
class OtpController extends GetxController {
  final otp = ''.obs;
  final isProcessing = false.obs;
  final countdown = 30.obs;
  final canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  void updateOtp(String value) {
    otp.value = value;
  }

  void startCountdown() {
    canResend.value = false;
    countdown.value = 30;
    Future.delayed(const Duration(seconds: 1), () {
      if (countdown.value > 0) {
        countdown.value--;
        startCountdown();
      } else {
        canResend.value = true;
      }
    });
  }

  void resendOtp() {
    if (canResend.value) {
      // Implement resend OTP logic here
      startCountdown();
    }
  }

  void verifyOtp() {
    if (otp.value.length == 6) {
      isProcessing.value = true;
      // Implement OTP verification logic here
      Future.delayed(const Duration(seconds: 2), () {
        isProcessing.value = false;
        // Navigate to next screen on success
        Get.offAllNamed('/home');
      });
    } else {
      Get.snackbar('Error', 'Please enter a valid OTP');
    }
  }

  void test() async {
    try {
      final email = "";
      final password = "";
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
    } catch (e) {}
  }



} */
