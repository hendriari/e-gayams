import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/order_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/default_appbar.dart';
import 'package:kkn_siwalan/src/widget/search_widget.dart';
import 'package:provider/provider.dart';

class MyCardScreen extends StatefulWidget {
  const MyCardScreen({Key? key}) : super(key: key);

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: defaultAppBar(
            context: context, title: 'Pesanan', centerTitle: true),
        body: Consumer<OrderViewModel>(
          builder: (BuildContext context, value, Widget? child) {
            return value.myOrderList.isNotEmpty
                ? ListView.builder(
                itemCount: value.myOrderList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    splashColor: MyColor.neutral900,
                    onTap: () {
                     /// navigate here
                    },
                    child: productCardWidget(
                        context: context,
                        product: value.myOrderList[index]),
                  );
                })
                : Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/emptycart.png',
                          height: AdaptSize.screenWidth / 1000 * 800,
                          width: AdaptSize.screenWidth / 1000 * 800,
                        ),
                        SizedBox(
                          height: AdaptSize.pixel12,
                        ),
                        Text(
                          'Anda tidak memiliki pesanan',
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
        ),
      ),
    );
  }
}
