import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/user_viewmodel.dart';
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
    context.read<UserViewModel>().refreshUsers();
    // context.read<ProductViewModel>().refreshProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductViewModel>(context, listen: false);
    return Scaffold(
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
            bottom: AdaptSize.pixel10,
            top: AdaptSize.paddingTop + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// name
              Row(
                children: [
                  Text(
                    'Hello ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: AdaptSize.pixel20),
                  ),
                  Consumer<UserViewModel>(builder: (context, value, child) {
                    return Text(
                      value.usermodel?.username ?? 'Loading..',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: AdaptSize.pixel20),
                    );
                  }),
                ],
              ),
              Text(
                'Cari produk di Kelurahan Siwalan?',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: AdaptSize.pixel14),
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
                  NavigasiViewModel().navigasiSearchProductScreen(context);
                },
                prefixIcon: Icon(
                  Icons.search,
                  color: MyColor.neutral600,
                ),
              ),

              SizedBox(
                height: AdaptSize.pixel16,
              ),

              StreamBuilder(
                  stream: productProvider.productStream,
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: MyColor.danger600,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: double.infinity,
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return listProductCard(
                                  context: context,
                                  onTap: () {
                                    NavigasiViewModel().navigasiDetailProduct(
                                      context: context,
                                      product:
                                          snapshot.data!.docs[index].data(),
                                    );
                                  },
                                  product: snapshot.data!.docs[index].data(),
                                );
                              }),
                        ),
                      );
                    }
                    return Align(
                      alignment: Alignment.center,
                      child: Text(
                        'loading..',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: AdaptSize.pixel14),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
