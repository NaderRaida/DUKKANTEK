
import 'package:app/models/user/UserModel.dart';
import 'package:dio/dio.dart';

class BodyAPIModel<T> {
  bool? success;
  String? message;
  T? data;
  int? status;

  BodyAPIModel(DioErrorType errorType) {
    if (errorType == DioErrorType.other) {
      print("DioErrorType.other");
      success = false;
      message = "Please try again later";
      status = 0;
    } else if (errorType == DioErrorType.connectTimeout) {
      print("DioErrorType.connectTimeout");
      success = false;
      message = "Connect timeout";
      status = 0;
    } else if (errorType == DioErrorType.receiveTimeout) {
      print("DioErrorType.receiveTimeout");
      success = false;
      message = "Receive timeout";
      status = 0;
    } else if (errorType == DioErrorType.sendTimeout) {
      print("DioErrorType.sendTimeout");
      success = false;
      message = "Send timeout";
      status = 0;
    } else {
      print("DioErrorType = else");
      success = false;
      message = "Error";
      status = 0;
    }
  }

  BodyAPIModel.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        data = json['data'] == null ? null : CheckInput.fromJson(json['data']),
        message = json['message'],
        status = json['status'];

  @override
  String toString() {
    return "STR OUTPUT {success: ${success} message ${message}";
  }
}

//todo very important class //////////////////////////////////////////////
class CheckInput {
  static T? fromJson<T, k>(Map<String, dynamic> json) {
    if (json is Iterable) {
      print("(json is Iterable) = ");
      return _fromJsonList(json as List) as T?;
    } else if (T == UserModel) {
      return UserModel.fromJson(json) as T?;
    }else{
      throw Exception("Unknown class");
    }
  }

  static _fromJsonList(List jsonList) {
    if (jsonList == null) {
      return null;
    }
    // List<CategoryModel> output = [];
    // for (Map<String, dynamic> json in jsonList) {
    //   output.add(CategoryModel.fromJson(json));
    // }
    // return output;
  }
}
