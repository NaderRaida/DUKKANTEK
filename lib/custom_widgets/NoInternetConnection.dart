import 'dart:async';
import 'dart:io';

import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';
import 'CustomText.dart';

class NoInternetConnection extends StatefulWidget {
  @override
  _NoInternetConnectionState createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  MyConnectivity _connectivity = MyConnectivity.instance;
  Map _source = {ConnectivityResult.none: false};

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      _source = source;
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.none:
          print('didChangeDependencies ConnectivityResult.none >>');
          break;
        case ConnectivityResult.mobile:
          print('didChangeDependencies ConnectivityResult.mobile >>');

          Navigator.pushAndRemoveUntil(
              navigatorKey.currentContext!,
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false);

          break;
        case ConnectivityResult.wifi:
          print('didChangeDependencies ConnectivityResult.wifi >>');

          Navigator.pushAndRemoveUntil(
              navigatorKey.currentContext!,
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false);

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.whiteChromeSetting(),
      child: GetBuilder<GeneralController>(
        init: GeneralController(),
        builder: (controller) {
          switch (_source.keys.toList()[0]) {
            case ConnectivityResult.none:
              controller.setInternetStatus(false);
              break;
            case ConnectivityResult.mobile:
              controller.setInternetStatus(true);
              break;
            case ConnectivityResult.wifi:
              controller.setInternetStatus(true);
              break;
          }
          return WillPopScope(
            onWillPop: () {
              if (controller.getInternetStatus) {
                Get.offAll(HomeScreen());
              } else {
                setState(() {
                  print("==>>> ${controller.getInternetStatus.toString()}");
                });
              }
              return Future.value(false);
            },
            child: Container(
              color: white,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: white,
                  body: Container(
                    width: 1.0.sw,
                    height: 1.0.sh,
                    color: white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            'noInternet',
                            fontSize: 18,
                            fontFamily: PRIMARY_FONT_BOLD,
                            textColor: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    try {
      controller.sink.add({result: isOnline});
    } catch (e) {
      print(e);
    }
  }

  void disposeStream() => controller.close();
}
