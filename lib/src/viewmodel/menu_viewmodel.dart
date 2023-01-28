import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/screen/menu/umkm/umkm_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/account/profile_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/home/home_screen.dart';
import 'package:kkn_siwalan/src/screen/menu/wishlist/wishlist_screen.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:kkn_siwalan/src/widget/custom_dialogs.dart';

class MenuViewModel with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final List<Widget> _pages = [
    const HomeScreen(),
    const UmkmScreen(),
    const WishlistScreen(),
    const ProfileScreen(),
  ];

  get pages => _pages[_currentIndex];

  set onTapped(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<bool> onWillPop(BuildContext context) async {
    if (_currentIndex > 0) {
      _currentIndex = 0;
      return Future(() => false);
    } else {
      bool exit = await CustomDialogs().customDialog(
            context: context,
            image: 'logout',
            title: 'Mau keluar aplikasi ?',
            textButton1: 'Batal',
            textButton2: 'Keluar',
            bgButton1: MyColor.danger400,
            bgButton2: MyColor.neutral900,
            onPress1: () {
              Navigator.pop(context, false);
            },
            onPress2: () {
              Navigator.pop(context, true);
            },
          ) ??
          false;
      if (exit) {
        exit = true;
        notifyListeners();
      }
      return Future(() => exit);
    }
  }
}
