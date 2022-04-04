import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/LanguageController.dart';
import 'package:app/singleton/dio.dart';
import 'package:app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import 'CustomText.dart';

class CustomTextField extends StatefulWidget {
  final String str;
  final bool translate;
  final TextEditingController? password;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;
  final String? emptyError;
  final String? serverErrorMessage;
  final int type;
  final Function? onDone;
  final Function? onFieldSubmitted;
  final Function? onFocusedChanged;
  final Function? iconEndCallBack;
  final int lines;
  final bool enableValidation;
  final bool enabled;
  final bool serverError;
  final bool withEndIcon;
  final String? icon;
  final Color errorColor;
  final Color borderColor;
  final Color? hintColor;
  final Color? iconColor;
  final bool fromPlace;

  CustomTextField(
    this.str,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.type, {
    this.serverErrorMessage,
    this.password,
    this.withEndIcon = false,
    this.icon,
    this.enableValidation = true,
    this.enabled = true,
    this.previousFocusNode,
    this.translate = true,
    this.lines = 1,
    this.onDone,
    this.onFieldSubmitted,
    this.serverError = false,
    this.fromPlace = false,
    this.errorColor = redErrorColor,
    this.borderColor = primaryColor,
    this.hintColor = gray10,
    this.iconColor,
    this.emptyError,
    this.onFocusedChanged,
    this.iconEndCallBack,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool value = false;
  bool fieldError = false;
  bool focused = false;
  String? fieldErrorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            FocusScope(
              child: Focus(
                onFocusChange: (focus){
                  setState(() {
                    focused = focus;
                  });
                  if(widget.onFocusedChanged != null){
                    widget.onFocusedChanged!(focus);
                  }
                },
                child: TextFormField(
                  enabled: widget.enabled,
                  onChanged: (value) {
                    setState(() {
                    });
                    if (widget.type == CODE && value.isEmpty ||
                        value == "" ||
                        value.length == 0) {
                      FocusScope.of(context)
                          .requestFocus(widget.previousFocusNode);
                      return;
                    } else if (widget.type == CODE && value.length == 4) {
                      widget.onDone!(value);
                    }
                    if (value.length == 1 &&
                        value == "0" &&
                        widget.type == MOBILE) {
                      widget.onDone!(value);
                      //todo //in implementation onDone function to remove zero in the first number
                      // onDone: (value) {
                      //   userMobile.text = value.substring(1);
                      //   userMobile.selection =
                      //       TextSelection.fromPosition(TextPosition(offset: 1));
                      // },
                    } else if (widget.type == SEARCH) {
                      widget.onDone!(value);
                    }
                    /* else if (widget.type == CODE && value.length >= 1) {
                      FocusScope.of(context).requestFocus(widget.nextFocusNode);
                    }*/
                  },
                  validator: (value) {
                    if(widget.enableValidation){
                      if (value!.isEmpty) {
                        setState(() {
                          fieldError = true;
                          fieldErrorText =
                              getTranslated("thisFieldRequired");
                        });
                        return "";
                      } else if (value.length < 6 && widget.type == PASSWORD) {
                        setState(() {
                          fieldError = true;
                          fieldErrorText = getTranslated(
                              'passwordMustContainAtLeast6Characters');
                        });
                        return "";
                      } /*else if (value.length < 7 && widget.type == FULL_NAME) {
                      setState(() {
                        fieldError = true;
                        fieldErrorText = getTranslated(
                            'usernameMustContainAtLeast7Characters');
                      });
                      return "";
                    }*/ else if (widget.type == EMAIL && !GetUtils.isEmail(value)) {
                        setState(() {
                          fieldError = true;
                          fieldErrorText =
                              getTranslated('emailIsNotValid');
                        });
                        return "";
                      } else if (widget.type == MOBILE && value.length < 10) {
                        setState(() {
                          fieldError = true;
                          fieldErrorText =
                              getTranslated('incorrectPhoneNum');
                        });
                        return "";
                      }
                      else if (widget.type == ADDRESS){
                        setState(() {
                          fieldError = false;
                        });
                      }
                      else {
                        setState(() {
                          fieldError = false;
                          fieldErrorText = "";
                        });
                      }
                    }else{
                      setState(() {
                        fieldError = false;
                        fieldErrorText = "";
                      });
                    }
                    return null;
                  },
                  keyboardType: widget.type == EMAIL
                      ? TextInputType.emailAddress
                      : widget.type == MOBILE || widget.type == CODE
                          ? TextInputType.phone
                          : widget.type == PASSWORD ||
                                  widget.type == CONFIRM_PASSWORD
                              ? TextInputType.visiblePassword
                              : widget.type == POINTS
                                  ? TextInputType.number
                                  : widget.type == MESSAGE
                                      ? TextInputType.multiline
                                      : TextInputType.text,
                  cursorColor: primaryColor,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  textAlign: TextAlign.start,
                  obscureText: (_obscureText &&
                          (widget.type == PASSWORD ||
                              widget.type == CONFIRM_PASSWORD))
                      ? true
                      : false,
                  maxLength: widget.type == MOBILE
                      ? 10
                      : widget.type == CODE
                          ? 4
                          : widget.type == PROMO_CODE
                              ? 8
                              : null,
                  maxLines: widget.lines,
                  style: TextStyle(
                    color: lightBlue,
                    fontFamily: PRIMARY_FONT_REGULAR,
                    height: 1.2,
                    fontSize: 15.sp,
                  ),
                  textInputAction:
                      widget.type == CODE || widget.type == PROMO_CODE
                          ? TextInputAction.send
                          : widget.type == MESSAGE
                              ? TextInputAction.newline
                              : (widget.focusNode != widget.nextFocusNode) &&
                                      widget.nextFocusNode != null
                                  ? TextInputAction.next
                                  : TextInputAction.done,
                  decoration: InputDecoration(
                    focusColor: black,
                    hoverColor: black,
                    filled: true,
                    fillColor: white,
                    counterText: "",
                    errorText: null,
                    errorStyle: TextStyle(
                      height: 0,
                      color: Colors.transparent,
                      fontSize: 9.sp,
                    ),
                    contentPadding: EdgeInsetsDirectional.only(
                      top: widget.type == MESSAGE ? 30.h : 0.0,
                      start: 0.w,
                      end: widget.type == PASSWORD || widget.type == CONFIRM_PASSWORD ? 25.w : 5.w,
                    ),
                    labelText: widget.translate
                        ? getTranslated(widget.str)
                        : widget.str,
                    labelStyle: TextStyle(
                      color: focused || widget.controller.text.isNotEmpty ? primaryColor : widget.hintColor,
                      fontFamily: PRIMARY_FONT_BOLD,
                      height: 1.2,
                      fontSize: 11.sp,
                    ),
                    hintText: focused ? "" : widget.translate
                        ? getTranslated(widget.str)
                        : widget.str,
                    hintStyle: TextStyle(
                      color: widget.hintColor,
                      fontFamily: PRIMARY_FONT_BOLD,
                      height: 1.2,
                      fontSize: 11.sp,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: textFieldUnselectedBorder,
                        width: 1.w,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: textFieldUnselectedBorder,
                        width: 1.w,
                      ),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: textFieldUnselectedBorder,
                        width: 1.w,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.borderColor,
                        width: 1.w,
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.errorColor,
                        width: 1.w,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.errorColor,
                        width: 1.w,
                      ),
                    ),
                  ),
                  onEditingComplete: () {
                    print("onEditingComplete");
                    if(widget.focusNode != widget.nextFocusNode) {
                      FocusScope.of(context).requestFocus(widget.nextFocusNode);
                      if(widget.nextFocusNode == null){
                        if(widget.onFocusedChanged != null){
                          widget.onFocusedChanged!(false);
                        }
                      }
                    }else{
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if(widget.onFocusedChanged != null){
                        widget.onFocusedChanged!(false);
                      }
                    }
                  },
                  onFieldSubmitted: (value) {
                    if (widget.nextFocusNode == null) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    }
                    if (widget.type == CODE || widget.type == PROMO_CODE) {
                      widget.onFieldSubmitted!(value);
                    }
                  },
                ),
              ),
            ),
            if (widget.type == PASSWORD || widget.type == CONFIRM_PASSWORD)
              PositionedDirectional(
                end: 0,
                child: suffix(),
              ),
            if (widget.type == EMAIL)
              PositionedDirectional(
                end: 0,
                child: emailSuffix(),
              ),
            if (widget.withEndIcon)
              PositionedDirectional(
                end: 0,
                child: endIcon(),
              ),
          ],
        ),
        if (fieldError)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                CustomText(
                  fieldErrorText!,
                  fontFamily: PRIMARY_FONT_REGULAR,
                  fontSize: 10.sp,
                  textColor: widget.errorColor,
                  translate: false,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget suffix() {
    return Transform.translate(
      offset: Offset(getIt<LanguageController>().appLocal.languageCode.toLowerCase() == AR ? -17.w : 17.w, 0.0),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: _obscureText
            ? Icon(
                Icons.visibility_off,
                color: gray0,
                size: 20.w,
              )
            : Icon(
                Icons.visibility,
                color: gray0,
                size: 20.w,
              ),
      ),
    );
  }

  Widget emailSuffix() {
    return Transform.translate(
      offset: Offset(getIt<LanguageController>().appLocal.languageCode.toLowerCase() == AR ? -17.w
          : 17.w, 0.0),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
        },
        icon: SvgPicture.asset(
          ASSETS_ICONS + "tick_ic.svg",
          color: widget.controller.text.isEmpty
              || !GetUtils.isEmail(widget.controller.text) ? gray
              : primaryColor,
          width: 18.w,
          height: 18.w,
        ),
      ),
    );
  }
  Widget endIcon() {
    return Transform.translate(
      offset: Offset(getIt<LanguageController>().appLocal.languageCode.toLowerCase() == AR ? widget.fromPlace ? 0 : -17.w
          : widget.fromPlace ? 0 : 17.w, 0.0),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          if(widget.iconEndCallBack != null){
            widget.iconEndCallBack!();
          }
        },
        icon: SvgPicture.asset(
          ASSETS_ICONS + widget.icon!,
          color: widget.fromPlace ? primaryColor : widget.iconColor != null ? widget.iconColor : gray11,
          width: widget.fromPlace ?12.w:14.w,
          height: widget.fromPlace ?7.h:17.w,
        ),
      ),
    );
  }
}
