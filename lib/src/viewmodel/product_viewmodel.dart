import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';

class ProductViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchAllData() async {
    try {
      debugPrint('fetch data..');
      var snapShot = await _firestore.collection('productMitra').get();
      _items = snapShot.docs.map((document) => document.data()).toList();
      _filteredItems = _items;
      _allListProduct = _items;
      debugPrint(_allListProduct.length.toString());
      debugPrint(_filteredItems.toString());
      debugPrint('fetch data success !');
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data gagal !');
    }
  }

  List<Map<String, dynamic>> _allListProduct = [];

  List<Map<String, dynamic>> get allListProduct => _allListProduct;


  /// filter list
  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _filteredItems = [];
  List<String> _filters = [];

  List<Map<String, dynamic>> get items => _filteredItems;

  List<String> get filters => _filters;

  set filters(List<String> value) {
    _filters = value;
    _filteredItems = _items
        .where((item) => _filters.any((filter) =>
            item['sellerName'].toLowerCase().contains(filter.toLowerCase()) ||
            item['productName'].toLowerCase().contains(filter.toLowerCase()) ||
            item['productLocation']
                .toLowerCase()
                .contains(filter.toLowerCase())))
        .toList();
    notifyListeners();
  }

  set items(List<Map<String, dynamic>> value) {
    _items = value;
    _filteredItems = value;
    notifyListeners();
  }

  /// ------------------------------------------------------------------------
  /// wishlist

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

  void remove(UserWishlistModel item) {
    productWishlist.remove(item);
    notifyListeners();
  }
}
