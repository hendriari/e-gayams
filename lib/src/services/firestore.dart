import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// update user profile
  Future updateProfil({
    required BuildContext context,
    required String username,
    required String gender,
    required String alamat,
    required String rt,
    required String rw,
    String? error,
  }) async {
    try {
      await _firestore
          .collection('newUser')
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        'username': username,
        'jenisKelamin': gender,
        'alamat': alamat,
        'rt': rt,
        'rw': rw,
      });
    } on FirebaseException catch (e) {
      return error = e.toString();
    }
  }
}
