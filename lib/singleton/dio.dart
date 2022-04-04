import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/controller/LanguageController.dart';
import 'package:app/custom_widgets/CustomAlertDialog.dart';
import 'package:app/models/BodyAPIModel.dart';
import 'package:app/singleton/APIsData.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/utils/language.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final getIt = GetIt.instance;
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> init() async {

  getIt.registerLazySingleton<LanguageController>(
      () => LanguageController());

  getIt.registerLazySingleton<APIsData>(() => APIsData(client: getIt()));


  Dio client = Dio(
    BaseOptions(
      headers: {'Accept-Language': 'ar', 'Accept': 'application/json'},
    ),
  );

  getIt.registerLazySingleton<Dio>(() => client);
  getIt.registerLazySingleton(() => http.Client());

  refreshToken();
}

refreshToken() async {
  print("refreshToken .... ");
  if (AppStorage().getUserToken() != null && AppStorage().getUser() != null) {

    //  firebaseMessaging.subscribeToTopic("all_users");
    getIt<Dio>().options.headers = {
      'Authorization': 'Bearer ${AppStorage().getUserToken()}',
      'Accept-Language':
          getIt<LanguageController>().appLocal.languageCode.toLowerCase(),
      'Accept': 'application/json'
    };

    print("getIt<Dio>().options.headers >> ${getIt<Dio>().options.headers}");
  } else {
    //firebaseMessaging.subscribeToTopic("all_users");
    getIt<Dio>().options.headers = {
      'Accept-Language':
          getIt<LanguageController>().appLocal.languageCode.toLowerCase(),
      'Accept': 'application/json'
    };

    print("user = null >> " + getIt<Dio>().options.headers.toString());
  }
}

showError(error) {
  print("showError = " + error.toString());
  if (error is DioError) {
    print("showError = " + (error as DioError).error.toString());
    BodyAPIModel errorModel;
    if ((error as DioError).response != null) {
      final jsonData = json.decode(error.response.toString());
      print("(error as DioError).response != null >>> " +
          error.response.toString());
      errorModel = BodyAPIModel.fromJson(jsonData);
    } else {
      errorModel = BodyAPIModel(error.type);
    }
    if (error.response!.statusCode == 401) {
      // Get.offAll(LoginScreen());
      Get.put(GeneralController()).setAuth(true);
      showDialog(
          context: Get.context!,
          useSafeArea: false,
          barrierDismissible: false,
          barrierColor: barrierColor,
          builder: (_) => CustomAlertDialog(
                UN_AUTH_DIALOG,
              ));
    } else if (errorModel.status == 550) {
      showDialog(
        context: Get.context!,
        useSafeArea: false,
        barrierColor: barrierColor,
        builder: (_) => CustomAlertDialog(GENERAL_DIALOG,
            onPressed: () => Get.back(), message: errorModel.message),
      );
    } else {
      showDialog(
        context: Get.context!,
        useSafeArea: false,
        barrierColor: barrierColor,
        builder: (_) => CustomAlertDialog(
          GENERAL_DIALOG,
          onPressed: () => Get.back(),
          message:  errorModel.message,
        ),
      );
    }
  } else {
    print("showError >>> else");
    showDialog(
      context: Get.context!,
      useSafeArea: false,
      barrierColor: barrierColor,
      builder: (_) => CustomAlertDialog(
        GENERAL_DIALOG,
        onPressed: () => Get.back(),
        message: getTranslated("tryAgainLater"),
      ),
    );
  }
}

Future<File> getImageCrop({ImageSource source = ImageSource.gallery}) async {
  final imagePicker = ImagePicker();
  XFile? image = await imagePicker.pickImage(source: source,imageQuality: source == ImageSource.camera ? 50 : null);
  File imageFile = File(image!.path);
  var i = await imageFile.readAsBytes();
  print('Select image readAsBytes = ' + i.length.toString());
  return _cropImage(imageFile);
}

Future<File> _cropImage(File imageFile) async {
  File? croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1200,
      maxHeight: 1200,
      compressQuality: 50,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: primaryColor,
          toolbarWidgetColor: white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
      ));
  if (croppedFile != null) {
    imageFile = croppedFile;
    var c = await imageFile.readAsBytes();
    print("Select image after cropp = " + c.length.toString());
  }
  return imageFile;
}

