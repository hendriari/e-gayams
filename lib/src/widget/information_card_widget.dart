import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';

Widget infoCardWidget({
  required BuildContext context,
  required String image,
  required String textInformation,
  bool? withInfo,
  Function()? onTap,
}) {
  return CachedNetworkImage(
    imageUrl: image,
    imageBuilder: (context, imageProvider) => InkWell(
      splashColor: MyColor.neutral900,
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: AdaptSize.screenWidth / 1000 * 750,
            margin: EdgeInsets.only(
              left: AdaptSize.pixel4,
              right: AdaptSize.pixel4,
              bottom: AdaptSize.pixel8,
              top: AdaptSize.pixel8,
            ),
            decoration: BoxDecoration(
              color: MyColor.neutral700,
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imageProvider,
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(2, 3),
                  color: MyColor.neutral600,
                  blurRadius: 3,
                ),
              ],
            ),
          ),
          withInfo == true
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: AdaptSize.screenWidth / 1000 * 80,
                    width: AdaptSize.screenWidth / 1000 * 750,
                    margin: EdgeInsets.only(
                      left: AdaptSize.pixel4,
                      right: AdaptSize.pixel4,
                      bottom: AdaptSize.pixel8,
                      top: AdaptSize.pixel8,
                    ),
                    padding: EdgeInsets.only(left: AdaptSize.pixel8),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      textInformation,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: AdaptSize.pixel16,
                            color: MyColor.neutral900,
                          ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    ),
    placeholder: (context, url) => shimmerLoading(
      child: cardShimmerWidget(
        height: AdaptSize.screenWidth / 1000 * 410,
        width: AdaptSize.screenWidth / 1000 * 750,
        margin: EdgeInsets.only(
          left: AdaptSize.pixel4,
          right: AdaptSize.pixel4,
          bottom: AdaptSize.pixel8,
          top: AdaptSize.pixel8,
        ),
        borderRadius: 16,
        imagesShimmer: 'logo_user.png',
      ),
    ),
    errorWidget: (context, url, error) => errorShimmerWidget(
      height: AdaptSize.screenWidth / 1000 * 410,
      width: AdaptSize.screenWidth / 1000 * 750,
      margin: EdgeInsets.only(
        left: AdaptSize.pixel4,
        right: AdaptSize.pixel4,
        bottom: AdaptSize.pixel8,
        top: AdaptSize.pixel8,
      ),
      borderRadius: 16,
      imagesShimmer: 'close.png',
    ),
  );
}
