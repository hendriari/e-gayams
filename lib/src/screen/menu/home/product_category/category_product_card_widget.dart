import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'dart:math' as math;
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/viewmodel/product_parser.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

class CategoryProductCardWidget extends StatefulWidget {
  final List gridContent;

  const CategoryProductCardWidget({
    Key? key,
    required this.gridContent,
  }) : super(key: key);

  @override
  State<CategoryProductCardWidget> createState() =>
      _CategoryProductCardWidgetState();
}

class _CategoryProductCardWidgetState extends State<CategoryProductCardWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final animationProvider =
        Provider.of<ProductViewModel>(context, listen: false);
    animationProvider.controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animationProvider.animation = Tween<double>(begin: 0, end: math.pi)
        .animate(animationProvider.controller)
      ..addListener(() {
        animationProvider.listen();
      });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<ProductParsers>(context, listen: false);
    return Consumer<ProductViewModel>(
        builder: (context, animationProvider, child) {
      return SizedBox(
        height: AdaptSize.screenWidth / 1000 * 720,
        width: double.infinity,
        child: MediaQuery.removePadding(
          removeTop: true,
          removeBottom: true,
          context: context,
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisExtent: AdaptSize.screenWidth / 1000 * 360,
              ),
              itemCount: widget.gridContent.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    animationProvider.triggerAnimation(index: index);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      NavigasiViewModel().navigasiToPorudctByCategory(
                        context: context,
                        headerName: widget.gridContent[index][1],
                        listOfProductCategory: widget.gridContent[index][1] ==
                                'Makanan Ringan'
                            ? categoryProvider.listMakananRingan
                            : widget.gridContent[index][1] == 'Makanan'
                                ? categoryProvider.listMakanan
                                : widget.gridContent[index][1] == 'Minuman'
                                    ? categoryProvider.listMinuman
                                    : widget.gridContent[index][1] ==
                                            'Kesehatan'
                                        ? categoryProvider.listKesehatan
                                        : widget.gridContent[index][1] ==
                                                'Kecantikan'
                                            ? categoryProvider.listKecantikan
                                            : widget.gridContent[index][1] ==
                                                    'Fashion'
                                                ? categoryProvider.listFashion
                                                : widget.gridContent[index]
                                                            [1] ==
                                                        'Kerajinan Tangan'
                                                    ? categoryProvider
                                                        .listKerajinanTangan
                                                    : widget.gridContent[index]
                                                                [1] ==
                                                            'Produk Lainnya'
                                                        ? categoryProvider
                                                            .listKategoriLainnya
                                                        : categoryProvider
                                                            .listKategoriLainnya,
                      );
                    });
                  },
                  child: Column(
                    children: [
                      animationProvider.indexAnimation == index
                          ? Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(animationProvider.animation.value),
                              alignment: Alignment.center,
                              child: Container(
                                height: AdaptSize.screenWidth / 1000 * 200,
                                margin: EdgeInsets.all(AdaptSize.pixel8),
                                decoration: BoxDecoration(
                                  color: MyColor.neutral800,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyColor.neutral500,
                                      blurStyle: BlurStyle.solid,
                                      blurRadius: 3,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                        widget.gridContent[index][0]),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: AdaptSize.screenWidth / 1000 * 200,
                              margin: EdgeInsets.all(AdaptSize.pixel8),
                              decoration: BoxDecoration(
                                color: MyColor.neutral800,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColor.neutral500,
                                    blurStyle: BlurStyle.solid,
                                    blurRadius: 3,
                                  ),
                                ],
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image:
                                      AssetImage(widget.gridContent[index][0]),
                                ),
                              ),
                            ),
                      Text(
                        widget.gridContent[index][1],
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: AdaptSize.pixel12),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
    });
  }
}
