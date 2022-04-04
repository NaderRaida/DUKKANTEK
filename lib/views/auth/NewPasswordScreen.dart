import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/ButtonApp.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/CustomTextField.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/views/auth/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.splashChromeSetting(),
      child: Container(
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
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 30.w,
                          end: 30.w,
                          top: 105.h,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomText(
                                "forgetPassword",
                                textColor: lightBlue,
                                fontSize: 20,
                                fontFamily: PRIMARY_FONT_BOLD,
                              ),
                              SizedBox(
                                height: 23.h,
                              ),
                              CustomText(
                                "forgetPasswordHint",
                                textColor: lightBlue,
                                fontSize: 11,
                                fontFamily: PRIMARY_FONT_REGULAR,
                                paragraph: true,
                                lines: 4,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 42.h,
                              ),
                              CustomTextField(
                                "newPasswordHint",
                                passwordController,
                                passwordFocus,
                                confirmPasswordFocus,
                                PASSWORD,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustomTextField(
                                "confirmPasswordHint",
                                confirmPasswordController,
                                confirmPasswordFocus,
                                null,
                                PASSWORD,
                              ),
                              SizedBox(
                                height: 39.h,
                              ),
                              ButtonApp(
                                height: 35,
                                textColor: white,
                                fontSize: 15,
                                fontFamily: PRIMARY_FONT_BOLD,
                                color: primaryColor,
                                text: "confirm",
                                function: (){
                                  if(_formKey.currentState!.validate()){
                                    Get.offAll(()=>LoginScreen());
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        top: 10.h,
                        start: 5.w,
                        child: IconButton(
                          onPressed: (){
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: lightBlue,
                            size: 19.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
