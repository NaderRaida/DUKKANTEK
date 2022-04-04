import 'package:app/utils/AppLocalization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String getTranslated(String key) {
  return AppLocalization.of(Get.context!)!.translate(key).toString();
}