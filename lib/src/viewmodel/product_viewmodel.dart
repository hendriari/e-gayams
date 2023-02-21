import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';

class ProductViewModel with ChangeNotifier {


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

  /// ------------------------------------------------------------------------
  /// grid product

  List listGridCategory = [
    ['assets/grid_category/makanan_ringan.png', 'Makanan Ringan'],
    ['assets/grid_category/makanan.png', 'Makanan'],
    ['assets/grid_category/minuman.png', 'Minuman'],
    ['assets/grid_category/kesehatan.png', 'Kesehatan'],
    ['assets/grid_category/kecantikan.png', 'Kecantikan'],
    ['assets/grid_category/fashion.png', 'Fashion'],
    ['assets/grid_category/handycraft.png', 'Kerajinan Tangan'],
    ['assets/grid_category/any.png', 'Kategori Lainnya'],
  ];

  List<Map<String, dynamic>> filterByCategoryProduct = [];
}
