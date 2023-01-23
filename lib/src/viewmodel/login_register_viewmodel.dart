import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/services/firebase_auth.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/response_dialog.dart';

class LoginRegisterViewModel with ChangeNotifier {
  bool _visiblePasswordLogin = true;
  bool _visiblePasswordRegister = true;
  bool _visibleConfirmPasswordRegister = true;

  bool get visiblePasswordLogin => _visiblePasswordLogin;

  bool get visiblePasswordRegister => _visiblePasswordRegister;

  bool get visibleConfirmPassword => _visibleConfirmPasswordRegister;

  void visibleLogin() {
    _visiblePasswordLogin = !_visiblePasswordLogin;
    notifyListeners();
  }

  void visibleRegister() {
    _visiblePasswordRegister = !_visiblePasswordRegister;
    notifyListeners();
  }

  void visibleConfrimRegister() {
    _visibleConfirmPasswordRegister = !_visibleConfirmPasswordRegister;
    notifyListeners();
  }

  bool _buttonRegisterLoading = false;

  bool get buttonRegisterLoading => _buttonRegisterLoading;

  bool _loginLoading = false;

  bool get loginLoading => _loginLoading;

  /// create users register
  Future<void> createUsers({
    context,
    required String email,
    required String password,
    required String username,
    required String jenisKelamin,
    required String alamat,
    required String rt,
    required String rw,
  }) async {
    _buttonRegisterLoading = true;
    notifyListeners();
    try {
      await FirebaseAuthServices().registerUser(
        email: email,
        password: password,
        username: username,
        jenisKelamin: jenisKelamin,
        alamat: alamat,
        rt: rt,
        rw: rw,
      );
      _buttonRegisterLoading = false;
      notifyListeners();
      ResponseDialog.customResponseDialog(
        context: context,
        height: AdaptSize.screenWidth / 1000 * 500,
        width: AdaptSize.screenWidth / 1000 * 500,
        description: 'Register berhasil !',
        image: 'smile',
      );
      Future.delayed(const Duration(seconds: 2), () {
        NavigasiViewModel().navigateToLogin(context);
      });
    } on FirebaseAuthException catch (e) {
      ResponseDialog.customResponseDialog(
        context: context,
        height: AdaptSize.screenWidth / 1000 * 650,
        width: AdaptSize.screenWidth / 1000 * 800,
        description: e.toString(),
        image: 'crying',
      );
      _buttonRegisterLoading = false;
      notifyListeners();
    }
  }

  /// login
  Future<void> userLogin({
    context,
    required String email,
    required String password,
  }) async {
    _loginLoading = !_loginLoading;
    notifyListeners();
    try {
      await FirebaseAuthServices().login(
        email: email,
        password: password,
      );
      _loginLoading = false;
      notifyListeners();
      ResponseDialog.customResponseDialog(
        context: context,
        height: AdaptSize.screenWidth / 1000 * 500,
        width: AdaptSize.screenWidth / 1000 * 500,
        description: 'Login berhasil',
        image: 'smile',
      );
      Future.delayed(const Duration(seconds: 2), () {
        NavigasiViewModel().navigasiMenuScreen(context);
      });
    } on FirebaseAuthException catch (e) {
      ResponseDialog.customResponseDialog(
        context: context,
        height: AdaptSize.screenWidth / 1000 * 650,
        width: AdaptSize.screenWidth / 1000 * 800,
        description: e.toString(),
        image: 'crying',
      );
      _loginLoading = false;
      notifyListeners();
    }
  }

  /// logout
  void signout(BuildContext context) {
    FirebaseAuthServices().logOut();
    Future.delayed(Duration.zero, () {
      NavigasiViewModel().navigasiLogout(context);
    });
  }
}
