import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/services/firebase_auth.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan/src/widget/response_dialog.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
    required BuildContext context,
    required String email,
    required String password,
    required String username,
    required String jenisKelamin,
    required String alamat,
    required String rt,
    required String rw,
  }) async {
    _buttonRegisterLoading = true;
    context.loaderOverlay.show();
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
      Future.delayed(Duration.zero, () {
        ResponseDialog.customResponseDialog(
          context: context,
          height: AdaptSize.screenWidth / 1000 * 650,
          width: AdaptSize.screenWidth / 1000 * 500,
          description: 'Register berhasil !',
          image: 'success',
        );
        Future.delayed(const Duration(seconds: 2), () {
          NavigasiViewModel().navigateToLogin(context);
        });
        context.loaderOverlay.hide();
      });
      _buttonRegisterLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      ResponseDialog.customResponseDialog(
        context: context,
        height: AdaptSize.screenWidth / 1000 * 650,
        width: AdaptSize.screenWidth / 1000 * 800,
        description: e.message!,
        image: 'error',
      );
      debugPrint(e.message!);
      _buttonRegisterLoading = false;
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  /// login
  Future<void> userLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    _loginLoading = !_loginLoading;
    context.loaderOverlay.show();
    notifyListeners();
    try {
      await FirebaseAuthServices().login(
        email: email,
        password: password,
      );
      debugPrint('login success, waiting check user role');

      /// check user role
      try {
        User currentUser = FirebaseAuth.instance.currentUser!;

        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('newUser')
                .doc(currentUser.uid)
                .get();

        String role = snapshot.data()!['role'];
        if (role == 'endUser') {
          Future.delayed(Duration.zero, () {
            ResponseDialog.customResponseDialog(
              context: context,
              height: AdaptSize.screenWidth / 1000 * 500,
              width: AdaptSize.screenWidth / 1000 * 500,
              description: 'Login berhasil',
              image: 'success',
            );
            debugPrint(
                'check user role complete : ${currentUser.email}, role : $role');
            _loginLoading = false;
            context.loaderOverlay.hide();
          });
          Future.delayed(const Duration(milliseconds: 1530), () {
            NavigasiViewModel().navigasiMenuScreen(context);
          });
          notifyListeners();
        } else {
          Future.delayed(Duration.zero, () {
            ResponseDialog.customResponseDialog(
              context: context,
              height: AdaptSize.screenWidth / 1000 * 700,
              width: AdaptSize.screenWidth / 1000 * 800,
              description: 'Akun ini sudah terdaftar sebagai Mitra',
              image: 'error',
            );
            FirebaseAuthServices().logOut();
            _loginLoading = false;
            context.loaderOverlay.hide();
          });
          notifyListeners();
        }
      } on FirebaseException catch (e) {
        Future.delayed(Duration.zero, () {
          ResponseDialog.customResponseDialog(
            context: context,
            height: AdaptSize.screenWidth / 1000 * 700,
            width: AdaptSize.screenWidth / 1000 * 800,
            description: e.message!,
            image: 'error',
          );
          debugPrint(e.message!);
          _loginLoading = false;
          context.loaderOverlay.hide();
        });
      }
      _loginLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      ResponseDialog.customResponseDialog(
        context: context,
        height: AdaptSize.screenWidth / 1000 * 700,
        width: AdaptSize.screenWidth / 1000 * 800,
        description: e.message!,
        image: 'error',
      );
      debugPrint(e.message!);
      context.loaderOverlay.hide();
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
