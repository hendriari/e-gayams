import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';

class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      NavigasiViewModel().navigateToOnboarding(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    AdaptSize.size(context: context);
    return Container(
      height: AdaptSize.screenHeight,
      width: AdaptSize.screenWidth,
      color: MyColor.neutral900,
    );
  }
}
