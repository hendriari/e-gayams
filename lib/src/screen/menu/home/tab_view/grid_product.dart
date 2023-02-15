import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';
import 'package:provider/provider.dart';

Widget gridProduct() {
  return Consumer<ProductViewModel>(builder: (context, value, child) {
    return GridView.builder(
        itemCount: value.allListProduct.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              NavigasiViewModel().navigasiDetailProduct(
                context: context,
                product: value.allListProduct[index],
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
                    height: AdaptSize.screenWidth / 1000 * 320,
                    child: CachedNetworkImage(
                      imageUrl: value.allListProduct[index]['productImage'],
                      imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )),
                      placeholder: (context, url) => shimmerLoading(
                        child: cardShimmerWidget(
                          borderRadius: 12,
                          imagesShimmer: 'logo_kkn.png',
                          width: double.infinity,
                          height: AdaptSize.screenWidth / 1000 * 300,
                        ),
                      ),
                      errorWidget: (context, url, error) => cardShimmerWidget(
                        borderRadius: 16,
                        imagesShimmer: 'error.png',
                        width: double.infinity,
                        height: AdaptSize.screenWidth / 1000 * 300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AdaptSize.pixel6,
                  ),
                  Text(
                    value.allListProduct[index]['productName'],
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: AdaptSize.pixel14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        value.allListProduct[index]['productPrice'],
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: AdaptSize.pixel12),
                      ),
                      Card(
                        color: MyColor.neutral700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: AdaptSize.pixel3, right: AdaptSize.pixel3),
                          child: Icon(
                            Icons.arrow_forward,
                            size: AdaptSize.pixel20,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  });
}
