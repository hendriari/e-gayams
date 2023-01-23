import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/auth/register_screen.dart';
import 'package:kkn_siwalan/src/screen/landing/onboarding_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/menu_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';

class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     NavigasiViewModel().navigateToOnboarding(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    AdaptSize.size(context: context);
    // return Container(
    //   height: AdaptSize.screenHeight,
    //   width: AdaptSize.screenWidth,
    //   color: MyColor.neutral900,
    // );
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const MenuScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MyColor.warning600,
              ),
            );
          }
        }
        return const OnBoardingScreen();
      },
    );
  }
}
