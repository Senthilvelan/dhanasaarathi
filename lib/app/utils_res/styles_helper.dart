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
