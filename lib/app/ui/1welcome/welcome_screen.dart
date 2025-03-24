// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'controller/welcome_controller.dart';
//
// class WelcomeScreen extends StatelessWidget {
//   final WelcomeController controller = Get.put(WelcomeController());
//
//   WelcomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<WelcomeController>(
//       assignId: true,
//       builder: (logic) {
//         return Scaffold(
//           backgroundColor: Colors.black,
//           body: Stack(
//             children: [
//               // Background Gradient
//               Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.black, Colors.black87],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//
//               // Content
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(),
//
//                   // Logo with Fade-in Animation
//                   Obx(() => AnimatedOpacity(
//                         duration: const Duration(seconds: 1),
//                         opacity: controller.logoOpacity.value,
//                         child: const Center(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: [
//                               Text(
//                                 'd',
//                                 style: TextStyle(
//                                   fontSize: 120,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                               Positioned(
//                                 top: -10,
//                                 child: Icon(
//                                   Icons.arrow_upward,
//                                   size: 40,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )),
//
//                   const SizedBox(height: 20),
//
//                   // Welcome Text
//                   const Text(
//                     "Welcome to\nDhanSaarthi!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   // Subtitle
//                   const Text(
//                     "One step closer to smarter\ninvesting. Let's begin!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white54,
//                     ),
//                   ),
//
//                   const Spacer(),
//
//                   // Button with Fade-in Animation
//                   Obx(() => AnimatedOpacity(
//                         duration: const Duration(seconds: 1),
//                         opacity: controller.buttonOpacity.value,
//                         child: GestureDetector(
//                           onTap: controller.navigateToHome,
//                           child: Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: const BoxDecoration(
//                               color: Colors.blue,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(Icons.arrow_forward,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       )),
//
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
