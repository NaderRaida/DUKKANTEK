import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingApp extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color containerColor;

  LoadingApp({
    this.width = 1.0,
    this.height = 1.0,
    this.color = primaryColor,
    this.containerColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 1.0 ? width.sw : width.w,
      height: height == 1.0 ? height.sh : height.h,
      color: containerColor,
      child: Align(
        alignment: Alignment.center,
        child: Center(
          child: Container(
            width: 50.0.w,
            height: 50.0.w,
            child: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              colors: [primaryColor, primaryColor.withOpacity(.9)],
            ),
          ),
        ),
      ),
    );
  }
}
