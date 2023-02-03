import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';

class ProductViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> productStream =
      FirebaseFirestore.instance.collection('productMitra').snapshots();

  final List<UserWishlistModel> productWishlist = [];

  void addProductWishList(UserWishlistModel wishlist) {
    onTaped = true;
    productWishlist.add(wishlist);
    notifyListeners();
  }

  late bool onTaped = false;

  /// delete list
  void removeWhislistOffice(int index) {
    onTaped = false;
    productWishlist.removeAt(index);
    notifyListeners();
  }
}
