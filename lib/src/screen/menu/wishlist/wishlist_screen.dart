import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/custom_dialogs.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:kkn_siwalan/src/widget/wishlist_card_widget.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Wishlist',
      ),
      body: NetworkAware(
          offlineChild: const NoConnectionScreen(),
          onlineChild: Consumer<ProductViewModel>(
            builder: (context, value, child) {
              return value.productWishlist.isNotEmpty
                  ? ListView.builder(
                      itemCount: value.productWishlist.length,
                      itemBuilder: (context, index) {
                        return whistListCard(
                          context: context,
                          bookmarkOntap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  CustomDialogs.dialogRemoveWhislist(
                                context: context,
                                onPressed1: () {
                                  Navigator.pop(context);
                                },
                                onPressed2: () {
                                  value.removeWhislistOffice(index);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          productImage:
                              value.productWishlist[index].productImage,
                          productRw: value.productWishlist[index].productRW,
                          sellerName: value.productWishlist[index].sellerName,
                          productName: value.productWishlist[index].productName,
                          productLocation:
                              value.productWishlist[index].productLocation,
                        );
                      })
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/image/wishlist.png',
                            height: AdaptSize.screenWidth / 1000 * 800,
                            width: AdaptSize.screenWidth / 1000 * 800,
                          ),
                          SizedBox(
                            height: AdaptSize.pixel12,
                          ),
                          Text(
                            'Wishlist kosong',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: AdaptSize.pixel16),
                          ),
                          SizedBox(
                            height: AdaptSize.pixel40,
                          ),
                        ],
                      ),
                    );
            },
          )),
    );
  }
}
