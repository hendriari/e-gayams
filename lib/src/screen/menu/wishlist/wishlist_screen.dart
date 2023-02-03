import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider =
    Provider.of<ProductViewModel>(context, listen: false);
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Wishlist',
      ),
      body: NetworkAware(
          offlineChild: const NoConnectionScreen(),
          onlineChild:


          // Consumer<ProductViewModel>(
          //   builder: (context, value, child) {
          //     value.productWishlist.isNotEmpty
          //         ? ListView.builder(
          //         itemCount: value.productWishlist.length,
          //         itemBuilder: (context, index) {
          //       return Text(value.productWishlist[index].sellerName);
          //     })
          //         : Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Image.asset(
          //             'assets/image/wishlist.png',
          //             height: AdaptSize.screenWidth / 1000 * 800,
          //             width: AdaptSize.screenWidth / 1000 * 800,
          //           ),
          //           SizedBox(
          //             height: AdaptSize.pixel12,
          //           ),
          //           Text(
          //             'Wishlist kosong',
          //             style: Theme
          //                 .of(context)
          //                 .textTheme
          //                 .bodyText1!
          //                 .copyWith(fontSize: AdaptSize.pixel16),
          //           ),
          //           SizedBox(
          //             height: AdaptSize.pixel40,
          //           ),
          //         ],
          //       ),
          //     );
          //     return Center(
          //       child: CircularProgressIndicator(
          //         color: MyColor.warning600,
          //       ),
          //     );
          //   },
          // )

        // StreamBuilder(
        //     stream: FirebaseFirestore.instance.collection('newUser').doc('uid').collection('wishlist').snapshots(),
        //     builder: (context,
        //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
        //         snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(
        //             color: MyColor.warning600,
        //           ),
        //         );
        //       }
        //       if (snapshot.hasData) {
        //         return SizedBox(
        //           width: double.infinity,
        //           child: MediaQuery.removePadding(
        //             removeTop: true,
        //             context: context,
        //             child: ListView.builder(
        //                 shrinkWrap: true,
        //                 itemCount: snapshot.data!.docs.length,
        //                 physics: const NeverScrollableScrollPhysics(),
        //                 itemBuilder: (context, index) {
        //                   Map<String, dynamic> ws = snapshot.data!.docs[index].data();
        //                   return Text(ws['sellerName']);
        //                   // return listProductCard(
        //                   //   context: context,
        //                   //   onTap: () {
        //                   //     NavigasiViewModel().navigasiDetailProduct(
        //                   //       context: context,
        //                   //       product:
        //                   //       snapshot.data!.docs[index].data(),
        //                   //     );
        //                   //   },
        //                   //   product: snapshot.data!.docs[index].data(),
        //                   // );
        //                 }),
        //           ),
        //         );
        //       }
        //       return Align(
        //         alignment: Alignment.center,
        //         child: Text(
        //           'loading..',
        //           style: Theme.of(context)
        //               .textTheme
        //               .bodyText1!
        //               .copyWith(fontSize: AdaptSize.pixel14),
        //         ),
        //       );
        //     })

        Center(
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
        ),
      ),
    );
  }
}
