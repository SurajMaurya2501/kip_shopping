import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kip_shooping/controller/product_controller.dart';
import 'package:kip_shooping/model/product_model.dart';
import 'package:kip_shooping/provider/filer_provider.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:kip_shooping/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
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

  double startValue = 0.0, endValue = 100.0;

  List<String> selectedCategories = [];

  List<String> titles = ["All", "Popular", "New"];
  final _controller = TextEditingController();
  final productController = ProductController();
  bool isLoading = true;
  List<bool> showDescriptionBool = [];

  @override
  initState() {
    productController.getProductData().whenComplete(() {
      showDescriptionBool = List.generate(
        productController.productListData.length,
        (index) => false,
      );
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 40.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Course",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset("assets/svg/user.svg")
                ],
              ),
            ),
            TextField(
              controller: _controller,
              style: const TextStyle(
                color: Colors.black,
              ),
              onSubmitted: (value) {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed("filterResult", arguments: {
                  "productDataList": productController.productListData,
                  "selectedCategories": [""],
                  "searchText": value.trim(),
                  "startRange": 0.0,
                  "endRange": 5000.0
                });
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
                  )),
            ),
            Container(
              height: 120,
              margin: const EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          height: 85,
                          width: 190,
                          child: Card(
                            color: index == 0
                                ? const Color(0XFFCEECFE)
                                : const Color(0xFFEFE0FF),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: -20,
                          child: SvgPicture.asset(
                            index == 0
                                ? "assets/svg/card4.svg"
                                : "assets/svg/card5.svg",
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 40,
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 5.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  20.0,
                                ),
                                bottomLeft: Radius.circular(
                                  20.0,
                                ),
                              ),
                              color: Color.fromARGB(
                                255,
                                244,
                                245,
                                246,
                              ),
                            ),
                            child: Text(
                              index == 0 ? "Language" : "Painting",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color:
                                    index == 0 ? blue : const Color(0XFF9065BE),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: const Text(
                "Choose your product",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    width: 80,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          index == 0 ? blue : Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        titles[index],
                        style: TextStyle(
                            color: index == 0 ? Colors.white : Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20.0),
              height: MediaQuery.of(context).size.height * 0.44,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: productController.productListData.length,
                      itemBuilder: (context, index) {
                        ProductModel product =
                            productController.productListData[index];
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
                                    left: 10.0,
                                    top: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                        child: Text(
                                          product.title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      if (showDescriptionBool[index])
                                        Container(
                                          margin: EdgeInsets.only(top: 5.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
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
                                            fontWeight: FontWeight.bold,color: blue),
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
                            if (selectedCategories.isEmpty) {
                              Navigator.of(currentContext, rootNavigator: true)
                                  .pushNamed(
                                "filterResult",
                                arguments: {
                                  "productDataList":
                                      productController.productListData,
                                  "selectedCategories": categories,
                                  "searchText": "",
                                  "startRange": startValue,
                                  "endRange": endValue
                                },
                              );
                            } else {
                              Navigator.of(currentContext, rootNavigator: true)
                                  .pushNamed(
                                "filterResult",
                                arguments: {
                                  "productDataList":
                                      productController.productListData,
                                  "selectedCategories": selectedCategories,
                                  "searchText": "",
                                  "startRange": startValue,
                                  "endRange": endValue
                                },
                              );
                            }
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
