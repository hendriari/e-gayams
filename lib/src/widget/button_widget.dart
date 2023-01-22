import 'package:flutter/material.dart';

Widget buttonWidget({
  Function()? onPressed,
  double? sizeHeight,
  double? sizeWidth,
  double? elevation,
  BorderSide? side,
  EdgeInsetsGeometry? margin,
  Color? backgroundColor,
  Color? foregroundColor,
  Widget? child,
}) {
  return Container(
    height: sizeHeight,
    width: sizeWidth,
    margin: margin,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        side: side,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: child,
    ),
  );
}
