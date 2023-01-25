import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/dummy/product_data_dummy.dart';
import 'package:kkn_siwalan/src/screen/menu/account/profile_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/user_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/product_card.dart';
import 'package:kkn_siwalan/src/widget/read_only_form.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserViewModel>().refreshUsers();
    context.read<ProductDummyData>().addDataDummy(11);
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
          bottom: AdaptSize.screenWidth / 1000 * 250,
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
                  return Text(value.usermodel?.username ?? 'errors',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: AdaptSize.pixel20));
                })
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

            boldTitleText(context: context, text: 'UMKM RW 01'),

            Consumer<ProductDummyData>(builder: (context, value, child) {
              return SizedBox(
                height: AdaptSize.screenWidth / 1000 * 800,
                width: double.infinity,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value.productModel.length,
                      itemBuilder: (context, index) {
                        return productCard(
                          context: context,
                          itemCount: value.productModel.length,
                          image: value.productModel[index].productImage,
                          productName: value.productModel[index].productName,
                          location: value.productModel[index].productLocation,
                        );
                      }),
                ),
              );
            }),

            SizedBox(
              height: AdaptSize.pixel16,
            ),

            boldTitleText(context: context, text: 'UMKM RW 02'),

            Consumer<ProductDummyData>(builder: (context, value, child) {
              return SizedBox(
                height: AdaptSize.screenWidth / 1000 * 800,
                width: double.infinity,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value.productModel.length,
                      itemBuilder: (context, index) {
                        return productCard(
                          context: context,
                          itemCount: value.productModel.length,
                          image: value.productModel[index].productImage,
                          productName: value.productModel[index].productName,
                          location: value.productModel[index].productLocation,
                        );
                      }),
                ),
              );
            }),

            SizedBox(
              height: AdaptSize.pixel16,
            ),

            boldTitleText(context: context, text: 'UMKM RW 03'),

            Consumer<ProductDummyData>(builder: (context, value, child) {
              return SizedBox(
                height: AdaptSize.screenWidth / 1000 * 800,
                width: double.infinity,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value.productModel.length,
                      itemBuilder: (context, index) {
                        return productCard(
                          context: context,
                          itemCount: value.productModel.length,
                          image: value.productModel[index].productImage,
                          productName: value.productModel[index].productName,
                          location: value.productModel[index].productLocation,
                        );
                      }),
                ),
              );
            }),

            SizedBox(
              height: AdaptSize.pixel16,
            ),

            boldTitleText(context: context, text: 'UMKM RW 04'),
            Consumer<ProductDummyData>(builder: (context, value, child) {
              return SizedBox(
                height: AdaptSize.screenWidth / 1000 * 800,
                width: double.infinity,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value.productModel.length,
                      itemBuilder: (context, index) {
                        return productCard(
                          context: context,
                          itemCount: value.productModel.length,
                          image: value.productModel[index].productImage,
                          productName: value.productModel[index].productName,
                          location: value.productModel[index].productLocation,
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

  Widget boldTitleText({
    required BuildContext context,
    required String text,
  }) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontSize: AdaptSize.pixel14),
    );
  }
}
