import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImage extends StatelessWidget {
  @required
  final String? image;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit? fit;
  final FilterQuality? quality;

  CustomImage({
    this.image,
    this.imageWidth,
    this.imageHeight,
    this.fit = BoxFit.cover,
    this.quality = FilterQuality.low,
  });

  @override
  Widget build(BuildContext context) {
    return image!.split(".").last.toLowerCase() == SVG
        ? image!.split(":").first == "https" ||
        image!.split(":").first == "http" ?
    SvgPicture.network(
      image!,
      fit: fit!,
      width: imageWidth,
      height: imageHeight,
    ) :
    SvgPicture.asset(
      image!,
      fit: fit!,
      width: imageWidth,
      height: imageHeight,
    ) : image!.contains("assets") ?
        Image.asset(
          image!,
          fit: fit!,
          width: imageWidth,
          height: imageHeight,
        )
        : CachedNetworkImage(
            imageUrl: image!,
            width: imageWidth,
            height: imageHeight,
            fit: fit,
            fadeOutDuration: const Duration(seconds: 0),
            filterQuality: quality!,
            placeholder: (context, url) => Container(
              height: 10.h,
              width: 10.w,
              child: Image.asset(
                ASSETS_IMAGES + "loading.gif",
                height: 10.h,
                width: 10.w,
              ),
            ),
          );
  }
}
