import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_parser.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/custom_dialogs.dart';
import 'package:kkn_siwalan/src/widget/long_press_detail_product.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';
import 'package:provider/provider.dart';

Widget gridProduct({
  required BuildContext context,
  required List<ProductModel> listKelurahan,
  ScrollPhysics? scrollPhysics,
  bool? listPaddingBottom,
}) {
  return listKelurahan.isNotEmpty
      ? RefreshIndicator(
          color: MyColor.warning400,
          onRefresh: () =>
              context.read<ProductParsers>().handleRefresh(context: context),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: listKelurahan.length,
              physics: scrollPhysics ?? const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: AdaptSize.pixel8,
                bottom: listPaddingBottom == true
                    ? AdaptSize.screenWidth / 1000 * 180
                    : AdaptSize.pixel14,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: AdaptSize.screenWidth / 1000 * 850,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: (){
                    longPressDetailProduct(
                      context: context,
                      productName: listKelurahan[index].productName,
                      sellerName: listKelurahan[index].sellerName,
                      ranting: 4.9,
                      imageProduct: listKelurahan[index].productImage,
                      availablePayment: 'cod',
                      productPrice:  listKelurahan[index].productPrice,
                      onPressedButton: () {},
                      addWishlistAction: () {
                        CustomDialogs().singleButtonDialog(
                          context: context,
                          image: 'oke',
                          title:
                          'Tambahkan ${listKelurahan[index].productName} ke Wishlist ?',
                          textButton1: 'Kembali',
                          textButton2: 'Simpan',
                          onPress1: () {
                            Navigator.pop(context);
                          },
                          onPress2: () {},
                          bgButton1: MyColor.danger400,
                          bgButton2: MyColor.warning600,
                        );
                      },
                    );
                  },
                  onTap: () {
                    NavigasiViewModel().navigasiDetailProduct(
                      context: context,
                      productId: listKelurahan[index].productId,
                    );
                  },
                  child: Container(
                    height: AdaptSize.screenWidth / 1000 * 100,
                    margin: EdgeInsets.all(AdaptSize.pixel6),
                    padding: EdgeInsets.all(AdaptSize.pixel3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MyColor.neutral800,
                      boxShadow: [
                        BoxShadow(
                          color: MyColor.neutral200,
                          blurStyle: BlurStyle.solid,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: AdaptSize.screenWidth / 1000 * 400,
                          child: CachedNetworkImage(
                            imageUrl: listKelurahan[index].productImage,
                            imageBuilder: (context, imageProvider) => ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            placeholder: (context, url) => shimmerLoading(
                              child: cardShimmerWidget(
                                borderRadius: 12,
                                imagesShimmer: 'logo_user.png',
                                width: double.infinity,
                                height: AdaptSize.screenWidth / 1000 * 300,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                cardShimmerWidget(
                              borderRadius: 16,
                              imagesShimmer: 'error.png',
                              width: double.infinity,
                              height: AdaptSize.screenWidth / 1000 * 300,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AdaptSize.pixel8,
                        ),
                        Text(
                          listKelurahan[index].productName,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: AdaptSize.pixel15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(
                          height: AdaptSize.pixel8,
                        ),

                        /// seller Name
                        Row(
                          children: [
                            Image.asset(
                              'assets/image/shop.png',
                              height: AdaptSize.pixel22,
                              width: AdaptSize.pixel22,
                            ),
                            Expanded(
                              child: Text(
                                listKelurahan[index].sellerName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: AdaptSize.pixel12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        /// store location
                        Row(
                          children: [
                            Image.asset(
                              'assets/image/location.png',
                              height: AdaptSize.pixel22,
                              width: AdaptSize.pixel22,
                            ),
                            Expanded(
                              child: Text(
                                listKelurahan[index].productLocation,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: AdaptSize.pixel12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        /// price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                listKelurahan[index].productPrice,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: AdaptSize.pixel14,
                                        color: MyColor.warning400),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Image.asset(
                              'assets/image/gotoshop.png',
                              height: AdaptSize.pixel28,
                              width: AdaptSize.pixel28,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        )
      : Center(
          child: Text(
            'Belum Ada Product',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: AdaptSize.pixel14),
          ),
        );
}
