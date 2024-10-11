import 'package:flutter/foundation.dart';

class ProductModel {
  int id;
  String title;
  String description;
  double price;
  List<dynamic> images;
  String category;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.images,
      required this.category});
}

List<ProductModel> mapToJson(List<dynamic> json) {
  List<ProductModel> productModelList = [];
  for (Map<String, dynamic> product in json) {
    ProductModel eachProduct = ProductModel(
        id: product['id'],
        title: product['title'],
        description: product['description'],
        price: product['price'],
        images: product['images'],
        category: product['category']);

    productModelList.add(eachProduct);
  }
  return productModelList;
}
