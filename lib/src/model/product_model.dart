class ProductModel {
  String productId;
  String productName;
  String productImage;
  List productGridImage;
  String productDescrtiption;
  String productLocation;
  List productBenefit;
  int productPrice;
  List productCategory;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productGridImage,
    required this.productDescrtiption,
    required this.productLocation,
    required this.productBenefit,
    required this.productPrice,
    required this.productCategory,
  });
}
