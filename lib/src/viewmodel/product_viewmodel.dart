import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';

class ProductViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> productStream =
      FirebaseFirestore.instance.collection('productMitra').snapshots();

  // Stream<QuerySnapshot<Map<String, dynamic>>> wishListStream =
  //     FirebaseFirestore.instance.collection('productMitra').doc('productId').snapshots();

  // List<Map<String, dynamic>> productList = [];
  //
  // search({
  //   required String query,
  // }) async {
  //   productList = await searchProduct(query: query);
  //   notifyListeners();
  // }
  //
  // Future<List<Map<String, dynamic>>> searchProduct({
  //   required String query,
  // }) async {
  //   QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
  //       .instance
  //       .collection('productMitra')
  //       .where('sellerName', isEqualTo: query)
  //       .where('productLocation', isEqualTo: query)
  //       .where('productRT', isEqualTo: query)
  //       .where('productRW', isEqualTo: query)
  //       .get();
  //   return response.docs.map((e) => e.data()).toList();
  // }
  //
  // List searchResult = [];
  //
  // void searchFromFirebase(String query) async {
  //   FirebaseFirestore.instance
  //       .collection('productMitra')
  //       .where('productName', isEqualTo: query);
  //   notifyListeners();
  // }

  final List<ProductModel> productWishlist = [];

  void addProductWishList(ProductModel productModel) {
    productWishlist.add(productModel);
    notifyListeners();
  }


}
