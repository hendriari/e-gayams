import 'package:loader_overlay/loader_overlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';
import 'package:kkn_siwalan/src/utils/enums.dart';
import 'package:kkn_siwalan/src/viewmodel/product_viewmodel.dart';

class ProductParsers extends ProductViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StateOfConnnection stateOfConnnection = StateOfConnnection.isDoingNothing;

  List<ProductModel> _listOfAllProduct = [];

  List<ProductModel> get listOfAllProduct => _listOfAllProduct;

  Future<void> fetchAllProductData() async {
    stateOfConnnection = StateOfConnnection.isStart;
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('fetch all data product data baru..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .get();
      _listOfAllProduct =
          snapShot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      debugPrint('fetch all data data baru success !');
      filterProductByLocation();
      filterProductByCategory();
      stateOfConnnection = StateOfConnnection.isReady;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('fetch data baru gagal !');
      stateOfConnnection = StateOfConnnection.isFailed;
      notifyListeners();
    }
  }

  /// -------------------------------------------------------------------------

  /// filter product by product id
  ProductModel? productModelFilterByProductId({
    required List<ProductModel> listOfProductModel,
    required String requestedProductId,
  }) {
    ProductModel? tempModels;
    for (var element in listOfAllProduct) {
      if (element.productId == requestedProductId) {
        debugPrint("parse berhasil");

        tempModels = element;
      }
    }
    return tempModels;
  }

  /// -------------------------------------------------------------------------
  /// filter product by keywoard
  List<ProductModel> _foundProduct = [];

  List<ProductModel> get foundProduct => _foundProduct;

  /// filter product to list for search product
  void filterProductByKeyword({
    required String keyword,
  }) {
    List<ProductModel> result = [];
    result = _listOfAllProduct
        .where((product) =>
            product.sellerName.toLowerCase().contains(keyword.toLowerCase()) ||
            product.productName.toLowerCase().contains(keyword.toLowerCase()) ||
            product.productCategory
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            product.productLocation
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList();

    result.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _foundProduct = result;
    notifyListeners();
  }

  ///--------------------------------------------------------------------------
  /// filter product by kelurahan

  List<ProductModel> _kelurahanSiwalan = [];

  List<ProductModel> get kelurahanSiwalan => _kelurahanSiwalan;

  /// kelurahan siwalan
  void filterProductByKelurahanSiwalan() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.locationKelurahan
            .toLowerCase()
            .contains('Kel. Siwalan'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _kelurahanSiwalan = results;
    debugPrint(
        'total produk kelurahan siwalan : ${_kelurahanSiwalan.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _kelurahanGayamsari = [];

  List<ProductModel> get kelurahanGayamsari => _kelurahanGayamsari;

  /// kelurahan gayamsari
  void filterProductByKelurahanGayamsari() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.locationKelurahan
            .toLowerCase()
            .contains('Kel. Gayamsari'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _kelurahanGayamsari = results;
    debugPrint(
        'total produk kelurahan gayamsari : ${_kelurahanGayamsari.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _kelurahanSambirejo = [];

  List<ProductModel> get kelurahanSambirejo => _kelurahanSambirejo;

  /// kelurahan sambirejo
  void filterProductByKelurahanSambirejo() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.locationKelurahan
            .toLowerCase()
            .contains('Kel. Sambirejo'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _kelurahanSambirejo = results;
    debugPrint(
        'total produk kelurahan sambirejo : ${_kelurahanSambirejo.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _kelurahanPandeanLamper = [];

  List<ProductModel> get kelurahanPandeanLamper => _kelurahanPandeanLamper;

  /// kelurahan pandean lamper
  void filterProductByKelurahanPandeanLamper() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.locationKelurahan
            .toLowerCase()
            .contains('Kel. Pandean Lamper'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _kelurahanPandeanLamper = results;
    debugPrint(
        'total produk kelurahan pandean lamper : ${_kelurahanPandeanLamper.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _kelurahanSawahBesar = [];

  List<ProductModel> get kelurahanSawahBesar => _kelurahanSawahBesar;

  /// kelurahan sawah besar
  void filterProductByKelurahanSawahBesar() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.locationKelurahan
            .toLowerCase()
            .contains('Kel. Sawah Besar'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _kelurahanSawahBesar = results;
    debugPrint(
        'total produk kelurahan sawah besar: ${_kelurahanSawahBesar.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _kelurahanTambakRejo = [];

  List<ProductModel> get kelurahanTambakRejo => _kelurahanTambakRejo;

  /// kelurahan tambak rejo
  void filterProductByKelurahanTambakrejo() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.locationKelurahan
            .toLowerCase()
            .contains('Kel. Tambakrejo'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _kelurahanTambakRejo = results;
    debugPrint(
        'total produk kelurahan tambak rejo : ${_kelurahanTambakRejo.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _kelurahanKaligawe = [];

  List<ProductModel> get kelurahanKaligawe => _kelurahanKaligawe;

  /// kelurahan tambak rejo
  void filterProductByKelurahanKaligawe() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.locationKelurahan
            .toLowerCase()
            .contains('Kel. Kaligawe'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _kelurahanKaligawe = results;
    debugPrint(
        'total produk kelurahan kaligawe : ${_kelurahanKaligawe.length.toString()}');
    notifyListeners();
  }

  void filterProductByLocation() {
    filterProductByKelurahanSiwalan();
    filterProductByKelurahanGayamsari();
    filterProductByKelurahanSambirejo();
    filterProductByKelurahanPandeanLamper();
    filterProductByKelurahanSawahBesar();
    filterProductByKelurahanTambakrejo();
    filterProductByKelurahanKaligawe();
  }

  /// -------------------------------------------------------------------------
  /// product by category

  late String category;

  List<ProductModel> _listOfProductCategory = [];

  List<ProductModel> get listOfProductCategory => _listOfProductCategory;

  List<ProductModel> _listMakananRingan = [];

  List<ProductModel> get listMakananRingan => _listMakananRingan;

  /// makanan ringan
  void filterProductByMakananRingan() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.productCategory
            .toLowerCase()
            .contains('Makanan Ringan'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _listMakananRingan = results;
    debugPrint(
        'total produk Makanan Ringan : ${_listMakananRingan.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _listMakanan = [];

  List<ProductModel> get listMakanan => _listMakanan;

  /// filter makanan
  void filterProductByMakanan() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.productCategory
            .toLowerCase()
            .contains('Makanan'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _listMakanan = results;
    debugPrint('total produk Makanan : ${_listMakanan.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _listMinuman = [];

  List<ProductModel> get listMinuman => _listMinuman;

  /// filter minuman
  void filterProductByMinuman() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.productCategory
            .toLowerCase()
            .contains('Minuman'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _listMinuman = results;
    debugPrint('total produk Minuman : ${_listMinuman.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _listKesehatan = [];

  List<ProductModel> get listKesehatan => _listKesehatan;

  /// filter kesehatan
  void filterProductByKesehatan() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.productCategory
            .toLowerCase()
            .contains('Kesehatan'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _listKesehatan = results;
    debugPrint('total produk kesehatan : ${_listKesehatan.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _listKecantikan = [];

  List<ProductModel> get listKecantikan => _listKecantikan;

  /// filter kecantikan
  void filterProductByKecantikan() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.productCategory
            .toLowerCase()
            .contains('Kecantikan'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _listKecantikan = results;
    debugPrint(
        'total produk kecantikan : ${_listKecantikan.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _listFashion = [];

  List<ProductModel> get listFashion => _listFashion;

  /// filter fashion
  void filterProductByFashion() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.productCategory
            .toLowerCase()
            .contains('Fashion'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _listFashion = results;
    debugPrint('total produk fashion : ${_listFashion.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _listKerajinanTangan = [];

  List<ProductModel> get listKerajinanTangan => _listKerajinanTangan;

  /// filter kerajinan tangan
  void filterProductByKerajinanTangan() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.productCategory
            .toLowerCase()
            .contains('Kerajinan Tangan'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _listKerajinanTangan = results;
    debugPrint(
        'total produk kerajinan tangan : ${_listKerajinanTangan.length.toString()}');
    notifyListeners();
  }

  List<ProductModel> _listKategoriLainnya = [];

  List<ProductModel> get listKategoriLainnya => _listKategoriLainnya;

  /// filter kategori lainnya
  void filterProductByKategoriLainnya() {
    List<ProductModel> results = [];
    results = _listOfAllProduct
        .where((place) => (place.productCategory
            .toLowerCase()
            .contains('Kategori Lainnya'.toLowerCase())))
        .toList();

    results.sort((a, b) => DateTime.parse(b.datePublished.toDate().toString())
        .compareTo(DateTime.parse(a.datePublished.toDate().toString())));

    _listKategoriLainnya = results;
    debugPrint(
        'total produk kategori lainnya : ${_listKategoriLainnya.length.toString()}');
    notifyListeners();
  }

  /// refresh product category
  Future<void> refreshProductCategory({
    required List<ProductModel> listOfCategory,
  }) async {
    _listOfProductCategory = listOfCategory;
    notifyListeners();
  }

  void filterProductByCategory() {
    filterProductByMakananRingan();
    filterProductByMakanan();
    filterProductByMinuman();
    filterProductByKesehatan();
    filterProductByKecantikan();
    filterProductByFashion();
    filterProductByKerajinanTangan();
    filterProductByKategoriLainnya();
  }

  /// ------------------------------------------------------------------------
  /// handle refresh function
  handleRefresh({
    required BuildContext context,
  }) async {
    stateOfConnnection = StateOfConnnection.isStart;
    context.loaderOverlay.show();
    notifyListeners();
    try {
      stateOfConnnection = StateOfConnnection.isLoading;
      notifyListeners();
      debugPrint('Refresh All Product..');
      var snapShot = await _firestore
          .collection('productMitra')
          .orderBy('datePublished', descending: true)
          .get();
      _listOfAllProduct =
          snapShot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      debugPrint('Refresh All Product Success !');
      filterProductByLocation();
      filterProductByCategory();
      stateOfConnnection = StateOfConnnection.isReady;
      Future.delayed(const Duration(milliseconds: 1500), () {
        context.loaderOverlay.hide();
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('Refresh All Product Failed !');
      stateOfConnnection = StateOfConnnection.isFailed;
      Future.delayed(const Duration(milliseconds: 1500), () {
        context.loaderOverlay.hide();
      });
      notifyListeners();
    }
  }
}
