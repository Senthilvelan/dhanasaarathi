// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'controller/login_controller.dart';
//
// class LoginScreen extends StatelessWidget {
//   final LoginController controller = Get.put(LoginController());
//
//   LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 100),
//
//             // Welcome Text
//             const Text(
//               "Welcome Back,\nWe Missed You! 🎉",
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             // Subtitle
//             const Text(
//               "Glad to have you back at ",
//               style: TextStyle(fontSize: 14, color: Colors.white60),
//             ),
//             const Text(
//               "Dhan Saarthi",
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             // Phone Number Input
//             const Text(
//               "Enter your phone number",
//               style: TextStyle(fontSize: 14, color: Colors.white70),
//             ),
//
//             const SizedBox(height: 10),
//
//             // Input Field
//             TextField(
//               controller: controller.phoneController,
//               keyboardType: TextInputType.phone,
//               style: const TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 prefixText: "+91  ",
//                 prefixStyle: const TextStyle(color: Colors.white, fontSize: 16),
//                 filled: true,
//                 fillColor: Colors.white10,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             // Proceed Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: controller.proceedToOtp,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child: const Text("Proceed", style: TextStyle(fontSize: 16)),
//               ),
//             ),
//
//             const Spacer(),
//
//             // Terms & Privacy Policy
//             const Center(
//               child: Text.rich(
//                 TextSpan(
//                   text: "By signing in, you agree to our ",
//                   style: TextStyle(fontSize: 12, color: Colors.white54),
//                   children: [
//                     TextSpan(
//                       text: "T&C",
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                     TextSpan(text: " and "),
//                     TextSpan(
//                       text: "Privacy Policy",
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
