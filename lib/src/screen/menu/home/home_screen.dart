import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/dummy/product_data_dummy.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/home/tab_view/all%20_product.dart';
import 'package:kkn_siwalan/src/screen/menu/home/tab_view/grid_product.dart';
import 'package:kkn_siwalan/src/screen/menu/home/tab_view/tab_bar.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kkn_siwalan/src/viewmodel/account_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/home_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/widget/read_only_form.dart';
import 'package:kkn_siwalan/src/widget/shimmer_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabBarController;

  @override
  void initState() {
    super.initState();
    context.read<AccountViewModel>().refreshUsers();
    context.read<ProductDummyData>().addDataDummy(5);
    final product = Provider.of<ProductViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      if (product.allListProduct.isEmpty) {
        return product.fetchAllData();
      }
      debugPrint(product.allListProduct.toString());
    });
    _tabBarController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabBarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dummyInfo = Provider.of<ProductDummyData>(context, listen: false);
    return Scaffold(
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
            top: AdaptSize.paddingTop + 5,
            bottom: AdaptSize.screenWidth / 1000 * 200,
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
                  Expanded(
                    child: Consumer<AccountViewModel>(
                        builder: (context, value, child) {
                      return Text(
                        value.usermodel?.username ?? 'Loading..',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: AdaptSize.pixel20),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    }),
                  ),
                  InkWell(
                    onTap: () {
                      NavigasiViewModel().navigateToNotification(context);
                    },
                    splashColor: MyColor.neutral900,
                    borderRadius: BorderRadius.circular(25),
                    child: Icon(
                      Icons.notifications_active_outlined,
                      size: AdaptSize.pixel20,
                      color: MyColor.warning400,
                    ),
                  )
                ],
              ),

              Text(
                'Cari Produk di Kelurahan Siwalan ?',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: AdaptSize.pixel14),
              ),

              SizedBox(
                height: AdaptSize.pixel8,
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
                height: AdaptSize.pixel8,
              ),

              /// carousel image
              Consumer<HomeViewModel>(builder: (context, value, child) {
                return CarouselSlider.builder(
                  itemCount: dummyInfo.productModel.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
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
                        child: Stack(
                          children: [
                            Positioned(
                              left: AdaptSize.pixel3,
                              top: AdaptSize.pixel3,
                              child: Card(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: AdaptSize.pixel10,
                                    right: AdaptSize.pixel10,
                                    top: AdaptSize.pixel5,
                                    bottom: AdaptSize.pixel5,
                                  ),
                                  child: Text(
                                    'NEW',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize: AdaptSize.pixel12,
                                            color: MyColor.neutral900),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: AdaptSize.screenWidth / 1000 * 80,
                                padding:
                                    EdgeInsets.only(left: AdaptSize.pixel8),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.3),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'test',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: AdaptSize.pixel16,
                                        color: MyColor.neutral900,
                                      ),
                                ),
                              ),
                            )
                          ],
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
                height: AdaptSize.pixel16,
              ),

              /// tabbar
              tabBarWidget(context: context, tabController: _tabBarController),

              SizedBox(
                height: AdaptSize.screenWidth / 1000 * 2000,
                child: TabBarView(
                  controller: _tabBarController,
                  children: [
                    allProductView(
                      context: context,
                    ),
                    gridProduct(),
                    gridProduct(),
                    gridProduct(),
                    gridProduct(),
                    gridProduct(),
                    allProductView(
                      context: context,
                    ),
                    allProductView(
                      context: context,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
