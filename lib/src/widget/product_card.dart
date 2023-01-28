import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';

Widget productCard({
  required BuildContext context,
  required int itemCount,
  required String image,
  required String productName,
  required String location,
  required int price,
  Function()? onTap,
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
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      splashColor: MyColor.neutral900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              /// image
              CachedNetworkImage(
                imageUrl: image,
                imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                    image: imageProvider,
                    height: AdaptSize.screenWidth / 1000 * 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                placeholder: (context, url) => shimmerLoading(
                  child: cardShimmerWidget(
                    height: AdaptSize.screenWidth / 1000 * 400,
                    width: double.infinity,
                    borderRadius: 16,
                    imagesShimmer: 'logo_kkn_siwalan.png',
                  ),
                ),
                errorWidget: (context, url, error) => errorShimmerWidget(
                  height: AdaptSize.screenWidth / 1000 * 400,
                  width: double.infinity,
                  borderRadius: 16,
                  imagesShimmer: 'error.png',
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
              Random().nextInt(price),
            ),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: AdaptSize.pixel15),
          ),
        ],
      ),
    ),
  );
}
