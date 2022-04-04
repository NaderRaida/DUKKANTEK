import 'dart:convert';

import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomAlertDialog.dart';
import 'package:app/custom_widgets/NoInternetConnection.dart';
import 'package:app/models/BodyAPIModel.dart';
import 'package:app/models/user/UserModel.dart';
import 'package:app/singleton/APIsData.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/singleton/dio.dart';
import 'package:app/utils/language.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralController extends GetxController {
  bool isLoading = false;
  bool unauthenticated = false;
  int lastPage = 1;
  bool getInternetStatus = false;

  void setAuth(bool status) {
    unauthenticated = status;
  }

  void setInternetStatus(bool status) {
    getInternetStatus = status;
  }

  void joinUs(body, Function success, Function failed) {
    setIsLoading(true);
    getIt<APIsData>().joinUs(body).then((_userModel) {
      isLoading = false;
      UserModel userModel = _userModel.data!;
      AppStorage().setUser(userModel);
      AppStorage().setFullName(userModel.name!);
      AppStorage().setUserEmail(userModel.email!);
      AppStorage().setUserMobile(userModel.mobile!);
      AppStorage().setUserToken(userModel.accessToken!);
      success(userModel);
      update();
      refreshToken();
    }).catchError((error) {
      setIsLoading(false);
      failed();
      print("userRegister error = " + error.toString());
      showErrorOrUnAuth(error);
    });
  }

  void userLogin(body,Function success, Function failed) {
    setIsLoading(true);
    getIt<APIsData>().userLogin(body).then((_userModel) {
      isLoading = false;
      if(_userModel!.data != null){
        print("_userModel!.data! >> ${_userModel.data!}");
        UserModel userModel = _userModel.data!;
        AppStorage().setUserType(userModel.type == "0" ? STUDENT : TEACHER);
        AppStorage().setUser(userModel);
        AppStorage().setFullName(userModel.name!);
        AppStorage().setUserEmail(userModel.email!);
        AppStorage().setUserMobile(userModel.mobile!);
        AppStorage().setUserToken(userModel.accessToken!);
        refreshToken();
        success(userModel);
        update();
      }else{
        showErrorOrUnAuth(_userModel.message);
      }
    }).catchError((error) {
      setIsLoading(false);
      failed();
      print("userLogin error = " + error.toString());
      showErrorOrUnAuth(error);
    });
  }

  void setIsLoading(bool status,{bool notify = true}){
    isLoading = status;
    if(notify){
      update();
    }
  }

  void showErrorOrUnAuth(dynamic error) async {
    BodyAPIModel errorModel;
    try {
      if ((error is DioError) && error.message.contains("SocketException")) {
        Get.to(NoInternetConnection());
      } else {
        if ((error is DioError) && error.response != null) {
          final jsonData = json.decode(error.response.toString());
          print(jsonData);
          errorModel = BodyAPIModel.fromJson(jsonData);
          print(errorModel.message.toString());
          if (errorModel.status == 401) {
            unauthenticated = true;
            update();
            showDialog(
                context: Get.context!,
                useSafeArea: false,
                barrierDismissible: false,
                barrierColor: barrierColor,
                builder: (_) => CustomAlertDialog(
                      UN_AUTH_DIALOG,
                    ));
          } else if (error.type == DioErrorType.other &&
              error.message.contains("SocketException")) {
            Get.to(NoInternetConnection());
          } else {
            showError(error);
            update();
          }
        }else{
          print("asdsadsadasdsadsadsadsad");
          showDialog(
            context: Get.context!,
            useSafeArea: false,
            barrierColor: barrierColor,
            builder: (_) => CustomAlertDialog(
              GENERAL_DIALOG,
              onPressed: () {
                Get.back();
              },
              message: getTranslated("tryAgainLater"),
            ),
          );
        }
      }
    } catch (e) {
      print("==>error>"+e.toString());
      showDialog(
        context: Get.context!,
        useSafeArea: false,
        barrierColor: barrierColor,
        builder: (_) => CustomAlertDialog(
          GENERAL_DIALOG,
          onPressed: () {
            Get.back();
          },
          message: getTranslated("tryAgainLater"),
        ),
      );
    }
  }
}
