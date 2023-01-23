import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/screen/auth/login_screen.dart';
import 'package:kkn_siwalan/src/screen/auth/register_screen.dart';
import 'package:kkn_siwalan/src/screen/landing/onboarding_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/home_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/menu_screen.dart';

class NavigasiViewModel {
  /// navigate to onboarding
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

  /// navigate to register
  void navigateToRegister(BuildContext context) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  /// navigate to login
  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  /// common naviagsi back
  void navigasiBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// navigasi signin
  void navigasiMenuScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoModalPopupRoute(
          builder: (context) => const MenuScreen(),
        ),
        (route) => false);
  }

  /// navigasi logout
  void navigasiLogout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const LoginScreen(),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        (route) => false);
  }
}
