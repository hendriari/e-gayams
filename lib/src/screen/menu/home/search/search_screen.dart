import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/home/tab_view/grid_product.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/product_parser.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:kkn_siwalan/src/widget/form_field_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final searchProduct = Provider.of<ProductParsers>(context, listen: false);
    Future.delayed(Duration.zero, () {
      searchProduct.filterProductByKeyword(keyword: _searchController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Search Product',
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: AdaptSize.pixel20,
            color: Colors.black,
          ),
        ),
      ),
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: Padding(
          padding: EdgeInsets.only(
            top: AdaptSize.pixel14,
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
          ),
          child: Consumer<ProductParsers>(builder: (context, value, child) {
            return Column(
              children: [
                /// search
                formFieldWidget(
                  context: context,
                  textEditingController: _searchController,
                  suffix: IconButton(
                    onPressed: () {
                      /// show modal bottom sheet here
                    },
                    icon: Icon(
                      Icons.analytics_outlined,
                      color: MyColor.neutral400,
                    ),
                  ),
                  onChanged: (values) =>
                      value.filterProductByKeyword(keyword: values),
                  hint: 'Cari Produk',
                  label: 'Cari Produk',
                ),

                SizedBox(
                  height: AdaptSize.pixel10,
                ),

                /// content
                Expanded(
                  child: value.foundProduct.isNotEmpty
                      ? gridProduct(
                          context: context,
                          scrollPhysics: const BouncingScrollPhysics(),
                          listKelurahan: value.foundProduct,
                          listPaddingBottom: false,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/image/error.png',
                              height: AdaptSize.screenWidth / 2,
                              width: AdaptSize.screenWidth / 2,
                            ),
                            SizedBox(
                              height: AdaptSize.screenHeight * .012,
                            ),
                            Text(
                              'Produk apa yang Kamu cari ?',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: AdaptSize.pixel15),
                            ),
                            SizedBox(
                              height: AdaptSize.screenHeight * .01,
                            ),
                            Text(
                                'Kamu bisa mencari produk dengan memasukan kata kunci Nama Produk, Lokasi Produk, atau Nama Toko',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: AdaptSize.pixel14))
                          ],
                        ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
