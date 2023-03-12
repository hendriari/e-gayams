import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:kkn_siwalan/src/model/user_model.dart';

class FirebaseAuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// register
  Future registerUser({
    required String email,
    required String password,
    required String username,
    required String jenisKelamin,
    required String alamat,
    required String rt,
    required String rw,
    required String nomorWhatsApp,
    required String kelurahan,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel = UserModel(
        uid: cred.user!.uid,
        username: username,
        email: email,
        jenisKelamin: jenisKelamin,
        alamat: alamat,
        rt: rt,
        rw: rw,
        role: 'endUser',
        nomorWhatsApp: nomorWhatsApp,
        kelurahan: kelurahan,
      );

      await _firestore
          .collection('userPhase2')
          .doc(cred.user!.uid)
          .set(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      return debugPrint(e.toString());
    }
  }

  /// login
  Future login({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// logout
  Future logOut() async {
    _auth.signOut();
  }

  /// reset password
  Future changePassword({
    required String email,
  }) async {
    _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  /// get user detail
  Future<UserModel> getUserDetail() async {
    User currentUser = FirebaseAuth.instance.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('userPhase2').doc(currentUser.uid).get();

    return UserModel.fromSnap(documentSnapshot);
  }
}
