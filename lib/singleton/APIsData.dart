import 'dart:convert';

import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/models/BodyAPIModel.dart';
import 'package:app/models/MainModel.dart';
import 'package:app/models/user/LoginBody.dart';
import 'package:app/models/user/UserModel.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class APIsData {
  final Dio client;

  static var baseURL = "https://osama.new.tasks.eie.sa/api/";


  APIsData({required this.client});


  Future<LoginBody> joinUs(var body) async {
    var response = await client.post('${baseURL}join_us', data: body);
    var user;
    print("join us response ==>> "+response.toString());
    if (response != null && response.data != null) {
      user = LoginBody.fromJson(json.decode(response.toString()));
    }
    return user;
  }

  Future<BodyAPIModel<UserModel>?> userLogin(Map<String, dynamic> body) async {
    body.forEach((key, value) {
      if (value is int) {
        body[key] = value.toString();
      }
    });
    body['type'] = (AppStorage().getUserType() == STUDENT ? "0" : "1");
    var response = await client.post(baseURL + 'log_in', data: body);
    if (response != null && response.data != null) {
      var main = BodyAPIModel<UserModel>.fromJson(json.decode(response.toString()));
      return main;
    } else {
      return null;
    }
  }

}
