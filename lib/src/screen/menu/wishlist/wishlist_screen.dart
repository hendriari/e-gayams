import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';

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
        onlineChild: Center(
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
