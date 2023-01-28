import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

Widget cardShimmerWidget({
  double? height,
  double? width,
  EdgeInsetsGeometry? margin,
  required double borderRadius,
  required String imagesShimmer,
}) {
  return Container(
    height: height,
    width: width,
    margin: margin,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: MyColor.neutral600.withOpacity(.5),
          blurStyle: BlurStyle.solid,
          blurRadius: 3,
        ),
      ],
      image: DecorationImage(
        fit: BoxFit.contain,
        image: AssetImage('assets/image/$imagesShimmer'),
      ),
    ),
  );
}

Widget errorShimmerWidget({
  double? height,
  double? width,
  EdgeInsetsGeometry? margin,
  required double borderRadius,
  required String imagesShimmer,
}) {
  return Container(
    height: height,
    width: width,
    margin: margin,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      image: DecorationImage(
        fit: BoxFit.contain,
        image: AssetImage('assets/image/$imagesShimmer'),
      ),
    ),
  );
}
