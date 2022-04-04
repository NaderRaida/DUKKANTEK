import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonApp extends StatefulWidget {
  final double? width;
  final Color? color;
  final String? fontFamily;
  final String? text;
  final Color? textColor;
  final bool? translate;
  final double? fontSize;
  final Function? function;
  final int? radius;
  final double? fontHeight;
  final double? topPadding;
  final double? bottomPadding;
  final double? height;
  final bool? withIcon;
  final String? icon;
  final Color? iconColor;

  ButtonApp({
    this.width,
    this.height,
    this.color = primaryColor,
    this.iconColor = white,
    this.textColor,
    this.text,
    this.translate = true,
    this.withIcon = false,
    this.icon,
    this.fontFamily,
    this.function,
    this.fontSize,
    this.radius = 5,
    this.fontHeight = 1.4,
    this.topPadding = 9,
    this.bottomPadding = 9,
  });

  @override
  _ButtonAppState createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: widget.color,
      primary: widget.color,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          widget.radius!.w,
        ),
      ),
      padding: EdgeInsetsDirectional.only(
        top: widget.topPadding!,
        bottom: widget.bottomPadding!,
      ),
    );
    return ElevatedButton(
      style: raisedButtonStyle,
      child: Container(
        width: widget.width,
        height: widget.height != null ? widget.height!.h : null,
        alignment: AlignmentDirectional.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(widget.withIcon!)
              Row(
                children: [
                  SvgPicture.asset(
                    ASSETS_ICONS + widget.icon!,
                    color: widget.iconColor!,
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                ],
              ),
            CustomText(
              widget.text!,
              translate: widget.translate!,
              textColor: widget.textColor!,
              fontFamily: widget.fontFamily!,
              fontSize: widget.fontSize!.sp,
              fontHeight: widget.fontHeight!,
            ),
          ],
        ),
      ),
      onPressed: widget.function != null ? (){
        widget.function!();
      } : null,
    );
  }
}
