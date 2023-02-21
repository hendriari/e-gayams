import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/home/tab_view/all%20_product.dart';
import 'package:kkn_siwalan/src/screen/menu/home/tab_view/grid_product.dart';
import 'package:kkn_siwalan/src/screen/menu/home/tab_view/tab_bar.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kkn_siwalan/src/utils/enums.dart';
import 'package:kkn_siwalan/src/viewmodel/account_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_parser.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan/src/screen/menu/home/product_category/home_category_product.dart';
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
    final productParsers = Provider.of<ProductParsers>(context, listen: false);
    Future.delayed(Duration.zero, () {
      if (productParsers.allListProduct.isEmpty) {
        return productParsers.fetchAllData();
      }
      debugPrint(productParsers.allListProduct.toString());
    });
    Future.delayed(Duration.zero, () {
      if (productParsers.kelurahanSiwalan.isEmpty ||
          productParsers.kelurahanGayamsari.isEmpty ||
          productParsers.kelurahanSambirejo.isEmpty ||
          productParsers.kelurahanPandeanLamper.isEmpty ||
          productParsers.kelurahanSawahBesar.isEmpty ||
          productParsers.kelurahanTambakRejo.isEmpty ||
          productParsers.kelurahanKaligawe.isEmpty) {
        productParsers.fetchProductKelurahanSiwalan();
        productParsers.fetchProductKelurahanGayamsari();
        productParsers.fetchProductKelurahanSambirejo();
        productParsers.fetchProductKelurahanPandeanLamper();
        productParsers.fetchProductKelurahanSawahBesar();
        productParsers.fetchProductKelurahanTambakrejo();
        productParsers.fetchProductKelurahanKaligawe();
      }
    });
    Future.delayed(Duration.zero,(){
      productParsers.fetchProductByCategory();
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
    final productProvider =
        Provider.of<ProductViewModel>(context, listen: false);
    return Scaffold(
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: Padding(
          padding: EdgeInsets.only(
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
            top: AdaptSize.paddingTop + 2,
          ),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  NavigasiViewModel()
                                      .navigateToNotification(context);
                                },
                                splashColor: MyColor.neutral900,
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  'assets/grid_category/bell_notif.png',
                                  height: AdaptSize.pixel20,
                                  width: AdaptSize.pixel20,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            'Cari Produk di Kecamatan Gayamsari ?',
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
                              NavigasiViewModel()
                                  .navigasiSearchProductScreen(context);
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
                          Consumer<ProductParsers>(
                              builder: (context, value, child) {
                            if (value.stateOfConnnection ==
                                StateOfConnnection.isLoading) {
                              return cardShimmerWidget(
                                borderRadius: 16,
                                imagesShimmer: 'logo_kkn_siwalan.png',
                                height: AdaptSize.screenWidth / 1000 * 450,
                                width: double.infinity,
                              );
                            }
                            if (value.stateOfConnnection ==
                                StateOfConnnection.isReady) {
                              return value.allListProduct.isNotEmpty
                                  ? CarouselSlider.builder(
                                      itemCount:
                                          value.allListProduct.length >= 5
                                              ? 5
                                              : value.allListProduct.length,
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        return CachedNetworkImage(
                                          imageUrl: value.allListProduct[index]
                                              ['productImage'],
                                          imageBuilder:
                                              (context, imageProvider) => Hero(
                                            tag: value.allListProduct[index]
                                                ['productImage'],
                                            child: Material(
                                              child: InkWell(
                                                onTap: () {
                                                  NavigasiViewModel()
                                                      .navigasiDetailProduct(
                                                    context: context,
                                                    product: value
                                                        .allListProduct[index],
                                                  );
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                splashColor: MyColor.neutral900,
                                                child: Container(
                                                  margin: EdgeInsets.all(
                                                      AdaptSize.pixel8),
                                                  decoration: BoxDecoration(
                                                    color: MyColor.danger400,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset:
                                                            const Offset(2, 3),
                                                        color:
                                                            MyColor.neutral600,
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
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: AdaptSize
                                                                  .pixel10,
                                                              right: AdaptSize
                                                                  .pixel10,
                                                              top: AdaptSize
                                                                  .pixel5,
                                                              bottom: AdaptSize
                                                                  .pixel5,
                                                            ),
                                                            child: Text(
                                                              'NEW',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          AdaptSize
                                                                              .pixel12,
                                                                      color: MyColor
                                                                          .neutral900),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Container(
                                                          height: AdaptSize
                                                                  .screenWidth /
                                                              1000 *
                                                              80,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: AdaptSize
                                                                      .pixel8),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    .3),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(16),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          16),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            value.allListProduct[
                                                                    index]
                                                                ['productName'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize:
                                                                      AdaptSize
                                                                          .pixel16,
                                                                  color: MyColor
                                                                      .neutral900,
                                                                ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              shimmerLoading(
                                            child: cardShimmerWidget(
                                              borderRadius: 16,
                                              imagesShimmer:
                                                  'logo_kkn_siwalan.png',
                                              margin: EdgeInsets.all(
                                                AdaptSize.pixel8,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              errorShimmerWidget(
                                            borderRadius: 16,
                                            imagesShimmer: 'close.png',
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        height:
                                            AdaptSize.screenWidth / 1000 * 450,
                                        viewportFraction: .9,
                                        autoPlay: true,
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        onPageChanged: (index, reason) =>
                                            value.changeIndex(index: index),
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: MyColor.warning600,
                                      ),
                                    );
                            }
                            if (value.stateOfConnnection ==
                                StateOfConnnection.isFailed) {
                              return shimmerLoading(
                                child: Column(
                                  children: [
                                    cardShimmerWidget(
                                      borderRadius: 16,
                                      imagesShimmer: 'logo_kkn_siwalan.png',
                                      height:
                                          AdaptSize.screenWidth / 1000 * 450,
                                      width: double.infinity,
                                    ),
                                    Text(
                                      'Something Wrong',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: AdaptSize.pixel14),
                                    )
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }),

                          SizedBox(
                            height: AdaptSize.pixel8,
                          ),

                          /// dot
                          Consumer<ProductParsers>(
                              builder: (context, value, child) {
                            return value.allListProduct.isNotEmpty
                                ? Center(
                                    child: AnimatedSmoothIndicator(
                                      activeIndex: value.indexSlider,
                                      count: value.allListProduct.length >= 5
                                          ? 5
                                          : value.allListProduct.length,
                                      effect: ExpandingDotsEffect(
                                        dotWidth: AdaptSize.pixel8,
                                        dotHeight: AdaptSize.pixel8,
                                        dotColor: MyColor.neutral700,
                                        activeDotColor: MyColor.warning500,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: SizedBox(
                                      width: AdaptSize.screenWidth / 1000 * 300,
                                      child: LinearProgressIndicator(
                                        color: MyColor.warning600,
                                        backgroundColor: MyColor.neutral700,
                                      ),
                                    ),
                                  );
                          }),

                          SizedBox(
                            height: AdaptSize.pixel8,
                          ),

                          /// category product
                          categoryProductWidget(
                            context: context,
                            gridContent: productProvider.listGridCategory,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// tab bar controller
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    tabBarWidget(
                        context: context, tabController: _tabBarController),
                  ),
                ),
              ];
            },
            body: Consumer<ProductParsers>(builder: (context, value, child) {
              return TabBarView(
                controller: _tabBarController,
                children: [
                  allProductView(
                    context: context,
                    listOfProduct: value.allListProduct,
                  ),
                  gridProduct(
                    listKelurahan: value.kelurahanSiwalan,
                  ),
                  gridProduct(
                    listKelurahan: value.kelurahanGayamsari,
                  ),
                  gridProduct(
                    listKelurahan: value.kelurahanSambirejo,
                  ),
                  gridProduct(
                    listKelurahan: value.kelurahanPandeanLamper,
                  ),
                  gridProduct(
                    listKelurahan: value.kelurahanSawahBesar,
                  ),
                  gridProduct(
                    listKelurahan: value.kelurahanTambakRejo,
                  ),
                  gridProduct(
                    listKelurahan: value.kelurahanKaligawe,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
