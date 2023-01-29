import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';

Widget listProductCard({
  required BuildContext context,
  required String image,
  required String productName,
  required String productLocation,
  required int productPrice,
  required String productRW,
  Function()? onTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(16),
    splashColor: MyColor.neutral900,
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: AdaptSize.pixel5),
      height: AdaptSize.screenWidth / 1000 * 280,
      width: AdaptSize.screenWidth / 1000 * 700,
      padding: EdgeInsets.all(AdaptSize.pixel5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyColor.neutral900,
        boxShadow: [
          BoxShadow(
              offset: const Offset(2, 3),
              color: MyColor.neutral600,
              blurRadius: 3),
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              width: AdaptSize.screenWidth / 1000 * 380,
              margin: EdgeInsets.only(right: AdaptSize.pixel8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: MyColor.neutral700,
                      blurRadius: 3,
                      blurStyle: BlurStyle.solid),
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                ),
              ),
            ),
            placeholder: (context, url) => shimmerLoading(
              child: cardShimmerWidget(
                // height: AdaptSize.screenWidth / 1000 * 380,
                width: AdaptSize.screenWidth / 1000 * 380,
                borderRadius: 16,
                imagesShimmer: 'logo_kkn_siwalan.png',
              ),
            ),
            errorWidget: (context, url, error) => errorShimmerWidget(
              // height: AdaptSize.screenWidth / 1000 * 380,
              width: AdaptSize.screenWidth / 1000 * 380,
              borderRadius: 16,
              imagesShimmer: 'error.png',
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///  product name
                Text(
                  productName,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: AdaptSize.pixel16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(
                  height: AdaptSize.pixel5,
                ),

                /// product location
                Text(
                  productLocation,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: AdaptSize.pixel12,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const Spacer(),

                Row(
                  children: [
                    /// product price
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                          .format(productPrice),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: AdaptSize.pixel14),
                    ),
                    const Spacer(),

                    /// product location rw
                    Text(
                      'RW $productRW',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: AdaptSize.pixel14),
                    ),

                    SizedBox(
                      width: AdaptSize.pixel5,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
