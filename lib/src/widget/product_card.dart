import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

Widget productCard({
  required BuildContext context,
  required int itemCount,
  required String image,
  required String productName,
  required String location,
}) {
  return Container(
    margin: EdgeInsets.all(AdaptSize.pixel4),
    padding: EdgeInsets.all(AdaptSize.pixel6),
    height: AdaptSize.screenWidth / 1000 * 200,
    width: AdaptSize.screenWidth / 1000 * 500,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: MyColor.neutral900,
      boxShadow: [
        BoxShadow(
          color: MyColor.neutral700,
          offset: const Offset(2, 3),
          blurRadius: 3,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                height: AdaptSize.screenWidth / 1000 * 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: AdaptSize.pixel2,
              top: AdaptSize.pixel2,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_outline,
                  color: MyColor.neutral900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptSize.pixel10,
        ),
        Text(
          productName,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: AdaptSize.pixel15),
        ),
        SizedBox(
          height: AdaptSize.pixel8,
        ),
        Text(
          location,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: AdaptSize.pixel14),
        ),
        const Spacer(),
        Text(
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
              .format(
            Random().nextInt(100000),
          ),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: AdaptSize.pixel15),
        ),
      ],
    ),
  );
}
