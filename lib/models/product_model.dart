import 'dart:ui';
//Not in use because using json format
class Product {
  List<Color>? productColors;
  String productId;
  String productName;
  String productDescription;
  List<String> productImages;
  double productPrice;
  String productCategory;
  String productStatus;

  Product({
    this.productColors,
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productImages,
    required this.productPrice,
    required this.productCategory,
    required this.productStatus,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productColors: (map['productColors'] as List<dynamic>?)
          ?.map((color) => Color(int.parse(color))).toList(),
      productId: map['ProductId'],
      productName: map['productName'],
      productDescription: map['productDescription'],
      productImages: (map['productImage'] as List<dynamic>).cast<String>(),
      productPrice: (map['productPrice'] as num).toDouble(),
      productCategory: map['productCategory'],
      productStatus: map['productStatus'],
    );
  }
}
