import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';

Widget onboardingWidget({
  required BuildContext context,
  required String image,
  required String title,
  required String description,
}) {
  return Column(
    children: [
      Image.asset(
        image,
        height: AdaptSize.screenWidth / 1000 * 800,
      ),
      SizedBox(
        height: AdaptSize.pixel28,
      ),
      Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontSize: AdaptSize.pixel16),
      ),
      Text(
        description,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: AdaptSize.pixel14),
      ),
    ],
  );
}
