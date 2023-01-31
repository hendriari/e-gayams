import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/dummy/product_data_dummy.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kkn_siwalan/src/viewmodel/home_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/user_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/information_card_widget.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    context.read<ProductDummyData>().addDataDummy(5);
  }

  @override
  Widget build(BuildContext context) {
    final dummyInfo = Provider.of<ProductDummyData>(context, listen: false);
    return Scaffold(
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: SingleChildScrollView(
          physics: const ScrollPhysics(),
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
                    return Text(
                      value.usermodel?.username ?? 'Loading..',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: AdaptSize.pixel20),
                    );
                  })
                ],
              ),

              Text(
                'Apa kabar hari ini?',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: AdaptSize.pixel14),
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// carousel image
              Consumer<HomeViewModel>(builder: (context, value, child) {
                return CarouselSlider.builder(
                  itemCount: dummyInfo.productModel.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return CachedNetworkImage(
                      imageUrl: dummyInfo.productModel[index].productImage,
                      imageBuilder: (context, imageProvider) => Container(
                        margin: EdgeInsets.all(AdaptSize.pixel8),
                        decoration: BoxDecoration(
                          color: MyColor.danger400,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2, 3),
                              color: MyColor.neutral600,
                              blurRadius: 3,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageProvider,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => shimmerLoading(
                        child: cardShimmerWidget(
                          borderRadius: 16,
                          imagesShimmer: 'logo_kkn_siwalan.png',
                          margin: EdgeInsets.all(
                            AdaptSize.pixel8,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => errorShimmerWidget(
                        borderRadius: 16,
                        imagesShimmer: 'close.png',
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: AdaptSize.screenWidth / 1000 * 450,
                    viewportFraction: .9,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) =>
                        value.changeIndex(index: index),
                  ),
                );
              }),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// dot
              Consumer<HomeViewModel>(builder: (context, value, child) {
                return Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: value.indexSlider,
                    count: dummyInfo.productModel.length,
                    effect: ExpandingDotsEffect(
                      dotWidth: AdaptSize.pixel8,
                      dotHeight: AdaptSize.pixel8,
                      dotColor: MyColor.neutral700,
                      activeDotColor: MyColor.warning500,
                    ),
                  ),
                );
              }),

              SizedBox(
                height: AdaptSize.pixel12,
              ),

              /// text info terkini
              Text(
                'Informasi terkini',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: AdaptSize.pixel16),
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// list info terkini
              SizedBox(
                height: AdaptSize.screenWidth / 1000 * 410,
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dummyInfo.productModel.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return infoCardWidget(
                        context: context,
                        withInfo: true,
                        image: dummyInfo.productModel[index].productImage,
                        textInformation:
                            dummyInfo.productModel[index].productName,
                      );
                    }),
              ),

              SizedBox(
                height: AdaptSize.pixel12,
              ),

              /// text kegiatan info mendatang
              Text(
                'Kegiatan mendatang',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: AdaptSize.pixel16),
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// list kegiatan mendatang
              SizedBox(
                height: AdaptSize.screenWidth / 1000 * 410,
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dummyInfo.productModel.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return infoCardWidget(
                        context: context,
                        withInfo: true,
                        image: dummyInfo.productModel[index].productImage,
                        textInformation:
                            dummyInfo.productModel[index].productName,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
