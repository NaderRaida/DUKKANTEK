import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/singleton/dio.dart';
import 'package:app/utils/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color backColor;
  final Color titleColor;
  final Color backIconColor;
  final bool fromHomeTap;
  final bool translated;
  final bool isBack;
  final bool showCart;
  final Function? backCallBack;
  final PreferredSizeWidget? bottom;

  CustomAppBar({
    this.title,
    this.backColor = white,
    this.titleColor = black,
    this.translated = true,
    this.isBack = true,
    this.showCart = false,
    this.fromHomeTap = false,
    this.backCallBack,
    this.bottom,
    this.backIconColor = black2,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight((bottom != null) ? 115 : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.whiteChromeSetting(),
      child: SafeArea(
        child: AppBar(
            elevation: 0,
            centerTitle: true,
            titleSpacing: 10,
            title:
            Container(
              width: 250.w,
              child: CustomText(
                title!,
                translate: translated,
                textColor: titleColor,
                textAlign: TextAlign.center,
                fontSize: fromHomeTap ? 20 : 15,
                fontFamily: PRIMARY_FONT_BOLD,
                fontHeight: 1,
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: backColor,
            leading: isBack
                ? Container(
                    padding: EdgeInsetsDirectional.only(start: 13.0.w),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        if (isBack) {
                          backCallBack!();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: backIconColor,
                        size: 17.w,
                      ),
                    ),
                  )
                : const SizedBox(),
            actions: [
              if (showCart)
                SizedBox()
            ],
            bottom: bottom != null ? bottom : null),
      ),
    );
  }
}
