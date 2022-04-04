import 'package:app/singleton/AppStorage.dart';
import 'package:app/singleton/Dio.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LanguageController extends GetxController {
  Locale _appLocale = Locale('ar');

  Locale get appLocal => _appLocale;

  fetchLocale() async {
    if (AppStorage().getLanguageCode() == null) {
      AppStorage().setLanguageCode('ar');
      _appLocale = Locale('ar');
      return Null;
    }
    _appLocale = Locale(AppStorage().getLanguageCode()!);
    this._appLocale = _appLocale;
    update();
    return _appLocale;
  }

  void changeLanguage(Locale type, Function onDone) async {
    _appLocale = type;
    if (AppStorage().getUserToken() != null) {
      // await getIt<APIsData>().updateLanguage(type.languageCode).then(
      //   (value) async {
      //     getIt<Dio>().options.headers = {
      //       "Authorization":
      //           "Bearer ${AppStorage().getUserToken()}",
      //       'Accept-Language': type.languageCode.toLowerCase().toString(),
      //       'Accept': 'application/json'
      //     };
      //   },
      // ).catchError((error) {
      //   print("catchError >> _ordersDataList = " + error.toString());
      //   showError(context, error);
      // });
    } else {
      print("no user");

      getIt<Dio>().options.headers = {
        'Accept-Language': type.languageCode.toLowerCase().toString(),
        'Accept': 'application/json'
      };
    }
    if (type.languageCode.toLowerCase() == "ar") {
      _appLocale = Locale("ar");
      Get.updateLocale(Locale("ar"));
      AppStorage().setLanguageCode('ar');
      AppStorage().setCountryCode('SA');
    } else {
      _appLocale = Locale("en");
      Get.updateLocale(Locale("en"));
      AppStorage().setLanguageCode('en');
      AppStorage().setCountryCode('US');
    }
    onDone();
    update();
  }
}
