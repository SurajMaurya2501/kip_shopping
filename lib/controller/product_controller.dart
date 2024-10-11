import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kip_shooping/model/product_model.dart';

class ProductController {
  List<ProductModel> productListData = [];
  List<ProductModel> filteredProduct = [];
  List<String> filterCategories = [];

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

  Future<void> filterProduct(
      List<String> categories,
      List<ProductModel> productDataList,
      String searchText,
      double startRange,
      double endRange) async {
    filterCategories.clear();
    filteredProduct.clear();
    if (searchText.isEmpty) {
      for (ProductModel product in productDataList) {
        if (filterCategory(product.category, categories) &&
            (product.price >= startRange && product.price <= endRange)) {
          filteredProduct.add(product);
          if (!filterCategories.contains(product.category)) {
            filterCategories.add(product.category);
          }
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
        if (!filterCategories.contains(product.category)) {
          filterCategories.add(product.category);
        }
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
