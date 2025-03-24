import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils_res/font_family.dart';
import '../widgets/animations/ripple_effect_animation.dart';
import 'shimmer_animation.dart';

class CustomButtons {
  static onBoardingButtons({label, imgPath, color, textColor, onPressed}) {
    return Ripple(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              imgPath,
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                // fontWeight: FontWeight800,
                fontFamily: FontFamily.MONO_SANS_EBW,
              ),
            ),
            const SizedBox(
              width: 0,
            ),
          ],
        ),
      ),
    );
  }

  static simmerBox(height, width) {
    return Shimmer.fromColors(
      baseColor: const Color(0xff1D2834),
      highlightColor: const Color(0xff253241),
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Color(0xff253241),
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
        ),
      ),
    );
  }
}
