import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_siwalan/src/dummy/product_data_dummy.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/user_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProductScreen extends StatelessWidget {
  final String id;

  const DetailProductScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productById =
        Provider.of<ProductDummyData>(context, listen: false).filterProductById(
      productID: id,
    );

    final userData =
        Provider.of<UserViewModel>(context, listen: false).usermodel;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            padding: EdgeInsets.only(
              top: AdaptSize.paddingTop + 10,
              left: AdaptSize.pixel8,
              right: AdaptSize.pixel8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// lead image
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: productById!.productImage,
                      imageBuilder: (context, imageProvider) => InkWell(
                        splashColor: MyColor.neutral900,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                left: AdaptSize.pixel8,
                                right: AdaptSize.pixel8,
                              ),
                              child: Image(
                                image: imageProvider,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: AdaptSize.screenWidth / 1000 * 800,
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: AdaptSize.pixel8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => shimmerLoading(
                        child: cardShimmerWidget(
                          height: AdaptSize.screenWidth / 1000 * 800,
                          width: double.infinity,
                          borderRadius: 10,
                          imagesShimmer: 'logo_kkn_siwalan.png',
                        ),
                      ),
                      errorWidget: (context, url, error) => errorShimmerWidget(
                        height: AdaptSize.screenWidth / 1000 * 800,
                        width: double.infinity,
                        borderRadius: 10,
                        imagesShimmer: 'logo_kkn_siwalan.png',
                      ),
                    ),
                    Positioned(
                      left: AdaptSize.pixel8,
                      top: AdaptSize.pixel2,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: MyColor.neutral900,
                          size: AdaptSize.pixel22,
                        ),
                      ),
                    ),
                    Positioned(
                      right: AdaptSize.pixel8,
                      top: AdaptSize.pixel2,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark_outline,
                          size: AdaptSize.pixel22,
                          color: MyColor.neutral900,
                        ),
                      ),
                    ),
                  ],
                ),

                /// grid image
                SizedBox(
                  height: AdaptSize.screenWidth / 1000 * 300,
                  width: double.infinity,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                        bottom: AdaptSize.pixel8,
                      ),
                      itemCount: productById.productGridImage.length,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: productById.productGridImage[index],
                          imageBuilder: (context, imageProvider) => InkWell(
                            splashColor: MyColor.neutral900,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                    left: AdaptSize.pixel8,
                                    right: AdaptSize.pixel8,
                                  ),
                                  child: Image(
                                    image: imageProvider,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: index == 1
                                  ? EdgeInsets.only(
                                      left: AdaptSize.pixel8,
                                      right: AdaptSize.pixel8)
                                  : EdgeInsets.zero,
                              width: AdaptSize.screenWidth / 1000 * 305,
                              decoration: BoxDecoration(
                                color: MyColor.neutral700,
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: imageProvider,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) => shimmerLoading(
                            child: cardShimmerWidget(
                              borderRadius: 16,
                              imagesShimmer: 'logo_kkn_siwalan.png',
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              errorShimmerWidget(
                            borderRadius: 16,
                            imagesShimmer: 'cancel.png',
                          ),
                        );
                      }),
                ),

                /// product name
                Text(
                  productById.productName,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: AdaptSize.pixel24),
                ),

                SizedBox(
                  height: AdaptSize.pixel5,
                ),

                /// product price
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(productById.productPrice),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: AdaptSize.pixel18),
                ),

                SizedBox(
                  height: AdaptSize.pixel5,
                ),

                Divider(
                  color: MyColor.neutral600,
                ),

                SizedBox(
                  height: AdaptSize.pixel5,
                ),

                /// text description
                textTitle(
                  context: context,
                  text: 'Deskripsi',
                ),

                /// product description
                Text(
                  productById.productDescrtiption,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: AdaptSize.pixel14),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(
                  height: AdaptSize.pixel5,
                ),

                Divider(
                  color: MyColor.neutral600,
                ),

                SizedBox(
                  height: AdaptSize.pixel5,
                ),

                /// text manfaat
                textTitle(
                  context: context,
                  text: 'Manfaat',
                ),

                /// list manfaat
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      padding: EdgeInsets.only(
                        top: AdaptSize.pixel5,
                        bottom: AdaptSize.pixel5,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productById.productBenefit.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.brightness_1,
                                  size: AdaptSize.pixel10,
                                ),
                                SizedBox(
                                  width: AdaptSize.pixel8,
                                ),
                                Expanded(
                                  child: Text(
                                    productById.productBenefit[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: AdaptSize.pixel14,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),

                Divider(
                  color: MyColor.neutral600,
                ),

                SizedBox(
                  height: AdaptSize.pixel5,
                ),

                /// text lokasi
                textTitle(
                  context: context,
                  text: 'Lokasi',
                ),

                ///product location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: AdaptSize.pixel22,
                    ),
                    Expanded(
                      child: Text(
                        productById.productLocation,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: AdaptSize.pixel15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: AdaptSize.pixel5,
                ),

                Divider(
                  color: MyColor.neutral600,
                ),

                SizedBox(
                  height: AdaptSize.pixel5,
                ),

                /// text kategori
                textTitle(
                  context: context,
                  text: 'Kategori',
                ),

                /// list kategori
                SizedBox(
                  height: AdaptSize.screenWidth / 1000 * 110,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: productById.productCategory.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: AdaptSize.pixel8),
                          child: Chip(
                            backgroundColor: Color(
                                    (math.Random().nextDouble() * 0xFFFFFF)
                                        .toInt())
                                .withOpacity(1.0),
                            label: Text(
                              productById.productCategory[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: AdaptSize.pixel14,
                                    color: MyColor.neutral900,
                                  ),
                            ),
                          ),
                        );
                      }),
                ),

                SizedBox(
                  height:
                      AdaptSize.screenWidth / 1000 * 125 + AdaptSize.pixel16,
                )
              ],
            ),
          ),

          /// footer
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: AdaptSize.screenWidth / 1000 * 130,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: AdaptSize.screenWidth / 2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyColor.neutral800,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: MyColor.neutral700,
                          blurRadius: 3,
                          blurStyle: BlurStyle.solid,
                        )
                      ],
                    ),
                    child: Text(
                      'SHARE',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.black,
                            fontSize: AdaptSize.pixel15,
                          ),
                    ),
                  ),
                  InkWell(
                    splashColor: MyColor.neutral900,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                    onTap: () {
                      launchUrl(
                          Uri.parse(
                            'https://wa.me/+6285878376402?text=Hai%20Kak%2C%20saya%20${userData!.username}%0AApakah%20produk%20*${productById.productName}*%20tersedia%20%3F%0A%0A*_e-siwalan%20app_*',
                          ),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Container(
                      width: AdaptSize.screenWidth / 2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyColor.neutral700,
                            blurRadius: 3,
                            blurStyle: BlurStyle.solid,
                          )
                        ],
                      ),
                      child: Text(
                        'CHAT PENJUAL',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: MyColor.neutral900,
                              fontSize: AdaptSize.pixel15,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// text title
  Widget textTitle({
    required BuildContext context,
    required String text,
  }) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: AdaptSize.pixel16,
          ),
    );
  }
}
