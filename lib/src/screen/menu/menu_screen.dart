import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/menu_viewmodel.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuViewModel>(builder: (context, value, child) {
      return WillPopScope(
        onWillPop: () async {
          return value.onWillPop(context);
        },
        child: Scaffold(
          extendBody: true,
          body: value.pages,
          bottomNavigationBar: _bottomNavBar(context),
        ),
      );
    });
  }

  Container _bottomNavBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: AdaptSize.pixel12,
        right: AdaptSize.pixel12,
        bottom: AdaptSize.pixel16,
      ),
      height: AdaptSize.screenWidth / 1000 * 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.primary300,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Consumer<MenuViewModel>(
        builder: (context, value, child) {
          return BottomNavigationBar(
            elevation: 0,
            backgroundColor: MyColor.transparanColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: MyColor.primary900,
            unselectedItemColor: MyColor.primary700,
            selectedIconTheme: IconThemeData(size: AdaptSize.pixel22),
            selectedLabelStyle: TextStyle(fontSize: AdaptSize.pixel12),
            unselectedFontSize: AdaptSize.pixel10,
            onTap: (index) {
              value.onTapped = index;
            },
            currentIndex: value.currentIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
