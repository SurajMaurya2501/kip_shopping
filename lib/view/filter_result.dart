import 'package:flutter/material.dart';
import 'package:kip_shooping/controller/product_controller.dart';
import 'package:kip_shooping/model/product_model.dart';
import 'package:kip_shooping/view/filter.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';

class FilterResult extends StatefulWidget {
  List<ProductModel> productDataList;
  List<String> selectedCategories;
  String searchText;
  FilterResult(
      {super.key,
      required this.productDataList,
      required this.selectedCategories,
      required this.searchText});

  @override
  State<FilterResult> createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {
  final productController = ProductController();
  final _controller = TextEditingController();
  List<bool> showDescriptionBool = [];
  bool isLoading = true;

  @override
  void initState() {
    productController
        .filterProduct(widget.selectedCategories, widget.productDataList,
            widget.searchText)
        .whenComplete(
      () {
        showDescriptionBool = List.generate(
          productController.filteredProduct.length,
          (index) => false,
        );
        isLoading = false;
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80.0),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(
                          0xFFF4F3FD,
                        ),
                        hintText: "Find Product",
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 25,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            print(productController.productListData);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FilterPage(
                                          productDataList:
                                              productController.filteredProduct,
                                        )));
                          },
                          icon: Image.asset(
                            "assets/images/filter.png",
                            height: 20,
                            width: 20,
                            color: Colors.grey,
                          ),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 50.0),
                    child: Text(
                      "Results",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      itemCount: productController.filteredProduct.length,
                      itemBuilder: (context, index) {
                        ProductModel product =
                            productController.filteredProduct[index];
                        return Card(
                          elevation: 10.0,
                          child: AnimatedSize(
                            duration: Duration(
                              milliseconds: 200,
                            ),
                            curve: Curves.easeInOut,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(15.0),
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      5.0,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.network(product.images[0]),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 20.0,
                                    top: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(
                                          product.title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      if (showDescriptionBool[index])
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            product.description,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              height: 1.1,
                                            ),
                                          ),
                                        ),
                                      GestureDetector(
                                        onTap: () {
                                          showDescriptionBool[index] =
                                              !showDescriptionBool[index];
                                          setState(() {});
                                        },
                                        child: Text(
                                          showDescriptionBool[index]
                                              ? "Hide Description"
                                              : "Show Description",
                                          style: TextStyle(
                                            color: blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${product.price.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
