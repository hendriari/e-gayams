import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'About E-Siwalan',
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
        onlineChild: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
              left: AdaptSize.pixel16,
              right: AdaptSize.pixel16,
              top: AdaptSize.pixel16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aplikasi Pasar Siwalan merupakan Inovasi hasil mahasiswa KKN Universitas PGRI Semarang di Kelurahan Siwalan. Aplikasi ini digunakan untuk mengenalkan produk yang tersedia di Kelurahan Siwalan, Kecamatan Gayamsari, Kota Semarang. Aplikasi ini dibuat dengan tujuan membantu pelaku UMKM di kelurahan siwalan untuk menjangkau pasar yang lebih luas. Dengan adanya aplikasi ini semoga dapat membantu pelaku UMKM di Kelurahan Siwalan, Kecamatan Gayamsari, Kota Semarang.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: AdaptSize.pixel14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: AdaptSize.pixel8,
              ),
              Text(
                'Last revised on Februari 3, 2023',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: AdaptSize.pixel14),
              ),
              SizedBox(
                height: AdaptSize.pixel8,
              ),
              Center(
                child: Image.asset(
                  'assets/image/logo_kkn.png',
                  height: AdaptSize.pixel75,
                ),
              ),
              SizedBox(
                height: AdaptSize.screenHeight * .05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
