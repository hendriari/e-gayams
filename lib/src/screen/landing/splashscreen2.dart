import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/screen/landing/onboarding_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/menu_screen.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/notif_viewmodel.dart';
import 'package:provider/provider.dart';

class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {

  @override
  void initState() {
    super.initState();
    final notifProvider = Provider.of<NotificationViewModel>(context, listen: false);
    Future.delayed(Duration.zero,(){
      notifProvider.saveTokenFCMinMultipleDevice(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    AdaptSize.size(context: context);
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
