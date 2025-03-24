import 'package:dhansaarathi/app/font/my_font_family.dart';
import 'package:flutter/material.dart';

class TextViewHelper {
  static styleHelper() {
    const TextStyle(
      fontWeight: FontWeight.w800,
      fontFamily: MyFontFamily.GILROY_SEMIBOLD,
      fontSize: 14,
      color: Colors.white,
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

  static getBoxDecor() {
    return BoxDecoration(
        color: Colors.grey.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(.5),
          width: 0.5,
        ));
  }


  static getBoxDecorTrans() {
    return BoxDecoration(
        color: Colors.grey.withOpacity(.01),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(.01),
          width: 0.5,
        ));
  }
}
