import 'package:dio/dio.dart';
import 'package:kip_shooping/model/product_model.dart';

class ProductController {
  List<ProductModel> productListData = [];
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
        print("Data : $productListData");
      }
    } catch (e) {
      print("Error Occured While Fetching Data: $e");
    }
  }
}
