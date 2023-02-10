import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';

class SearchProductViewModel with ChangeNotifier {
  // import 'package:model/order.dart';
  //
  // class OrderService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Stream<List<FilterProductModel>> fetchOrders(String productId) {
    return _db.collection('productMitra/$productId').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) =>
                FilterProductModel.fromSnap(document.data(), document.id))
            .toList());
  }
}

List<FilterProductModel> _filteringProduct = [];

get filteringProduct => _filteringProduct;

/// get all product
Stream<List<FilterProductModel>> getAllProduct({
  required String productId,
}) {
  // List<FilterProductModel> filter = [];
  var streamProduct = FirebaseFirestore.instance
      .collection('productMitra')
      .snapshots()
      .map((event) => event.docs
          .map((e) => FilterProductModel.fromSnap(e.data(), e.id))
          .toList());
  return streamProduct;
}

// void searchProduk({
//   required String keyword,
// }) {
//   FirebaseFirestore.instance
//       .collection('productMitra')
//       .where(
//     'productId',
//     isEqualTo: keyword,
//   )
//       .get();
// }}
