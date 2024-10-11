import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kip_shooping/model/product_model.dart';

class ProductController {
  List<ProductModel> productListData = [];
  List<ProductModel> filteredProduct = [];

  Future<void> getProductData() async {
    try {
      Response response = await Dio().getUri(
        Uri.parse(
          "https://dummyjson.com/products",
        ),
      );
      if (response.statusCode == 200) {
        print("Data Fetch Successfully!");
        dynamic tempData = response.data;
        List<dynamic> productData = tempData['products'];
        productListData = mapToJson(productData);
        // print("Data : $productListData");
      }
    } catch (e) {
      print("Error Occured While Fetching Data: $e");
    }
  }

  Future<void> filterProduct(List<String> categories,
      List<ProductModel> productDataList, String searchText) async {
    filteredProduct.clear();
    if (searchText.isEmpty) {
      for (ProductModel product in productDataList) {
        if (filterCategory(product.category, categories)) {
          filteredProduct.add(product);
        }
      }
    } else {
      searchProduct(searchText, productDataList);
    }

    log("FilteredProduct : $filteredProduct");
  }

  void searchProduct(String searchText, List<ProductModel> productDataList) {
    for (ProductModel product in productDataList) {
      if (product.title.contains(searchText)) {
        filteredProduct.add(product);
      }
    }
    print("Searched Result : $filteredProduct");
  }

  bool filterCategory(String productCategory, List<String> categories) {
    for (String category in categories) {
      if (category.contains(productCategory)) {
        return true;
      }
    }
    return false;
  }
}
