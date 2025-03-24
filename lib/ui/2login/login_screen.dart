import 'package:dhansaarathi/app/utils_res/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/utils/widgets/background_login_otp.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (logic) {
      return LoginOtpBackground(child: getLoginContent());
    });
  }

  Widget getLoginContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Phone Number Input
        const Text(
          "Enter your phone number",
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),

        const SizedBox(height: 12),

        TextField(
          focusNode: controller.focusNode,
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          style: const TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            prefixText: "+91  ",
            prefixStyle: const TextStyle(color: Colors.white70, fontSize: 16),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 24),

        Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isDisabled.value
                    ? controller.proceedToOtp
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      controller.isDisabled.value ? blueMarine : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text("Proceed",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    )),
              ),
            )),

        // Proceed Button
        // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     onPressed: controller.proceedToOtp,
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: blueMarine,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(12),
        //       ),
        //       padding: const EdgeInsets.symmetric(vertical: 12),
        //     ),
        //     child: const Text("Proceed", style: TextStyle(fontSize: 16)),
        //   ),
        // ),
      ],
    );
  }
}
