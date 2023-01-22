import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/screen/auth/register_screen.dart';
import 'package:kkn_siwalan/src/screen/onboarding_screen.dart';

class NavigasiViewModel {
  void navigateToOnboarding(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const OnBoardingScreen(),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        (route) => false);
  }

  void navigateToRegister(BuildContext context) {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => RegisterScreen()));
  }
}
