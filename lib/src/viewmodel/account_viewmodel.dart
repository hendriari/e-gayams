import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/services/firestore.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/widget/response_dialog.dart';

class AccountViewModel with ChangeNotifier {
  final List<String> _profileMenu = [
    'Edit Profile',
    'About',
    'Change Password',
    'Logout'
  ];

  final List<Widget> _iconsMenu = [
    Icon(
      Icons.person_outline_rounded,
      size: AdaptSize.pixel22,
    ),
    Icon(Icons.info_outline, size: AdaptSize.pixel22),
    Icon(CupertinoIcons.padlock, size: AdaptSize.pixel22),
    Icon(Icons.logout_outlined, size: AdaptSize.pixel22)
  ];

  List get profileMenu => _profileMenu;

  List get iconsMenu => _iconsMenu;

  bool _saveLoading = false;

  bool get saveLoading => _saveLoading;

  /// update profile
  Future updateUserData({
    required BuildContext context,
    required String username,
    required String gender,
    required String alamat,
    required String rt,
    required String rw,
  }) async {
    _saveLoading = !_saveLoading;
    notifyListeners();
    try {
      await FirestoreServices().updateProfil(
        context: context,
        username: username,
        gender: gender,
        alamat: alamat,
        rt: rt,
        rw: rw,
      );
      _saveLoading = false;
      ResponseDialog.responseInfoDialog(
        context: context,
        image: 'oke.png',
        description: 'Update Berhasil',
      );
      notifyListeners();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      _saveLoading = false;
      ResponseDialog.responseInfoDialog(
        context: context,
        image: 'cancel.png',
        description: e.toString(),
      );
    }
  }
}
