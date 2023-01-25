import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/model/product_model.dart';

class ProductDummyData with ChangeNotifier {
  List<ProductModel> _productModel = [];

  List<ProductModel> get productModel => _productModel;

  final Faker _faker = Faker();

  addDataDummy(int dataLength) {
    List<ProductModel> dataInstance = [];
    for (int i = 1; i <= dataLength; i++) {
      dataInstance.add(
        ProductModel(
          productId: i.toString(),
          productName: _faker.food.dish(),
          productImage: _faker.image.image(),
          productGridImage: [
            _faker.image.image(),
            _faker.image.image(),
            _faker.image.image(),
          ],
          productDescrtiption: _faker.lorem.sentence(),
          productLocation: _faker.address.country() + _faker.address.city(),
        ),
      );
    }
    _productModel = dataInstance;
  }
}
