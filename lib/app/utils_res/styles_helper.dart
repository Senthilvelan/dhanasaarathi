import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'color_helper.dart';
import 'font_family.dart';

class StylesHelper {
  /*
    New Styles
   */

  static BoxDecoration innerSummaryCard = BoxDecoration(
    border: Border.all(
      color: const Color(0xFF000000).withOpacity(0.1),
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(20.r),
    ),
    // image: DecorationImage(
    //   image: AssetImage('assets/n_assets/bg_summary_card.png'),
    //   fit: BoxFit.cover,  // BoxFit can be changed based on your requirements.
    // ),
    color: primaryWhiteColor,
  );

  static BoxDecoration cardStyles = BoxDecoration(
    color: primaryWhiteColor,
    borderRadius: BorderRadius.all(
      Radius.circular(
        20.r,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF000000).withOpacity(0.02),
        offset: const Offset(0.0, 5.0),
        blurRadius: 5.0,
      ),
    ],
  );

  static BoxDecoration cardStylesOp = BoxDecoration(
    color: primaryWhiteColor.withOpacity(0.63),
    borderRadius: BorderRadius.all(
      Radius.circular(
        20.r,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF000000).withOpacity(0.02),
        offset: const Offset(0.0, 5.0),
        blurRadius: 5.0,
      ),
    ],
  );

  static BoxDecoration cardStylesWhite = BoxDecoration(
    color: primaryWhiteColor,
    borderRadius: BorderRadius.all(
      Radius.circular(
        16.r,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF000000).withOpacity(0.02),
        offset: const Offset(0.0, 5.0),
        blurRadius: 5.0,
      ),
    ],
  );

  static BoxDecoration cardStylesAlpha60 = BoxDecoration(
    color: primaryWhiteColor2,
    borderRadius: BorderRadius.all(
      Radius.circular(
        16.r,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF000000).withOpacity(0.02),
        offset: const Offset(0.0, 5.0),
        blurRadius: 5.0,
      ),
    ],
  );

  /*
  END New Styles
   */

  static BoxDecoration networkCardStyles = BoxDecoration(
    color: backgroundColor,
    border: Border.all(
      color: cardBorderColor,
      width: 1.0,
      style: BorderStyle.solid,
    ),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(8.0),
    ),
  );

  static TextStyle cardHeadingStyles({@required fontSize}) {
    return TextStyle(
      fontSize: fontSize.sp,
      fontFamily: FontFamily.NEUE,
      fontWeight: FontWeight.w700,
      color: cardHeading,
    );
  }

  static BoxDecoration roundedCardStyles(double radius) {
    return BoxDecoration(
      color: backgroundColor,
      border: Border.all(
        color: cardBorderColor,
        width: 1.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    );
  }

  static Widget blueBorder = Container(
    height: 1.5.h,
    width: Get.width,
    decoration: const BoxDecoration(
      color: primaryColor,
    ),
  );

  static Widget blueBorderTopRounded = Container(
    height: 2.h,
    width: Get.width,
    decoration: const BoxDecoration(
      color: cardBorderColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(44.0),
        topRight: Radius.circular(44.0),
      ),
    ),
  );

/*
  New Styles helper
 */

  static Widget horizontalLine({height}) {
    return Container(
      width: 2.w,
      height: height,
      decoration: const BoxDecoration(
        gradient: horizontalLineGradient,
      ),
    );
  }

  static Widget verticalLine({width, color, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  static getTopLine() {
    return Container(
      width: 90,
      height: 4,
      child: Image.asset("assets/n_assets/ic_dash_grey.png"),
    );
  }

  static Widget bottomSheetStylesTrans({height, @required child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: bgWhiteColor,
      ),
      child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: child),
    );
  }

  static customBlackGradientBottomSheet(
    BuildContext context,
    child,
  ) {
    return showModalBottomSheet<void>(
        backgroundColor: Colors.black.withOpacity(0),
        context: context,
        builder: (BuildContext context) {
          return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 20, bottom: 40),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0),
                    Colors.black,
                  ],
                )),
                child: Center(child: child),
              ));
        });
  }
}
