import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_siwalan/src/dummy/product_data_dummy.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/user_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/button_widget.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/modal_bottom_sheed.dart';
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
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: Stack(
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
                        errorWidget: (context, url, error) =>
                            errorShimmerWidget(
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          productById.productName,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: AdaptSize.pixel24),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Chip(
                        label: Text(
                          'RW ${productById.productRW}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: AdaptSize.pixel12),
                        ),
                        backgroundColor: MyColor.neutral900,
                        side: BorderSide(color: MyColor.neutral500),
                        //padding: EdgeInsets.zero,
                      ),
                    ],
                  ),

                  /// seller name
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.person_crop_circle_badge_checkmark,
                        size: AdaptSize.pixel20,
                      ),
                      SizedBox(
                        width: AdaptSize.pixel8,
                      ),
                      Text(
                        productById.sellerName,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: AdaptSize.pixel12),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: AdaptSize.pixel8,
                  ),

                  Divider(
                    color: MyColor.neutral600,
                  ),

                  SizedBox(
                    height: AdaptSize.pixel8,
                  ),

                  /// text description
                  textTitle(
                    context: context,
                    text: 'Deskripsi',
                  ),

                  SizedBox(
                    height: AdaptSize.pixel8,
                  ),

                  /// product description
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.doc_text,
                        size: AdaptSize.pixel20,
                      ),
                      SizedBox(
                        width: AdaptSize.pixel8,
                      ),
                      Expanded(
                        child: Text(
                          productById.productDescrtiption,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: AdaptSize.pixel14),
                          textAlign: TextAlign.justify,
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: AdaptSize.pixel8,
                  ),

                  Divider(
                    color: MyColor.neutral600,
                  ),

                  SizedBox(
                    height: AdaptSize.pixel8,
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
                          top: AdaptSize.pixel8,
                          bottom: AdaptSize.pixel8,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productById.productBenefit.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.brightness_1,
                                    size: AdaptSize.pixel10,
                                  ),
                                  SizedBox(
                                    width: AdaptSize.pixel10,
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
                    height: AdaptSize.pixel8,
                  ),

                  /// text lokasi
                  textTitle(
                    context: context,
                    text: 'Lokasi',
                  ),

                  SizedBox(
                    height: AdaptSize.pixel8,
                  ),

                  ///product location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: AdaptSize.pixel20,
                      ),
                      SizedBox(
                        width: AdaptSize.pixel5,
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
                    height: AdaptSize.pixel8,
                  ),

                  Divider(
                    color: MyColor.neutral600,
                  ),

                  SizedBox(
                    height: AdaptSize.pixel8,
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
                        padding: EdgeInsets.only(top: AdaptSize.pixel5),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Harga',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.black,
                                      fontSize: AdaptSize.pixel8,
                                    ),
                          ),

                          ///price
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(productById.productPrice),
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.black,
                                      fontSize: AdaptSize.pixel15,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: MyColor.neutral900,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      onTap: () {
                        modalBottomSheed(
                          context: context,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: AdaptSize.pixel10,
                              right: AdaptSize.pixel10,
                              top: AdaptSize.pixel2,
                              bottom: AdaptSize.pixel20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: AdaptSize.pixel40,
                                  child: Divider(
                                    color: MyColor.neutral700,
                                    thickness: 2,
                                  ),
                                ),

                                Text(
                                  'Chat akan diteruskan menggunakan aplikasi Whatsapp',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontSize: AdaptSize.pixel16),
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(
                                  height: AdaptSize.pixel14,
                                ),

                                /// button direct wa
                                buttonWidget(
                                  onPressed: () {
                                    launchUrl(
                                        Uri.parse(
                                          'https://wa.me/+6285878376402?text=Hai%20Kak%2C%20saya%20${userData!.username}%0AApakah%20produk%20*${productById.productName}*%20tersedia%20%3F%0A%0A*_e-siwalan%20app_*',
                                        ),
                                        mode: LaunchMode.externalApplication);
                                  },
                                  backgroundColor: MyColor.warning600,
                                  foregroundColor: MyColor.neutral900,
                                  sizeWidth: AdaptSize.screenWidth / 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Buka WhatsApp',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(
                                              fontSize: AdaptSize.pixel15,
                                            ),
                                      ),
                                      Icon(
                                        Icons.whatsapp,
                                        size: AdaptSize.pixel20,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
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
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
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
