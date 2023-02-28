import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';

Widget onboardingWidget({
  required BuildContext context,
  required String image,
  required String title,
  required String description,
  required Widget indicator,
}) {
  return Column(
    children: [
      Image.asset(
        image,
        height: AdaptSize.screenWidth / 1000 * 700,
      ),
      SizedBox(
        height: AdaptSize.pixel16,
      ),
      indicator,
      SizedBox(
        height: AdaptSize.pixel16,
      ),
      Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: AdaptSize.pixel16),
      ),
      Text(
        description,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontSize: AdaptSize.pixel14),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
