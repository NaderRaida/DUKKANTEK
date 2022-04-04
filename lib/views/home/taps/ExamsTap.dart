import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamsTap extends StatefulWidget {
  const ExamsTap({Key? key}) : super(key: key);

  @override
  _ExamsTapState createState() => _ExamsTapState();
}

class _ExamsTapState extends State<ExamsTap> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              white
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            stops: [0.5, 0.5],
          ),
        ),
        child: Container(
          margin: EdgeInsetsDirectional.only(
              top: 10.h
          ),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(28.w,),
                topStart: Radius.circular(28.w,),
              )
          ),
        ),
      ),
    );
  }
}
