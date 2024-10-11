import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kip_shooping/controller/product_controller.dart';
import 'package:kip_shooping/model/product_model.dart';
import 'package:kip_shooping/provider/filer_provider.dart';
import 'package:kip_shooping/provider/filter_result_provider.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:kip_shooping/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class FilterResult extends StatefulWidget {
  List<ProductModel> productDataList;
  List<String> selectedCategories;
  String searchText;
  double startRange;
  double endRange;

  FilterResult(
      {super.key,
      required this.productDataList,
      required this.selectedCategories,
      required this.searchText,
      required this.startRange,
      required this.endRange});

  @override
  State<FilterResult> createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {
  List<String> categories = [
    "beauty",
    "laptops",
    "skin-care",
    "smartphones",
    "sunglasses",
    "tablets",
    "womens-bags",
    "fragrances"
  ];
  final productController = ProductController();
  final _controller = TextEditingController();
  List<bool> showDescriptionBool = [];
  bool isLoading = true;
  double startValue = 0.0, endValue = 100.0;
  List<String> selectedCategories = [];

  @override
  void initState() {
    productController
        .filterProduct(widget.selectedCategories, widget.productDataList,
            widget.searchText, widget.startRange, widget.endRange)
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
                    margin: EdgeInsets.only(top: 40.0),
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      "assets/svg/eye.svg",
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onSubmitted: (value) {
                        productController.filterProduct(
                            categories,
                            widget.productDataList,
                            _controller.text.trim(),
                            startValue,
                            endValue);
                        showDescriptionBool = List.generate(
                          productController.filteredProduct.length,
                          (index) => false,
                        );
                        setState(() {});
                      },
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
                            _openBottomSheet(context, "categories");
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
                  Consumer<FilterResultProvider>(
                    builder: (context, value, child) {
                      return Container(
                        margin: EdgeInsets.only(
                          top: 10.0,
                        ),
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: productController.filterCategories.length > 0
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    productController.filterCategories.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: ChoiceChip(
                                        // side: const BorderSide(color: Colors.white),
                                        side: BorderSide(
                                          color: Colors.grey,
                                        ),
                                        showCheckmark: false,
                                        label: Text(
                                          productController
                                              .filterCategories[index],
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),

                                        selected: false,
                                        selectedColor: const Color(0XFF3D5CFF),
                                        backgroundColor: const Color.fromARGB(
                                            255, 152, 179, 252),
                                      ));
                                },
                              )
                            : Container(),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Results",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Expanded(
                    child: productController.filteredProduct.isEmpty
                        ? Center(
                            child: Text(
                              "No Result Found",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : Consumer<FilterResultProvider>(
                            builder: (context, value, child) {
                              return ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                shrinkWrap: true,
                                itemCount:
                                    productController.filteredProduct.length,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(15.0),
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                5.0,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Image.network(
                                                product.images[0]),
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.55,
                                                  child: Text(
                                                    product.title,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                if (showDescriptionBool[index])
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.0, bottom: 5.0),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.55,
                                                    child: Text(
                                                      product.description,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.1,
                                                      ),
                                                    ),
                                                  ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDescriptionBool[index] =
                                                        !showDescriptionBool[
                                                            index];
                                                    setState(() {});
                                                  },
                                                  child: Text(
                                                    showDescriptionBool[index]
                                                        ? "Hide Description"
                                                        : "Show Description",
                                                    style: TextStyle(
                                                      color: blue,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "\$${product.price.toString()}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: blue),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
    );
  }

  void _openBottomSheet(BuildContext currentContext, String category) {
    final provider = Provider.of<FilterProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            30.0,
          ),
        ), // Rounded top corners
      ),
      builder: (currentContext) {
        return DraggableScrollableSheet(
          initialChildSize:
              0.8, // The initial height of the bottom sheet (0.5 = half screen)
          minChildSize: 0.8, // Minimum height when dragging down
          maxChildSize: 0.8, // Maximum height when fully expanded
          expand: false, // To allow drag behavior
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CloseButton(onPressed: () {
                        Navigator.pop(context);
                      }),
                      const Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Search Filter",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: const Text(
                      "Categories",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Consumer<FilterProvider>(
                      builder: (context, value, child) {
                        return Wrap(
                          spacing: 10.0, // Space between chips
                          // runSpacing: 10.0, // Space between lines when wrapped
                          children: categories.map((category) {
                            bool isSelected =
                                selectedCategories.contains(category);

                            return ChoiceChip(
                              // side: const BorderSide(color: Colors.white),
                              side: BorderSide(color: Colors.transparent),
                              showCheckmark: false,
                              label: Text(category),
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                              selected: isSelected,
                              selectedColor: const Color(0XFF3D5CFF),
                              backgroundColor: Colors.grey[200],
                              onSelected: (bool selected) {
                                if (selected) {
                                  selectedCategories.add(category);
                                } else {
                                  selectedCategories.remove(category);
                                }
                                provider.updateWidget();
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: const Text(
                      "Price",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Consumer<FilterProvider>(
                    builder: (context, value, child) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: RangeSlider(
                          activeColor: blue,
                          labels: RangeLabels(
                            startValue.toString(),
                            endValue.toString(),
                          ),
                          onChangeStart: (value) {
                            startValue = value.start;
                            print("${startValue}");
                          },
                          onChangeEnd: (value) {
                            endValue = value.end;
                            print("${endValue}");
                          },
                          min: 0,
                          max: 2000,
                          divisions: 20,
                          values: RangeValues(startValue, endValue),
                          onChanged: (value) {
                            startValue = value.start;
                            endValue = value.end;
                            provider.updateWidget();
                          },
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            title: "Cancel",
                            isWhiteColor: true,
                            width: 100),
                        CustomButton(
                          onTap: () {
                            final provider = Provider.of<FilterResultProvider>(
                                context,
                                listen: false);
                            if (selectedCategories.isEmpty) {
                              productController
                                  .filterProduct(
                                      categories,
                                      widget.productDataList,
                                      _controller.text.trim(),
                                      startValue,
                                      endValue)
                                  .whenComplete(
                                () {
                                  showDescriptionBool = List.generate(
                                    productController.filteredProduct.length,
                                    (index) => false,
                                  );
                                },
                              );
                            } else {
                              productController
                                  .filterProduct(
                                      selectedCategories,
                                      widget.productDataList,
                                      _controller.text.trim(),
                                      startValue,
                                      endValue)
                                  .whenComplete(
                                () {
                                  showDescriptionBool = List.generate(
                                    productController.filteredProduct.length,
                                    (index) => false,
                                  );
                                },
                              );
                            }

                            provider.updateWidget();
                            Navigator.pop(context);
                          },
                          title: "Apply Filter",
                          isWhiteColor: false,
                          width: 230,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
