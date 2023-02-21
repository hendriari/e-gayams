import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_parser.dart';
import 'package:provider/provider.dart';


Widget categoryProductWidget({
  required BuildContext context,
  required List gridContent,
}) {
  final categoryProvider = Provider.of<ProductParsers>(context, listen: false);
  return SizedBox(
    height: AdaptSize.screenWidth / 1000 * 690,
    width: double.infinity,
    child: MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: AdaptSize.screenWidth / 1000 * 330,
          ),
          itemCount: gridContent.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                NavigasiViewModel().navigasiToPorudctByCategory(
                  context: context,
                  headerName: gridContent[index][1],
                  listOfProductCategory:
                      gridContent[index][1] == 'Makanan Ringan'
                          ? categoryProvider.listMakananRingan
                          : gridContent[index][1] == 'Makanan'
                              ? categoryProvider.listMakanan
                              : gridContent[index][1] == 'Minuman'
                                  ? categoryProvider.listMinuman
                                  : gridContent[index][1] == 'Kesehatan'
                                      ? categoryProvider.listKesehatan
                                      : gridContent[index][1] == 'Kecantikan'
                                          ? categoryProvider.listKecantikan
                                          : gridContent[index][1] == 'Fashion'
                                              ? categoryProvider.listFashion
                                              : gridContent[index][1] ==
                                                      'Kerajinan Tangan'
                                                  ? categoryProvider
                                                      .listKerajinanTangan
                                                  : gridContent[index][1] ==
                                                          'Produk Lainnya'
                                                      ? categoryProvider
                                                          .listKategoriLainnya
                                                      : categoryProvider
                                                          .listKategoriLainnya,
                );
              },
              splashColor: MyColor.neutral900,
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  Container(
                    height: AdaptSize.screenWidth / 1000 * 200,
                    margin: EdgeInsets.all(AdaptSize.pixel8),
                    decoration: BoxDecoration(
                      color: MyColor.neutral800,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: MyColor.neutral500,
                          blurStyle: BlurStyle.solid,
                          blurRadius: 3,
                        ),
                      ],
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(gridContent[index][0]),
                      ),
                    ),
                  ),
                  Text(
                    gridContent[index][1],
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: AdaptSize.pixel12),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }),
    ),
  );
}
