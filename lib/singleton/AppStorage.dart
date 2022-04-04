import 'dart:convert';
import 'package:app/models/user/UserModel.dart';
import 'package:get_storage/get_storage.dart';

class AppStorage {
  final storage = GetStorage();

  static const OPEN_FIRST_INTRO = 'open_first_intro';
  static const TOKEN = 'token';
  static const IMAGE = 'image';
  static const MOBILE = 'mobile';
  static const EMAIL = 'email';
  static const FULL_NAME = 'fullName';
  static const USER = 'user';
  static const IS_ACTIVATE = 'isActivate';
  static const LANGUAGE_CODE = "language_code";
  static const COUNTRY_CODE = "country_code";
  static const USER_TYPE = "user_type";
  static const SOCIAL_MEDIA_LOGIN = "social_login";

  clear() {
    storage.remove("token");
    storage.remove("image");
    storage.remove("mobile");
    storage.remove("email");
    storage.remove("fullName");
    storage.remove("user");
  }

  Future<void> setLoggedWithSocialMedia(bool status) async {
    return await storage.write(SOCIAL_MEDIA_LOGIN, status);
  }

  bool? getLoggedWithSocialMedia() {
    if (storage.read(SOCIAL_MEDIA_LOGIN) == null) {
      return false;
    }else{
      return storage.read(SOCIAL_MEDIA_LOGIN);
    }
  }
  Future<void> setUserType(int type) async {
    return await storage.write(USER_TYPE, type);
  }

  int? getUserType() {
    if (storage.read(USER_TYPE) == null) {
      return null;
    }else{
      return storage.read(USER_TYPE);
    }
  }
  Future<void> setUser(UserModel userModel) async {
    String user = jsonEncode(userModel);
    return await storage.write(USER, user);
  }

  UserModel? getUser() {
    if (storage.read(USER) == null) {
      return null;
    }
    var map = jsonDecode(storage.read(USER));
    return UserModel.fromJson(map);
  }

  Future<void> setActivate(int isActivate) async {
    
    return await storage.write(IS_ACTIVATE, isActivate);
  }

  int? getActivate() {
    
    return storage.read(IS_ACTIVATE);
  }

  Future<void> setOpenIntro(bool open) async {
    
    return await storage.write(OPEN_FIRST_INTRO, open);
  }

  bool? getOpenIntro() {
    
    return storage.read(OPEN_FIRST_INTRO) ?? false;
  }

  Future<void> setUserToken(String token) async {
    
    return await storage.write(TOKEN, token);
  }

  String? getUserToken() {
    
    return storage.read(TOKEN);
  }

  String? getUserImage() {
    
    return storage.read(IMAGE);
  }

  Future<void> setUserImage(String image) async {
    
    return await storage.write(IMAGE, image);
  }

  Future<void> setFullName(String fullName) async {
    
    return await storage.write(FULL_NAME, fullName);
  }

  String? getUserFullName() {
    
    return storage.read(FULL_NAME);
  }

  Future<void> setUserMobile(String mobile) async {
    
    return await storage.write(MOBILE, mobile);
  }

  String? getUserMobile() {
    
    return storage.read(MOBILE);
  }

  Future<void> setUserEmail(String email) async {
    
    return await storage.write(EMAIL, email);
  }

  String? getUserEmail() {
    
    return storage.read(EMAIL);
  }

  Future<void> setLanguageCode(String code) async {
    
    return await storage.write(LANGUAGE_CODE, code);
  }

  String? getLanguageCode() {
    return storage.read(LANGUAGE_CODE) ?? 'ar';
  }

  Future<void> setCountryCode(String code) async {
    return await storage.write(COUNTRY_CODE, code);
  }

  String? getCountryCode() {
    return storage.read(COUNTRY_CODE);
  }
}
