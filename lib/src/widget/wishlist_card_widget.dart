import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';

Widget whistListCard({
  required BuildContext context,
  required String productImage,
  required String productRw,
  required String sellerName,
  required String productName,
  required String productLocation,
  Function()? cardOnTap,
  Function()? bookmarkOntap,
}) {
  return InkWell(
    onTap: cardOnTap,
    child: Container(
      height: AdaptSize.screenWidth / 1000 * 340,
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: AdaptSize.screenHeight * .008,
        right: AdaptSize.pixel8,
        left: AdaptSize.pixel8,
      ),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: MyColor.neutral900,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 3),
            color: MyColor.neutral600,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          /// space image
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: productImage,
                imageBuilder: (context, imageProvider) => Container(
                  width: AdaptSize.screenWidth * .36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageProvider,
                    ),
                  ),
                ),
                placeholder: (context, url) => shimmerLoading(
                  child: cardShimmerWidget(
                    width: AdaptSize.screenWidth * .36,
                    height: AdaptSize.screenWidth / 1000 * 340,
                    margin: const EdgeInsets.all(6),
                    borderRadius: 16,
                    imagesShimmer: 'logo_kkn.png',
                  ),
                ),
                errorWidget: (context, url, error) => cardShimmerWidget(
                  width: AdaptSize.screenWidth * .36,
                  height: AdaptSize.screenWidth / 1000 * 340,
                  margin: const EdgeInsets.all(6),
                  borderRadius: 16,
                  imagesShimmer: 'cancel.png',
                ),
              ),
              Positioned(
                left: 10,
                top: 8,
                child: Stack(
                  children: [
                    /// ranting
                    Container(
                      height: AdaptSize.screenWidth / 1000 * 70,
                      width: AdaptSize.screenWidth / 1000 * 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: AdaptSize.screenHeight * .005,
                          right: AdaptSize.screenHeight * .005),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: MyColor.neutral600,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'RW',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: MyColor.neutral900,
                                    fontSize: AdaptSize.pixel14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            productRw,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: MyColor.neutral900,
                                    fontSize: AdaptSize.pixel14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// jarak samping
          SizedBox(
            width: AdaptSize.screenWidth * .008,
          ),

          /// keterangan
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        sellerName,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: AdaptSize.pixel14,
                              color: MyColor.neutral300,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: bookmarkOntap,
                      child: Icon(
                        Icons.delete,
                        size: AdaptSize.pixel22,
                        color: MyColor.warning400,
                      ),
                    )
                  ],
                ),

                Text(
                  productName,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: AdaptSize.pixel16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                /// jarak bawah
                SizedBox(
                  height: AdaptSize.screenHeight * .008,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: AdaptSize.pixel22,
                    ),
                    SizedBox(
                      width: AdaptSize.pixel5,
                    ),

                    /// lokasi
                    Expanded(
                      child: Text(
                        productLocation,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: AdaptSize.pixel14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                /// jarak bawah
                SizedBox(
                  height: AdaptSize.screenHeight * .008,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
