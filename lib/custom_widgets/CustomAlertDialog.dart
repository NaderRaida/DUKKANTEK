import 'dart:ui';

import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/utils/language.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import 'ButtonApp.dart';

class CustomAlertDialog extends StatelessWidget {
  /* Dialog Types
     GeneralDialog
    */

  final int? type;
  final String? message;
  final List? countriesList;
  final Function? afterDeleteCartItem;
  final Function? afterDecisionAddCartOrCancel;
  final Function? onPressed;
  final Widget? child;
  final Tween<double>? tween;
  final AnimationController? controller;
  final Function? remindMeLaterFunction;
  final Function? updateAction;
  final bool? remindMeLater;

  CustomAlertDialog(
    this.type, {
    this.message,
    this.countriesList,
    this.afterDeleteCartItem,
    this.afterDecisionAddCartOrCancel,
    this.onPressed,
    this.child,
    this.tween,
    this.controller,
    this.remindMeLaterFunction,
    this.updateAction,
    this.remindMeLater = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: ChromeSettingsForSpecificScreen.alertDialogChromeSetting(),
        child: type == ADD_ADDRESS
            ? Dialog(
                insetPadding: EdgeInsets.only(left: 25.w, right: 25.w),
                backgroundColor: offWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0.w)),
                child: IntrinsicHeight(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 30.0.h,
                        bottom: 30.h,
                        left: 21.w,
                        right: 21.w,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            "Add_a_new_address",
                            fontSize: 18,
                            textColor: black2,
                            fontFamily: PRIMARY_FONT_BOLD,
                          ),
                          child!,
                          SizedBox(height: 20.h),
                          Center(
                            child: SizedBox(
                              width: 300.w,
                              height: 52.h,
                              child: ButtonApp(
                                text: "Save",
                                width: 2.0.sw,
                                textColor: white,
                                color: primaryColor,
                                fontFamily: PRIMARY_FONT_BOLD,
                                fontSize: 16,
                                function: onPressed,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : type == DELETE_DIALOG
                ? Dialog(
                    insetPadding: EdgeInsets.symmetric(horizontal: 27.w),
                    backgroundColor: white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0.w)),
                    child: IntrinsicHeight(
                      child: Container(
                          child: Padding(
                        padding: EdgeInsets.only(
                            top: 30.h, bottom: 30.h, left: 21.w, right: 21.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Center(
                                child: CustomText(
                                  message!,
                                  fontSize: 16,
                                  fontFamily: PRIMARY_FONT_REGULAR,
                                  textColor: gray0,
                                  paragraph: true,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 26.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 135.w,
                                  height: 52.0.h,
                                  child: ButtonApp(
                                      text: "ok",
                                      width: 2.0.sw,
                                      textColor: white,
                                      color: primaryColor,
                                      fontFamily: PRIMARY_FONT_BOLD,
                                      fontSize: 16,
                                      function: onPressed),
                                ),
                                SizedBox(
                                  width: 135.w,
                                  height: 52.0.h,
                                  child: ButtonApp(
                                    text: "Cancel",
                                    width: 2.0.sw,
                                    textColor: white,
                                    color: gray0,
                                    fontFamily: PRIMARY_FONT_BOLD,
                                    fontSize: 16,
                                    function: () => Get.back(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                    ),
                  )
                : type == UN_AUTH_DIALOG
                    ? Dialog(
                        insetPadding: EdgeInsets.symmetric(
                          horizontal: 25.w,
                        ),
                        backgroundColor: white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0.w)),
                        child: IntrinsicHeight(
                          child: Container(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: 42.0.h,
                                bottom: 42.h,
                                start: 17.w,
                                end: 17.w,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // CustomText(
                                  //   "un_auth_title",
                                  //   fontSize: 16,
                                  //   fontFamily: PRIMARY_FONT_BOLD,
                                  //   textColor: black,
                                  // ),
                                  // SizedBox(
                                  //   height: 7.h,
                                  // ),
                                  CustomText(
                                    "un_auth_message",
                                    fontSize: 14,
                                    fontFamily: PRIMARY_FONT_REGULAR,
                                    textColor: black,
                                    paragraph: true,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  ButtonApp(
                                    width: 1.0.sw,
                                    color: primaryColor,
                                    fontFamily: PRIMARY_FONT_BOLD,
                                    fontSize: 16,
                                    textColor: white,
                                    text: "login_title",
                                    function: () {
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : type == CITIES
                        ? Dialog(
                            insetPadding:
                                EdgeInsets.only(left: 25.w, right: 25.w),
                            backgroundColor: offWhite,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0.w)),
                            child: IntrinsicHeight(
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 30.0.h,
                                    bottom: 30.h,
                                    left: 21.w,
                                    right: 21.w,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        "Choose_city",
                                        fontSize: 18,
                                        textColor: black2,
                                        fontFamily: PRIMARY_FONT_BOLD,
                                      ),
                                      child!,
                                      SizedBox(height: 20.h),
                                      Center(
                                        child: SizedBox(
                                          width: 300.w,
                                          height: 52.h,
                                          child: ButtonApp(
                                            text: "Save",
                                            width: 2.0.sw,
                                            textColor: white,
                                            color: primaryColor,
                                            fontFamily: PRIMARY_FONT_BOLD,
                                            fontSize: 16,
                                            function: onPressed,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : type == PAYMENT
                            ? Dialog(
                                insetPadding:
                                    EdgeInsets.only(left: 25.w, right: 25.w),
                                backgroundColor: white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30.0.w)),
                                child: IntrinsicHeight(
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 30.0.h,
                                        bottom: 30.h,
                                        left: 21.w,
                                        right: 21.w,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          child!,
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Container(
                                            child: Center(
                                              child: CustomText(
                                                message!,
                                                fontSize: 16,
                                                textColor: black2,
                                                paragraph: true,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 26.h),
                                          Center(
                                            child: SizedBox(
                                              width: 300.w,
                                              height: 52.h,
                                              child: ButtonApp(
                                                text: "Send",
                                                width: 2.0.sw,
                                                textColor: white,
                                                color: primaryColor,
                                                fontFamily: PRIMARY_FONT_BOLD,
                                                fontSize: 16,
                                                function: () {
                                                  Get.back();
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : type == ATTACHMENT
                                ? Dialog(
                                    insetPadding: EdgeInsets.only(
                                        left: 25.w, right: 25.w),
                                    backgroundColor: offWhite,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0.w)),
                                    child: IntrinsicHeight(
                                      child: Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 30.0.h,
                                            bottom: 30.h,
                                            left: 21.w,
                                            right: 21.w,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                "Attach_transfer",
                                                fontSize: 18,
                                                textColor: black2,
                                                fontFamily: PRIMARY_FONT_BOLD,
                                              ),
                                              SizedBox(height: 20.h),
                                              child!,
                                              SizedBox(height: 26.h),
                                              Center(
                                                child: SizedBox(
                                                  width: 300.w,
                                                  height: 52.h,
                                                  child: ButtonApp(
                                                    text: "Save",
                                                    width: 2.0.sw,
                                                    textColor: white,
                                                    color: primaryColor,
                                                    fontFamily:
                                                        PRIMARY_FONT_BOLD,
                                                    fontSize: 16,
                                                    function: onPressed,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Dialog(
                                        insetPadding: EdgeInsets.only(
                                            left: 25.w, right: 25.w),
                                        backgroundColor: white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0.w)),
                                        child: IntrinsicHeight(
                                          child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: 30.0.h,
                                                bottom: 30.h,
                                                left: 21.w,
                                                right: 21.w,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Center(
                                                      child: CustomText(
                                                        message!,
                                                        translate: false,
                                                        fontSize: 16,
                                                        //fontFamily: PRIMARY_FONT,
                                                        textColor: gray0,
                                                        paragraph: true,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 26.h),
                                                  Center(
                                                    child: SizedBox(
                                                      width: 300.w,
                                                      height: 52.h,
                                                      child: ButtonApp(
                                                        text: "ok",
                                                        width: 2.0.sw,
                                                        textColor: white,
                                                        color: primaryColor,
                                                        fontFamily:
                                                            PRIMARY_FONT_BOLD,
                                                        fontSize: 16,
                                                        function: () {
                                                          // Get.back();
                                                          if(onPressed != null){
                                                            onPressed!();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
  }
}
