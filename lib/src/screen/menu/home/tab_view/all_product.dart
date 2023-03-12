import 'package:cached_network_image/cached_network_image.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_parser.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/widget/custom_dialogs.dart';
import 'package:kkn_siwalan/src/widget/long_press_detail_product.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';
import 'package:provider/provider.dart';

Widget allProductView({
  required BuildContext context,
  required List<ProductModel> listOfProduct,
}) {
  return MediaQuery.removePadding(
    removeTop: true,
    context: context,
    child: RefreshIndicator(
      color: MyColor.warning400,
      onRefresh: () =>
          context.read<ProductParsers>().handleRefresh(context: context),
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: AdaptSize.pixel8,
            bottom: AdaptSize.screenWidth / 1000 * 180,
          ),
          itemCount: listOfProduct.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                longPressDetailProduct(
                  context: context,
                  productName: listOfProduct[index].productName,
                  sellerName: listOfProduct[index].sellerName,
                  ranting: 4.9,
                  imageProduct: listOfProduct[index].productImage,
                  availablePayment: 'va',
                  productPrice: listOfProduct[index].productPrice,
                  onPressedButton: () {},
                  addWishlistAction: () {
                    CustomDialogs().singleButtonDialog(
                      context: context,
                      image: 'oke',
                      title:
                          'Tambahkan ${listOfProduct[index].productName} ke Wishlist ?',
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
                  productId: listOfProduct[index].productId,
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                  bottom: AdaptSize.pixel6,
                  left: AdaptSize.pixel4,
                  right: AdaptSize.pixel4,
                ),
                height: AdaptSize.screenWidth / 1000 * 380,
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
                      imageUrl: listOfProduct[index].productImage,
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
                          width: AdaptSize.screenWidth / 1000 * 380,
                          margin: EdgeInsets.only(right: AdaptSize.pixel8),
                          borderRadius: 16,
                          imagesShimmer: 'logo_user.png',
                        ),
                      ),
                      errorWidget: (context, url, error) => errorShimmerWidget(
                        // height: AdaptSize.screenWidth / 1000 * 380,
                        width: AdaptSize.screenWidth / 1000 * 380,
                        margin: EdgeInsets.only(right: AdaptSize.pixel8),
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
                            listOfProduct[index].productName,
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
                                  listOfProduct[index].sellerName,
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
                                  listOfProduct[index].productLocation,
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

                          Row(
                            children: [
                              /// product price
                              Expanded(
                                child: Text(
                                  listOfProduct[index].productPrice,
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

                              /// product location rw
                              Text(
                                'RW ${listOfProduct[index].productRW}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: AdaptSize.pixel14,
                                        color: MyColor.neutral600),
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
            //
          }),
    ),
  );
}
