import 'package:app/models/user/UserModel.dart';

class LoginBody {
  bool? success;
  UserModel? data;
  String? message;
  int? status;

  LoginBody({this.success, this.data, this.message, this.status});

  LoginBody.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}