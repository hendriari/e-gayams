import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

AppBar defaultAppBar({
  required BuildContext context,
  required String title,
  bool? centerTitle,
  Widget? leading,
}) {
  return AppBar(
    title: Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontSize: AdaptSize.pixel16),
    ),
    centerTitle: centerTitle ?? true,
    backgroundColor: MyColor.neutral900,
    elevation: 0,
    leading: leading,
  );
}
