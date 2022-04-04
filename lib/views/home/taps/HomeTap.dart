
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({Key? key}) : super(key: key);

  @override
  _HomeTapState createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      init: GeneralController(),
      builder: (controller){
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: 19.w,
            top: 10.h,
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: Stack(
              children: [
                if(!controller.isLoading)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomText(
                          "myInfo",
                          fontSize: 17,
                          fontFamily: PRIMARY_FONT_BOLD,
                          textColor: lightBlue,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomText(
                          "Hello , {${AppStorage().getUser()!.email}}",
                          fontSize: 24,
                          translate: false,
                          fontFamily: PRIMARY_FONT_BOLD,
                          textColor: red,
                        ),
                      ],
                    ),
                  ),
                if(controller.isLoading)
                  LoadingApp(height: 700.h,)
              ],
            ),
          ),
        );
      },
    );
  }
}
