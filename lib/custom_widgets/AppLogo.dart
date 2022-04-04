import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final bool withCircle;
  const AppLogo({Key? key,this.withCircle = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withCircle ?
    Container(
      width: 165.w,
      height: 165.w,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(
            79.w,
          ),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.16),
              blurRadius: 6.sp,
              offset: Offset(0.0,3.0),
              spreadRadius: 0,
            ),
          ]
      ),
      child: Center(
        child: FlutterLogo(
          size: withCircle ? 115.w : 124.w,
        ),
      ),
    ) : FlutterLogo(
      size: withCircle ? 120.w : 124.w,
    );
  }

}
