import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:kkn_siwalan/src/widget/form_field_widget.dart';
import 'package:kkn_siwalan/src/widget/search_widget.dart';

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
                hint: 'Cari Produk',
                label: 'Cari Produk',
              ),

              SizedBox(
                height: AdaptSize.pixel10,
              ),

              /// search Product
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('productMitra')
                    .where(
                      'sellerName',
                      isGreaterThanOrEqualTo: _searchController.text,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(16),
                          splashColor: MyColor.neutral900,
                          onTap: () {
                            NavigasiViewModel().navigasiDetailProduct(
                              context: context,
                              product: snapshot.data!.docs[index].data(),
                            );
                          },
                          child: productCardWidget(
                              context: context,
                              product: snapshot.data!.docs[index].data()),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
