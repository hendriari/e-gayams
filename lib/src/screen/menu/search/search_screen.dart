import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:kkn_siwalan/src/widget/form_field_widget.dart';
import 'package:kkn_siwalan/src/widget/search_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductViewModel>(context, listen: false);
    if (productProvider.items.isEmpty) {
      productProvider.fetchAllData();
    }
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
          child: Column(
            children: [
              /// search
              formFieldWidget(
                context: context,
                textEditingController: _searchController,
                suffix: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: MyColor.neutral400,
                  ),
                ),
                onChanged: (value) {
                  Provider.of<ProductViewModel>(context, listen: false)
                      .filters = value.split(' ');
                },
                hint: 'Cari Produk',
                label: 'Cari Produk',
              ),

              SizedBox(
                height: AdaptSize.pixel10,
              ),

              /// search Product
              Consumer<ProductViewModel>(
                builder: (context, itemProvider, child) {
                  return Expanded(
                    child: itemProvider.items.isNotEmpty
                        ? ListView.builder(
                            itemCount: itemProvider.items.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(16),
                                splashColor: MyColor.neutral900,
                                onTap: () {
                                  NavigasiViewModel().navigasiDetailProduct(
                                    context: context,
                                    product: itemProvider.items[index],
                                  );
                                },
                                child: productCardWidget(
                                    context: context,
                                    product: itemProvider.items[index]),
                              );
                            })
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
                                    .headline6!
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
                                      .bodyText1!
                                      .copyWith(fontSize: AdaptSize.pixel14))
                            ],
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
