import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/dummy/product_data_dummy.dart';
import 'package:kkn_siwalan/src/screen/menu/account/profile_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/list_product_card.dart';
import 'package:kkn_siwalan/src/widget/read_only_form.dart';
import 'package:provider/provider.dart';

class UmkmScreen extends StatefulWidget {
  const UmkmScreen({Key? key}) : super(key: key);

  @override
  State<UmkmScreen> createState() => _UmkmScreenState();
}

class _UmkmScreenState extends State<UmkmScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDummyData>().addDataDummy(19);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: AdaptSize.pixel8,
          right: AdaptSize.pixel8,
          top: AdaptSize.paddingTop + 5,
          bottom: AdaptSize.pixel10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cari produk di Kelurahan Siwalan?',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: AdaptSize.pixel18),
            ),

            SizedBox(
              height: AdaptSize.pixel16,
            ),

            /// form field
            readOnlyForm(
              context: context,
              hint: 'Cari Produk',
              readOnly: true,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              prefixIcon: Icon(
                Icons.search,
                color: MyColor.neutral600,
              ),
            ),

            SizedBox(
              height: AdaptSize.pixel16,
            ),

            /// list umkm
            Consumer<ProductDummyData>(builder: (context, value, child) {
              return SizedBox(
                width: double.infinity,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.productModel.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return listProductCard(
                          context: context,
                          onTap: () {
                            NavigasiViewModel().navigasiDetailProduct(
                              context: context,
                              productId: value.productModel[index].productId,
                            );
                          },
                          image: value.productModel[index].productImage,
                          productName: value.productModel[index].productName,
                          productLocation:
                              value.productModel[index].productLocation,
                          productPrice: value.productModel[index].productPrice,
                          productRW: value.productModel[index].productRW,
                        );
                      }),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
