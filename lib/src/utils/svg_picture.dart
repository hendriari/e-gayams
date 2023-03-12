import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';

Widget svgAssets({
  required String assetName,
  String? semanticsLabel,
  double? width,
}) {
  return SvgPicture.asset(
    assetName,
    width: width ?? AdaptSize.pixel8,
    semanticsLabel: semanticsLabel,
  );
}
