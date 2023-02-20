import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/viewmodel/menu_viewmodel.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final int currentIndex;

  const MenuScreen({
    Key? key,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      context.read<MenuViewModel>().menuIndex(index: widget.currentIndex);
    });
  }

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
        left: AdaptSize.pixel6,
        right: AdaptSize.pixel6,
        bottom: AdaptSize.pixel6,
      ),
      height: AdaptSize.screenWidth / 1000 * 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.primary300,
        borderRadius: BorderRadius.circular(35),
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
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'UMKM',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmarks_outlined),
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
