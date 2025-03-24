import 'package:flutter/material.dart';

import '../../utils_res/color_helper.dart';
import 'background_main.dart';


/**
 * common bg for login and otp pages, (reusing)
 * */
class LoginOtpBackground extends StatelessWidget {
  const LoginOtpBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getLoginOtpHeader(),
            child,
            const Spacer(),
            getLoginOtpFooter(),
          ],
        ),
      ),
    );
  }

  Widget getLoginOtpHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),

        Text(
          "Welcome Back,\nWe Missed You! 🎉",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        SizedBox(height: 12),

        // Subtitle
        Row(
          children: [
            Text(
              "Glad to have you back at ",
              style: TextStyle(fontSize: 14, color: Colors.white60),
            ),
            Text(
              "Dhan Saarthi",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: blueMarine,
              ),
            ),
          ],
        ),

        SizedBox(height: 40),
      ],
    );
  }

  Widget getLoginOtpFooter() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Terms & Privacy Policy
        Center(
          child: Text.rich(
            TextSpan(
              text: "By signing in, you agree to our ",
              style: TextStyle(fontSize: 12, color: Colors.white54),
              children: [
                TextSpan(
                  text: "T&C",
                  style: TextStyle(color: blueMarine),
                ),
                TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(color: blueMarine),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 24),
      ],
    );
  }
}
