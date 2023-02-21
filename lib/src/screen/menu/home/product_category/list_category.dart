import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/menu/home/tab_view/all%20_product.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/viewmodel/product_parser.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:provider/provider.dart';

class ListCategoryProductScreen extends StatefulWidget {
  final String headerName;
  final List<Map<String, dynamic>> listOfProduct;

  const ListCategoryProductScreen({
    Key? key,
    required this.headerName,
    required this.listOfProduct,
  }) : super(key: key);

  @override
  State<ListCategoryProductScreen> createState() =>
      _ListCategoryProductScreenState();
}

class _ListCategoryProductScreenState extends State<ListCategoryProductScreen> {
  @override
  void initState() {
    super.initState();
    final productProvider = Provider.of<ProductParsers>(context, listen: false);
    productProvider.category = widget.headerName;
    debugPrint(
        'total produk ${widget.headerName} adalah ${widget.listOfProduct.length}');
    Future.delayed(Duration.zero, () {
      productProvider.refreshProductCategory(
          listOfCategory: widget.listOfProduct);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: widget.headerName,
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
      body: Consumer<ProductParsers>(
        builder: (context, value, child) {
          return value.listOfProductCategory.isNotEmpty
              ? allProductView(
            context: context,
            listOfProduct: value.listOfProductCategory,
          )
              : Center(
            child: Text(
              'Belum Ada Produk',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: AdaptSize.pixel16),
            ),
          );
        },
      ),
    );
  }
}
