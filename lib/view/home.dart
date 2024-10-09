import 'package:flutter/material.dart';
import 'package:kip_shooping/controller/product_controller.dart';
import 'package:kip_shooping/model/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productController = ProductController();
  bool isLoading = true;
  List<bool> boolList = [];

  @override
  initState() {
    productController.getProductData().whenComplete(() {
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: productController.productListData.length,
                  itemBuilder: (context, index) {
                    boolList = List.generate(
                      productController.productListData.length,
                      (index) {
                        return false;
                      },
                    );
                    ProductModel product =
                        productController.productListData[index];
                    print("product - $product");
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.all(
                                  10.0,
                                ),
                                child: Text(
                                  product.id.toString(),
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )),
                            Image.network(
                              product.images[0],
                              height: 250,
                              width: 250,
                            ),
                          ],
                        ),
                        Text(
                          product.title,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text("Price : ${product.price}"),
                        Text(
                          "Description : ${product.description}",
                          textAlign: TextAlign.center,
                        )
                      ],
                    );
                  })),
    );
  }
}
