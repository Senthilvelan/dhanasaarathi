import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StylesHelper {
  static Widget bottomSheetStylesTrans({height, @required child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: child),
    );
  }
}
