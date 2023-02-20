import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/account_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
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
    context.read<AccountViewModel>().refreshUsers();
    final productProvider =
        Provider.of<ProductViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      if (productProvider.allListProduct.isEmpty) {
        productProvider.fetchAllData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  Consumer<AccountViewModel>(builder: (context, value, child) {
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
            ],
          ),
        ),
      ),
    );
  }
}
