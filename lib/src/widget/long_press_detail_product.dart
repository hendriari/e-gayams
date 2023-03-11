import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';

Future longPressDetailProduct({
  required BuildContext context,
  required String productName,
  required String sellerName,
  required double ranting,
  required String imageProduct,
  required String availablePayment,
  required String productPrice,
  Function()? onPressedButton,
  Function()? addWishlistAction,
}) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: AdaptSize.screenWidth / 1000 * 640,
          width: double.infinity,
          child: Stack(
            children: [
              /// rgb background
              Container(
                height: AdaptSize.screenWidth / 1000 * 640,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                  gradient: MyColor.likeROG,
                ),
              ),

              /// content
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: AdaptSize.screenWidth / 1000 * 635,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    AdaptSize.pixel12,
                    AdaptSize.pixel5,
                    AdaptSize.pixel12,
                    AdaptSize.pixel12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                    color: MyColor.neutral900,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 1.5,
                        color: Colors.white,
                        blurStyle: BlurStyle.solid,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      /// custom divider
                      Container(
                        height: AdaptSize.pixel2,
                        width: AdaptSize.pixel40 + AdaptSize.pixel16,
                        margin: EdgeInsets.only(bottom: AdaptSize.pixel10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: MyColor.likeROG,
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// image
                          CachedNetworkImage(
                            imageUrl: imageProduct,
                            imageBuilder: (context, imageProvider) => Container(
                              height: AdaptSize.pixel40 + AdaptSize.pixel10,
                              width: AdaptSize.pixel40 + AdaptSize.pixel10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: MyColor.neutral600,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: imageProvider,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => shimmerLoading(
                              child: cardShimmerWidget(
                                height: AdaptSize.pixel40 + AdaptSize.pixel10,
                                width: AdaptSize.pixel40 + AdaptSize.pixel10,
                                borderRadius: 12,
                                imagesShimmer: 'logo_user.png',
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                errorShimmerWidget(
                              height: AdaptSize.pixel40 + AdaptSize.pixel10,
                              width: AdaptSize.pixel40 + AdaptSize.pixel10,
                              borderRadius: 12,
                              imagesShimmer: 'error.png',
                            ),
                          ),

                          SizedBox(
                            width: AdaptSize.pixel12,
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// product name
                                Text(
                                  productName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: AdaptSize.pixel16,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(
                                  height: AdaptSize.pixel5,
                                ),

                                /// sellername
                                rowInfo(
                                  text: sellerName,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: AdaptSize.pixel12,
                                      ),
                                  maxlines: 1,
                                  width: AdaptSize.pixel4,
                                  textOverflow: TextOverflow.ellipsis,
                                  icon: Image.asset(
                                    'assets/image/shop.png',
                                    scale: AdaptSize.pixel14,
                                  ),
                                ),

                                SizedBox(
                                  height: AdaptSize.pixel3,
                                ),

                                /// ranting
                                availablePayment == 'va'
                                    ? rowInfo(
                                        text: 'Ranting Total $ranting',
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: AdaptSize.pixel12,
                                            ),
                                      )
                                    : availablePayment == 'cod'
                                        ? rowInfo(
                                            text: 'Mulai Dari $productPrice',
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontSize: AdaptSize.pixel12,
                                                ),
                                            icon: Image.asset(
                                              'assets/icon3d/money.png',
                                              scale: AdaptSize.pixel14,
                                            ),
                                          )
                                        : const SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: MyColor.neutral600,
                        thickness: 1,
                      ),

                      /// info payment product
                      rowInfo(
                        text: availablePayment == 'cod'
                            ? 'Hanya Cash On Delivery (COD)'
                            : availablePayment == 'va'
                                ? 'Mendukung Virtual Account'
                                : '',
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: AdaptSize.pixel15,
                                ),
                        icon: availablePayment == 'cod'
                            ? Image.asset(
                                'assets/image/cod.png',
                                scale: AdaptSize.pixel14,
                              )
                            : availablePayment == 'va'
                                ? Image.asset(
                                    'assets/image/gotoshop.png',
                                    scale: AdaptSize.pixel12,
                                  )
                                : const SizedBox(),
                      ),

                      SizedBox(
                        height: AdaptSize.pixel12,
                      ),

                      /// add to wishlist
                      GestureDetector(
                        onTap: addWishlistAction,
                        child: rowInfo(
                          text: 'Tambah ke Wishlist',
                          textStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: AdaptSize.pixel15,
                                  ),
                          icon: Image.asset(
                            'assets/icon3d/bookmark.png',
                            scale: AdaptSize.pixel15,
                          ),
                        ),
                      ),

                      const Spacer(),

                      /// output button
                      buttonWidget(
                        onPressed: onPressedButton,
                        backgroundColor: MyColor.warning500,
                        foregroundColor: MyColor.neutral900,
                        sizeWidth: double.infinity,
                        sizeHeight: AdaptSize.pixel40,
                        child: Text(
                          availablePayment == 'cod'
                              ? 'Chat Penjual'
                              : availablePayment == 'va'
                                  ? 'Beli Sekarang'
                                  : '',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: MyColor.neutral900,
                              ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

Widget rowInfo({
  TextStyle? textStyle,
  Widget? icon,
  int? maxlines,
  TextOverflow? textOverflow,
  double? width,
  required String text,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      icon ??
          Image.asset(
            'assets/icon3d/star.png',
            scale: AdaptSize.pixel16,
          ),
      SizedBox(
        width: width ?? AdaptSize.pixel3,
      ),
      Text(
        text,
        style: textStyle,
        maxLines: maxlines,
        overflow: textOverflow,
      ),
    ],
  );
}
