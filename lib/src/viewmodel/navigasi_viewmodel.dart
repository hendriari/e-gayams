import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/screen/auth/login_screen.dart';
import 'package:kkn_siwalan/src/screen/auth/register_screen.dart';
import 'package:kkn_siwalan/src/screen/landing/onboarding_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/account/change_password_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/home/notification_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/menu_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/search/search_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/home/detail_product_screen.dart';

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

  /// common navigasi account menu
  void navigasiAccountMenu({
    required BuildContext context,
    required Widget route,
  }) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => route,
      ),
    );
  }

  /// forgot password
  void forgotPassword(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ChangePasswordScreen(
          titleAppbar: 'Forgot Password',
        ),
      ),
    );
  }

  /// navigasi to detail product
  void navigasiDetailProduct({
    required BuildContext context,
    required Map<String, dynamic> product,
    // required String productId,
  }) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => DetailProductScreen(
          product: product,
        ),
      ),
    );
  }

  /// back to menu with index
  void navigasiToMenuWithIndex({
    required BuildContext context,
    required int index,
  }) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => MenuScreen(
            currentIndex: index,
          ),
        ),
        (route) => false);
  }

  /// search screen
  void navigasiSearchProductScreen(BuildContext context){
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const SearchScreen(),
      ),
    );
  }

  /// navigate to login
  void navigateToNotification(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const NotificationScreen(),
      ),
    );
  }
}
