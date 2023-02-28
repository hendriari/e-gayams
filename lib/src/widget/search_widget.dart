import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget productCardWidget({
  required BuildContext context,
  required Map<String, dynamic> product,
}) {
  return Container(
    height: AdaptSize.screenWidth / 1000 * 925,
    width: double.infinity,
    margin: EdgeInsets.all(AdaptSize.pixel8),
    padding: EdgeInsets.all(AdaptSize.pixel10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: MyColor.neutral900,
      boxShadow: [
        BoxShadow(
          color: MyColor.neutral400,
          blurRadius: 4,
          blurStyle: BlurStyle.solid,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// product name
        Text(
          product['productName'],
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: AdaptSize.pixel16),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(
          height: AdaptSize.pixel8,
        ),

        CachedNetworkImage(
          imageUrl: product['productImage'],
          imageBuilder: (_, imageProvider) => SizedBox(
            height: AdaptSize.screenWidth / 1000 * 500,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                fit: BoxFit.cover,
                image: imageProvider,
              ),
            ),
          ),
          placeholder: (context, url) => shimmerLoading(
            child: cardShimmerWidget(
              height: AdaptSize.screenWidth / 1000 * 500,
              width: double.infinity,
              borderRadius: 16,
              imagesShimmer: 'logo_user.png',
            ),
          ),
          errorWidget: (context, url, error) => errorShimmerWidget(
            borderRadius: 16,
            height: AdaptSize.screenWidth / 1000 * 500,
            width: double.infinity,
            imagesShimmer: 'error.png',
          ),
        ),

        SizedBox(
          height: AdaptSize.pixel14,
        ),

        Text(
          product['sellerName'],
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: AdaptSize.pixel16),
        ),

        SizedBox(
          height: AdaptSize.pixel8,
        ),

        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: AdaptSize.pixel20,
            ),
            SizedBox(
              width: AdaptSize.pixel6,
            ),
            Text(
              product['productLocation'],
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: AdaptSize.pixel14),
            ),
          ],
        ),

        SizedBox(
          height: AdaptSize.pixel8,
        ),

        Text(
          product['productPrice'],
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: AdaptSize.pixel14),
        ),

        const Spacer(),

        /// date published
        Text(
          'update at : ${DateFormat.yMMMd().format(product['datePublished'].toDate())}',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: AdaptSize.pixel10,
                color: MyColor.neutral400,
              ),
          maxLines: 1,
        ),
      ],
    ),
  );
}
