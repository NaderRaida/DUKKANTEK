import 'package:app/singleton/dio.dart';
import 'package:app/singleton/dio.dart' as dio;
import 'package:app/utils/AppLocalization.dart';
import 'package:app/views/splash/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'constants/colors.dart';
import 'constants/constants.dart';
import 'controller/GeneralController.dart';
import 'controller/LanguageController.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dio.init();
  dio.getIt<LanguageController>().fetchLocale();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
        init: GeneralController(),
        builder: (controller) {
          return GetMaterialApp(
            title: 'دروسي',
            navigatorKey: navigatorKey,
            locale: getIt<LanguageController>().appLocal,
            theme: ThemeData(
              fontFamily: PRIMARY_FONT_REGULAR,
              primarySwatch: redPrimary,
              primaryColor: primaryColor,
            ),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            home: SplashScreen(),
          );
        });
  }
}
