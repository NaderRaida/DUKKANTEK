import 'dart:async';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/AppLogo.dart';
import 'package:app/main.dart' as main;
import 'package:app/constants/colors.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/views/auth/LoginScreen.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String notificationId = "";
  bool fromNotification = false;
  String type = "";
  dynamic badgeNumber;
  dynamic id;
  @override
  void initState() {
    super.initState();
    AppStorage().setUserType(STUDENT);
    startTime();
  }



  void navigationPage() {
    Get.offAll(()=> AppStorage().getUserToken() == null ? LoginScreen() : HomeScreen()
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        context: main.navigatorKey.currentContext,
        designSize: const Size(375, 812),
        orientation: Orientation.portrait);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.splashChromeSetting(),
      child: Container(
        color: white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: white,
            body: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: AppLogo(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
