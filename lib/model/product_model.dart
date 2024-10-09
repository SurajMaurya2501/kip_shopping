import 'package:flutter/foundation.dart';

class ProductModel {
  int id;
  String title;
  String description;
  double price;
  List<dynamic> images;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.images});
}

List<ProductModel> mapToJson(List<dynamic> json) {
  List<ProductModel> productModelList = [];
  for (Map<String, dynamic> product in json) {
    ProductModel eachProduct = ProductModel(
        id: product['id'],
        title: product['title'],
        description: product['description'],
        price: product['price'],
        images: product['images']);

    productModelList.add(eachProduct);
  }
  return productModelList;
}
