import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

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
      return error = e.message!;
    }
  }

  /// add wishlist
  Future<void> addToWishList({
    required String productId,
    required String uid,
    required String productName,
    required String productImage,
    required List productGridImage,
    required String productDescrtiption,
    required String productLocation,
    required String productBenefit,
    required String productPrice,
    required List productCategory,
    required String productRW,
    required String productRT,
    required String sellerName,
  }) async {
    try {
      String wishListId = const Uuid().v1();
     await  _firestore
          .collection('newUser')
          .doc(uid)
          .collection('wishlist')
          .doc(wishListId)
          .set({
        "uid": uid,
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "productGridImage": productGridImage,
        "productDescription": productDescrtiption,
        "productLocation": productLocation,
        "productBenefit": productBenefit,
        "productPrice": productPrice,
        "productCategory": productCategory,
        "productRW": productRW,
        "productRT": productRT,
        "sellerName": sellerName,
        "datePublished": DateTime.now(),
      });
    } on FirebaseException catch (e) {
      debugPrint(e.message!);
    }
  }

  /// fetch all Product
  Future<void> fetchAllProductData({
  required List<Map<String, dynamic>> items,
  required List<Map<String, dynamic>> filteredItems,
}) async {
    try {
      debugPrint('fetch data..');
      var snapShot = await _firestore.collection('productMitra').get();
      items = snapShot.docs.map((document) => document.data()).toList();
      filteredItems = items;
      debugPrint('fetch data success !');
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data gagal !');
    }
  }
}
