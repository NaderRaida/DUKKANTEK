import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/AppLogo.dart';
import 'package:app/custom_widgets/ButtonApp.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/CustomTextField.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/views/auth/ForgetPasswordScreen.dart';
import 'package:app/views/auth/JoinUsScreen.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/constants/constants.dart';
import 'package:app/constants/colors.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.splashChromeSetting(),
      child: GetBuilder<GeneralController>(
        init: GeneralController(),
        builder: (controller){
          return Container(
            color: white,
            child: SafeArea(
              child: Scaffold(
                appBar: null,
                backgroundColor: white,
                body: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 75.h,
                                ),
                                Center(
                                  child: AppLogo(
                                    withCircle: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 30.w,
                                    end: 30.w,
                                  ),
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        "emailHint",
                                        emailController,
                                        emailFocus,
                                        passwordFocus,
                                        EMAIL,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      CustomTextField(
                                        "passwordHint",
                                        passwordController,
                                        passwordFocus,
                                        null,
                                        PASSWORD,
                                      ),
                                      SizedBox(
                                        height: 21.h,
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional.centerEnd,
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: (){
                                            Get.to(()=> ForgetPasswordScreen());
                                          },
                                          child: CustomText(
                                            "forgetPassword",
                                            textColor: lightBlue,
                                            fontSize: 10,
                                            fontFamily: PRIMARY_FONT_BOLD,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      ButtonApp(
                                        height: 35,
                                        textColor: white,
                                        fontSize: 15,
                                        fontFamily: PRIMARY_FONT_BOLD,
                                        color: primaryColor,
                                        text: "login",
                                        function: (){
                                          if(_formKey.currentState!.validate()){
                                            Map<String,dynamic> data = {
                                              "email": emailController.text,
                                              "password": passwordController.text
                                            };
                                            controller.userLogin(data,(_user){
                                              print("Login done");
                                              Get.offAll(()=>HomeScreen());
                                            },(){});
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      CustomText(
                                        "or",
                                        textColor: lightBlue,
                                        fontSize: 12,
                                        fontFamily: PRIMARY_FONT_REGULAR,
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      ButtonApp(
                                        height: 35,
                                        textColor: white,
                                        fontSize: 12,
                                        fontFamily: PRIMARY_FONT_REGULAR,
                                        color: blue,
                                        radius: 3,
                                        text: "loginWithFacebook",
                                        withIcon: true,
                                        icon: "facebook_logo.svg",
                                        function: (){

                                        },
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      ButtonApp(
                                        height: 35,
                                        textColor: white,
                                        fontSize: 12,
                                        fontFamily: PRIMARY_FONT_REGULAR,
                                        radius: 3,
                                        color: orange,
                                        text: "loginWithGmail",
                                        withIcon: true,
                                        icon: "google_logo.svg",
                                        function: (){
                                        },
                                      ),
                                      SizedBox(
                                        height: 24.h,
                                      ),
                                      InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: (){
                                            Get.to(()=> JoinUsScreen());
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                "newUser",
                                                textColor: lightBlue,
                                                fontSize: 11,
                                                fontFamily: PRIMARY_FONT_BOLD,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              CustomText(
                                                "joinUs",
                                                textColor: pink,
                                                fontSize: 11,
                                                fontFamily: PRIMARY_FONT_REGULAR,
                                              ),
                                            ],
                                          )
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          if(controller.isLoading)
                            LoadingApp()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
