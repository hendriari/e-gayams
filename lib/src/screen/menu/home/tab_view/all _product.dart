import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/list_product_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Widget allProductView({
  required BuildContext context,
}) {
  return Consumer<ProductViewModel>(builder: (context, value, child) {
    return value.allListProduct.isNotEmpty
        ? MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: AdaptSize.pixel8),
                itemCount: value.allListProduct.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return listProductCard(
                    context: context,
                    onTap: () {
                      NavigasiViewModel().navigasiDetailProduct(
                        context: context,
                        product: value.allListProduct[index],
                      );
                    },
                    product: value.allListProduct[index],
                  );
                  //
                }),
          )
        : Center(
            child: Text(
              'Belum Ada Produk',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: AdaptSize.pixel16),
            ),
          );
  });
}
