import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChromeSettingsForSpecificScreen {
  static whiteChromeSetting() {
    return SystemUiOverlayStyle.light.copyWith(
        statusBarColor: white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: white);
  }

  static offWhiteChromeSetting() {
    return SystemUiOverlayStyle.light.copyWith(
        statusBarColor: offWhite,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: offWhite);
  }

  static splashChromeSetting() {
    return SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: white,
        systemNavigationBarColor: white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark);
  }

  static primaryChromeSetting() {
    return SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: primaryColor,
      systemNavigationBarColor: white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  static fullPrimaryChromeSetting() {
    return SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: primaryColor,
      systemNavigationBarColor: primaryColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }

  static authSettings() {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: offWhite,
      systemNavigationBarColor: primaryColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }

  static alertDialogChromeSetting() {
    return SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xff222222),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff222222),
    );
  }

  static twoColorsChromeSetting() {
    return SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: primaryColor,
      systemNavigationBarColor: white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }
}
