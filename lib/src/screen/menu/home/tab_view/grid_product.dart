import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';
import 'package:provider/provider.dart';

Widget gridProduct({
  required List<Map<String, dynamic>> listKelurahan,
}) {
  return Consumer<ProductViewModel>(builder: (context, value, child) {
    return listKelurahan.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            itemCount: listKelurahan.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: AdaptSize.pixel8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: AdaptSize.screenWidth / 1000 * 800,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  NavigasiViewModel().navigasiDetailProduct(
                    context: context,
                    product: listKelurahan[index],
                  );
                },
                borderRadius: BorderRadius.circular(12),
                splashColor: MyColor.neutral900,
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
                          imageUrl: listKelurahan[index]['productImage'],
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
                        listKelurahan[index]['productName'],
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
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
                              listKelurahan[index]['sellerName'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
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
                              listKelurahan[index]['productLocation'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
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
                              listKelurahan[index]['productPrice'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
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
            })
        : Center(
            child: Text(
              'Belum Ada Product',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: AdaptSize.pixel14),
            ),
          );
  });
}
