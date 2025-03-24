import 'package:dhansaarathi/app/font/my_font_family.dart';
import 'package:dhansaarathi/app/utils_res/color_helper.dart';
import 'package:flutter/material.dart';

class TextViewHelper {
  static styleHelper() {
    const TextStyle(
      fontWeight: FontWeight.w800,
      fontFamily: MyFontFamily.GILROY_SEMIBOLD,
      fontSize: 14,
      color: white,
    );
  }

  static getSemiBoldWhite({double size = 24}) {
    TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w600,
      fontFamily: MyFontFamily.GILROY_SEMIBOLD,
      color: Colors.white,
    );
  }
}
