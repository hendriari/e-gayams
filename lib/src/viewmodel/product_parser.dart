import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/enums.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';

class ProductParsers extends ProductViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StateOfConnnection stateOfConnnection = StateOfConnnection.isDoingNothing;

  Future<void> fetchAllData() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch all data product..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .get();
      _items = snapShot.docs.map((document) => document.data()).toList();
      _filteredItems = _items;
      _allListProduct = _items;
      debugPrint(
          'total produk di kecamatan gayamsari ${_allListProduct.length}');
      debugPrint('total produk untuk filter ${_filteredItems.length}');
      debugPrint('fetch all data product success !');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// all product list
  List<Map<String, dynamic>> _allListProduct = [];

  List<Map<String, dynamic>> get allListProduct => _allListProduct;

  /// -------------------------------------------------------------------------
  /// filter search product list
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

  /// -----------------------------------------------------------------------
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
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kelurahan Siwalan..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Siwalan')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanSiwalan = _productByLocation;
      debugPrint('total produk kelurahan siwalan ${_kelurahanSiwalan.length}');
      debugPrint('fetch data product Kelurahan Siwalan success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Siwalan gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan siwalan
  Future<void> fetchProductKelurahanGayamsari() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kelurahan Gayamsari..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Gayamsari')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanGayamsari = _productByLocation;
      debugPrint(
          'total produk kelurahan gayamsari ${_kelurahanGayamsari.length}');
      debugPrint('fetch data product Kelurahan Gayamsari success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Gayamsari gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Sambirejo
  Future<void> fetchProductKelurahanSambirejo() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kelurahan Sambirejo..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Sambirejo')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanSambirejo = _productByLocation;
      debugPrint(
          'total produk kelurahan sambirejo ${_kelurahanSambirejo.length}');
      debugPrint('fetch data product Kelurahan Sambirejo success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Sambirejo gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Sambirejo
  Future<void> fetchProductKelurahanPandeanLamper() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kelurahan Pandean Lamper..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Pandean Lamper')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanPandeanLamper = _productByLocation;
      debugPrint(
          'total produk kelurahan pandean lamper ${_kelurahanPandeanLamper.length}');
      debugPrint('fetch data product Kelurahan Pandean Lamper success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Pandean Lamper gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Sawah Besar
  Future<void> fetchProductKelurahanSawahBesar() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kelurahan Sawah Besar..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Sawah Besar')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanSawahBesar = _productByLocation;
      debugPrint(
          'total produk kelurahan sawah besar ${_kelurahanSawahBesar.length}');
      debugPrint('fetch data product Kelurahan Sawah Besar success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Sawah Besar gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Tambakrejo
  Future<void> fetchProductKelurahanTambakrejo() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kelurahan Tambakrejo..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Tambakrejo')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanTambakRejo = _productByLocation;
      debugPrint(
          'total produk kelurahan tambakrejo ${_kelurahanTambakRejo.length}');
      debugPrint('fetch data product Kelurahan Tambakrejo success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Tambakrejo gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kelurahan Kaligawe
  Future<void> fetchProductKelurahanKaligawe() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kelurahan Kaligawe..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('locationKelurahan', isEqualTo: 'Kel. Kaligawe')
          .get();
      _productByLocation =
          snapShot.docs.map((document) => document.data()).toList();
      _kelurahanKaligawe = _productByLocation;
      debugPrint(
          'total produk kelurahan kaligawe ${_kelurahanKaligawe.length}');
      debugPrint('fetch data product Kelurahan Kaligawe success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kelurahan Kaligawe gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  // Future<void> fetchAllProductByKelurahan() async {
  //   stateOfConnnection = StateOfConnnection.isStart;
  //   notifyListeners();
  //   try {
  //     stateOfConnnection = StateOfConnnection.isLoading;
  //     notifyListeners();
  //     if (_kelurahanSiwalan.isEmpty ||
  //         _kelurahanGayamsari.isEmpty ||
  //         _kelurahanSambirejo.isEmpty ||
  //         _kelurahanPandeanLamper.isEmpty ||
  //         _kelurahanSawahBesar.isEmpty ||
  //         _kelurahanTambakRejo.isEmpty ||
  //         _kelurahanKaligawe.isEmpty) {
  //       fetchProductKelurahanSiwalan();
  //       fetchProductKelurahanGayamsari();
  //       fetchProductKelurahanSambirejo();
  //       fetchProductKelurahanPandeanLamper();
  //       fetchProductKelurahanSawahBesar();
  //       fetchProductKelurahanTambakrejo();
  //       fetchProductKelurahanKaligawe();
  //       fetchProductByCategory();
  //     }
  //     stateOfConnnection = StateOfConnnection.isReady;
  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     stateOfConnnection = StateOfConnnection.isFailed;
  //     notifyListeners();
  //   }
  // }

  /// -------------------------------------------------------------------------
  /// product by category
  ///

  late String category;

  List<Map<String, dynamic>> _listOfProductCategory = [];

  List<Map<String, dynamic>> get listOfProductCategory =>
      _listOfProductCategory;

  List<Map<String, dynamic>> _listMakananRingan = [];

  List<Map<String, dynamic>> get listMakananRingan => _listMakananRingan;

  List<Map<String, dynamic>> _listMakanan = [];

  List<Map<String, dynamic>> get listMakanan => _listMakanan;

  List<Map<String, dynamic>> _listMinuman = [];

  List<Map<String, dynamic>> get listMinuman => _listMinuman;

  List<Map<String, dynamic>> _listKesehatan = [];

  List<Map<String, dynamic>> get listKesehatan => _listKesehatan;

  List<Map<String, dynamic>> _listKecantikan = [];

  List<Map<String, dynamic>> get listKecantikan => _listKecantikan;

  List<Map<String, dynamic>> _listFashion = [];

  List<Map<String, dynamic>> get listFashion => _listFashion;

  List<Map<String, dynamic>> _listKerajinanTangan = [];

  List<Map<String, dynamic>> get listKerajinanTangan => _listKerajinanTangan;

  List<Map<String, dynamic>> _listKategoriLainnya = [];

  List<Map<String, dynamic>> get listKategoriLainnya => _listKategoriLainnya;

  /// fetch product kategori makanan ringan
  Future<void> fetchProductMakananRingan() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Makanan Ringan..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('productCategory', isEqualTo: 'Makanan Ringan')
          .get();
      _listMakananRingan =
          snapShot.docs.map((document) => document.data()).toList();
      debugPrint(
          'total produk kelurahan makanan ringan ${_listMakananRingan.length}');
      debugPrint('fetch data product Makanan ringan success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product makanan ringan gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kategori makanan
  Future<void> fetchProductMakanan() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Makanan..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('productCategory', isEqualTo: 'Makanan')
          .get();
      _listMakanan = snapShot.docs.map((document) => document.data()).toList();
      debugPrint('total produk makanan ${_listMakanan.length}');
      debugPrint('fetch data product makanan success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Makanan gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kategori makanan
  Future<void> fetchProductMinuman() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Minuman..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('productCategory', isEqualTo: 'Minuman')
          .get();
      _listMinuman = snapShot.docs.map((document) => document.data()).toList();
      debugPrint('total produk Minuman ${_listMinuman.length}');
      debugPrint('fetch data product Minuman success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Minuman gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kategori kesehatan
  Future<void> fetchProductKesehatan() async {
    stateOfConnnection = StateOfConnnection.isReady;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kesehatan..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('productCategory', isEqualTo: 'Kesehatan')
          .get();
      _listKesehatan =
          snapShot.docs.map((document) => document.data()).toList();
      debugPrint('total produk Kesehatan ${_listKesehatan.length}');
      debugPrint('fetch data product Kesehatan success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kesehatan gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kategori kecantikan
  Future<void> fetchProductKecantikan() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kecantikan..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('productCategory', isEqualTo: 'Kecantikan')
          .get();
      _listKecantikan =
          snapShot.docs.map((document) => document.data()).toList();
      debugPrint('total produk Kecantikan ${_listKecantikan.length}');
      debugPrint('fetch data product Kecantikan success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kecantikan gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kategori fashion
  Future<void> fetchProductFashion() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Fashion..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('productCategory', isEqualTo: 'Fashion')
          .get();
      _listFashion = snapShot.docs.map((document) => document.data()).toList();
      debugPrint('total produk Fashion ${_listFashion.length}');
      debugPrint('fetch data product Fashion success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kecantikan gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kategori kerajinan tangan
  Future<void> fetchProductKerajinanTangan() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kerajinan Tangan..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('productCategory', isEqualTo: 'Kerajinan Tangan')
          .get();
      _listKerajinanTangan =
          snapShot.docs.map((document) => document.data()).toList();
      debugPrint(
          'total produk Kerajinan Tangan ${_listKerajinanTangan.length}');
      debugPrint('fetch data product Kerajinan Tangan success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kerajinan Tangan gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// fetch product kategori kategori lainnya
  Future<void> fetchProductKategoriLainnya() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch data product Kategori Lainnya..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .where('productCategory', isEqualTo: 'Kategori Lainnya')
          .get();
      _listKategoriLainnya =
          snapShot.docs.map((document) => document.data()).toList();
      debugPrint(
          'total produk Kategori Lainnya ${_listKategoriLainnya.length}');
      debugPrint('fetch data product Kategori Lainnya success!');
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data product Kerajinan Tangan gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// refressh product category
  Future<void> refreshProductCategory({
    required List<Map<String, dynamic>> listOfCategory,
  }) async {
    _listOfProductCategory = listOfCategory;
    notifyListeners();
  }

  /// fetch all product by category
  Future<void> fetchProductByCategory() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      if (_listMakananRingan.isEmpty ||
          _listMakanan.isEmpty ||
          _listMinuman.isEmpty ||
          _listKesehatan.isEmpty ||
          _listKecantikan.isEmpty ||
          _listFashion.isEmpty ||
          _listKerajinanTangan.isEmpty ||
          _listKategoriLainnya.isEmpty) {
        fetchProductMakananRingan();
        fetchProductMakanan();
        fetchProductMinuman();
        fetchProductKesehatan();
        fetchProductKecantikan();
        fetchProductFashion();
        fetchProductKerajinanTangan();
        fetchProductKategoriLainnya();
      }
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }
}
