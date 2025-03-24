import 'package:dhansaarathi/app/utils_res/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../app/utils/widgets/background_login_otp.dart';
import 'controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  final OtpController otpController = Get.put(OtpController());
  final textOtpController = TextEditingController();

  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(builder: (logic) {
      return LoginOtpBackground(child: getOtpContent(logic));
    });
  }

  Widget getOtpContent(OtpController logic) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Enter OTP',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          // OTP Input Field

          Pinput(
            length: 6,
            controller: textOtpController,
            defaultPinTheme: PinTheme(
              height: 50,
              // width: double.infinity,
              width: (Get.width / 7),
              textStyle: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white54, width: 2),
                ),
              ),
            ),
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: (Get.width / 7),
                  // width: double.infinity,

                  height: 2,
                  color: Colors.white70,
                ),
              ],
            ),
            onCompleted: (pin) {
              otpController.verifyOTP(
                  logic.phoneNumber, pin); // Call OTP verification
            },
          ),

          const SizedBox(height: 16),

          // Resend OTP
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Didn't receive OTP?",
                      style: TextStyle(color: Colors.white70)),
                  TextButton(
                    onPressed: otpController.resendEnabled.value
                        ? () => otpController.reSendOTP(logic.phoneNumber)
                        : null,
                    child: Text(
                      otpController.resendEnabled.value
                          ? "Resend"
                          : "Resend in ${otpController.resendTimer.value}s",
                      style: TextStyle(
                        color: otpController.resendEnabled.value
                            ? blueMarine
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              )),

          // Masked phone number
          Obx(() => Text(
                "OTP has been sent on ${otpController.maskedPhoneNumber.value}",
                style: const TextStyle(color: Colors.white54),
              )),

          const SizedBox(height: 30),

          // Proceed Button
          Obx(() => Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: otpController.isLoading.value
                      ? null
                      : () => otpController.verifyOTP(
                          logic.phoneNumber, textOtpController.text.trim()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                  ),
                  child: otpController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Proceed",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )),
        ],
      ),
    );
  }
}
