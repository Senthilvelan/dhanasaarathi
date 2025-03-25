import 'package:dhansaarathi/app/utils/widgets/background_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/utils_res/color_helper.dart';
import 'controller/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeController controller = Get.put(WelcomeController());

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
      assignId: true,
      builder: (logic) {
        return MainBackground(
          back: false,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Obx(() => AnimatedOpacity(
                        duration: const Duration(seconds: 3),
                        opacity: controller.logoOpacity.value,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/logo_d.svg",
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                      )),

                  const SizedBox(height: 16),

                  // Welcome Text
                  const Text(
                    "Welcome to\nDhanSaarthi !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const Spacer(),

                  // Button with Fade-in Animation
                  InkWell(
                    onTap: logic.navigateToHome,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "One step closer to smarter\ninvesting. Let's begin!",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: secondaryTextgColor,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: blueMarine,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_forward,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    // child: Obx(() => Padding(
                    //       padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           const Text(
                    //             "One step closer to smarter\ninvesting. Let's begin!",
                    //             textAlign: TextAlign.start,
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w400,
                    //               color: secondaryTextgColor,
                    //             ),
                    //           ),
                    //           AnimatedOpacity(
                    //             duration: const Duration(seconds: 1),
                    //             opacity: controller.buttonOpacity.value,
                    //             child: Container(
                    //               padding: const EdgeInsets.all(12),
                    //               decoration: const BoxDecoration(
                    //                 color: blueMarine,
                    //                 shape: BoxShape.circle,
                    //               ),
                    //               child: const Icon(Icons.arrow_forward,
                    //                   color: Colors.white),
                    //             ),
                    //             // child: GestureDetector(
                    //             //   onTap: controller.navigateToHome,
                    //             //   child: Container(
                    //             //     padding: const EdgeInsets.all(12),
                    //             //     decoration: const BoxDecoration(
                    //             //       color: blueMarine,
                    //             //       shape: BoxShape.circle,
                    //             //     ),
                    //             //     child: const Icon(Icons.arrow_forward,
                    //             //         color: Colors.white),
                    //             //   ),
                    //             // ),
                    //           ),
                    //         ],
                    //       ),
                    //     )),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
