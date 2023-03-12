import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/model/user_model.dart';
import 'package:kkn_siwalan/src/services/firebase_auth.dart';
import 'package:kkn_siwalan/src/services/firestore.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/response_dialog.dart';

class AccountViewModel with ChangeNotifier {

  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();

  UserModel? _userModel;

  UserModel? get usermodel => _userModel;

  Future refreshUsers() async {
    UserModel userModels = await _firebaseAuthServices.getUserDetail();
    _userModel = userModels;
    notifyListeners();
  }


  /// get user data from firestore
  final Stream<DocumentSnapshot<Map<String, dynamic>>> _userData =
  FirebaseFirestore.instance
      .collection('userPhase2')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  get userData => _userData;

  /// -------------------------------------------------------------------------

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
    required Future responseDialog,
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
      responseDialog;
      Future.delayed(const Duration(milliseconds: 1500), () {
        NavigasiViewModel().navigasiToMenuWithIndex(
          context: context,
          index: 3,
        );
      });
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

  void changePassword({
    required BuildContext context,
    required String email,
  }) {
    _saveLoading = !_saveLoading;
    notifyListeners();
    try {
      FirebaseAuthServices().changePassword(email: email);
      _saveLoading = false;
      ResponseDialog.responseInfoDialog(
        context: context,
        image: 'success.png',
        description: 'Cek email sekarang !',
      );
      notifyListeners();
    } on FirebaseException catch (e) {
      ResponseDialog.responseInfoDialog(
        context: context,
        image: 'error.png',
        description: e.message!,
      );
      _saveLoading = false;
      notifyListeners();
    }
  }
}
