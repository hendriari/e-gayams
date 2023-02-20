import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';
import 'package:kkn_siwalan/src/utils/enums.dart';

class ProductViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StateOfConnnection stateOfConnnection = StateOfConnnection.doNothing;

  Future<void> fetchAllData() async {
    stateOfConnnection = StateOfConnnection.isLoading;
    notifyListeners();
    try {
      debugPrint('fetch data..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .get();
      _items = snapShot.docs.map((document) => document.data()).toList();
      _filteredItems = _items;
      _allListProduct = _items;
      debugPrint(_allListProduct.length.toString());
      debugPrint(_filteredItems.toString());
      debugPrint('fetch data success !');
      stateOfConnnection = StateOfConnnection.success;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data gagal !');
      stateOfConnnection = StateOfConnnection.failed;
      notifyListeners();
    }
  }

  /// ----------------------------------------------------------------------
  /// index dot indicator carousel home screen
  int _indexSlider = 0;

  int get indexSlider => _indexSlider;

  /// index carousel slider
  void changeIndex({
    required int index,
  }) {
    _indexSlider = index;
    notifyListeners();
  }

  List<Map<String, dynamic>> _allListProduct = [];

  List<Map<String, dynamic>> get allListProduct => _allListProduct;

  ///--------------------------------------------------------------------------

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

  /// -------------------------------------------------------------------------
  /// product by location kelurahan

  List<Map<String, dynamic>> _productByLocation = [];

  List<Map<String, dynamic>> _kelurahanSiwalan = [];

  List<Map<String, dynamic>> get kelurahanSiwalan => _kelurahanSiwalan;

  List<Map<String, dynamic>> _kelurahanGayamsari = [];

  List<Map<String, dynamic>> get kelurahanGayamsari => _kelurahanGayamsari;

  List<Map<String, dynamic>> _kelurahanSambirejo = [];

  List<Map<String, dynamic>> get kelurahanSambirejo => _kelurahanSambirejo;

  List<Map<String, dynamic>> _kelurahanPandeanLamper = [];

  List<Map<String, dynamic>> get kelurahanPandeanLamper =>
      _kelurahanPandeanLamper;

  List<Map<String, dynamic>> _kelurahanSawahBesar = [];

  List<Map<String, dynamic>> get kelurahanSawahBesar => _kelurahanSawahBesar;

  List<Map<String, dynamic>> _kelurahanTambakRejo = [];

  List<Map<String, dynamic>> get kelurahanTambakRejo => _kelurahanTambakRejo;

  List<Map<String, dynamic>> _kelurahanKaligawe = [];

  List<Map<String, dynamic>> get kelurahanKaligawe => _kelurahanKaligawe;

  /// fetch product kelurahan siwalan
  Future<void> fetchProductKelurahanSiwalan() async {
    stateOfConnnection = StateOfConnnection.isLoading;
    notifyListeners();
    try {
      debugPrint('fetch data product Kelurahan Siwalan..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Siwalan')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanSiwalan = _productByLocation;
      debugPrint(_kelurahanSiwalan.toString());
      debugPrint('fetch data product Kelurahan Siwalan success!');
      stateOfConnnection = StateOfConnnection.success;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Siwalan gagal !');
      stateOfConnnection = StateOfConnnection.failed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan siwalan
  Future<void> fetchProductKelurahanGayamsari() async {
    stateOfConnnection = StateOfConnnection.isLoading;
    notifyListeners();
    try {
      debugPrint('fetch data product Kelurahan Gayamsari..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Gayamsari')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanGayamsari = _productByLocation;
      debugPrint(_kelurahanGayamsari.toString());
      debugPrint('fetch data product Kelurahan Gayamsari success!');
      stateOfConnnection = StateOfConnnection.success;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Gayamsari gagal !');
      stateOfConnnection = StateOfConnnection.failed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Sambirejo
  Future<void> fetchProductKelurahanSambirejo() async {
    stateOfConnnection = StateOfConnnection.isLoading;
    notifyListeners();
    try {
      debugPrint('fetch data product Kelurahan Sambirejo..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Sambirejo')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanSambirejo = _productByLocation;
      debugPrint(_kelurahanSambirejo.toString());
      debugPrint('fetch data product Kelurahan Sambirejo success!');
      stateOfConnnection = StateOfConnnection.success;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Sambirejo gagal !');
      stateOfConnnection = StateOfConnnection.failed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Sambirejo
  Future<void> fetchProductKelurahanPandeanLamper() async {
    stateOfConnnection = StateOfConnnection.isLoading;
    notifyListeners();
    try {
      debugPrint('fetch data product Kelurahan Pandean Lamper..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Pandean Lamper')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanPandeanLamper = _productByLocation;
      debugPrint(_kelurahanPandeanLamper.toString());
      debugPrint('fetch data product Kelurahan Pandean Lamper success!');
      stateOfConnnection = StateOfConnnection.success;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Pandean Lamper gagal !');
      stateOfConnnection = StateOfConnnection.failed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Sawah Besar
  Future<void> fetchProductKelurahanSawahBesar() async {
    stateOfConnnection = StateOfConnnection.isLoading;
    notifyListeners();
    try {
      debugPrint('fetch data product Kelurahan Sawah Besar..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Sawah Besar')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanSawahBesar = _productByLocation;
      debugPrint(_kelurahanSawahBesar.toString());
      debugPrint('fetch data product Kelurahan Sawah Besar success!');
      stateOfConnnection = StateOfConnnection.success;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Sawah Besar gagal !');
      stateOfConnnection = StateOfConnnection.failed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Tambakrejo
  Future<void> fetchProductKelurahanTambakrejo() async {
    stateOfConnnection = StateOfConnnection.isLoading;
    notifyListeners();
    try {
      debugPrint('fetch data product Kelurahan Tambakrejo..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Tambakrejo')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanTambakRejo = _productByLocation;
      debugPrint(_kelurahanTambakRejo.toString());
      debugPrint('fetch data product Kelurahan Tambakrejo success!');
      stateOfConnnection = StateOfConnnection.success;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Tambakrejo gagal !');
      stateOfConnnection = StateOfConnnection.failed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Kaligawe
  Future<void> fetchProductKelurahanKaligawe() async {
    stateOfConnnection = StateOfConnnection.isLoading;
    notifyListeners();
    try {
      debugPrint('fetch data product Kelurahan Kaligawe..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Kaligawe')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanKaligawe = _productByLocation;
      debugPrint(_kelurahanKaligawe.toString());
      debugPrint('fetch data product Kelurahan Kaligawe success!');
      stateOfConnnection = StateOfConnnection.success;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Kaligawe gagal !');
      stateOfConnnection = StateOfConnnection.failed;
      notifyListeners();
    }
  }
}
