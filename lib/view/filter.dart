import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kip_shooping/controller/product_controller.dart';
import 'package:kip_shooping/model/product_model.dart';
import 'package:kip_shooping/provider/filer_provider.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:kip_shooping/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
  final List<ProductModel> productDataList;
  const FilterPage({super.key, required this.productDataList});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final productController = ProductController();

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

  double startValue = 0.0, endValue = 0.0;

  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(
        milliseconds: 500,
      ),
      () {
        _openBottomSheet(context, "category");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }

  void _openBottomSheet(BuildContext context, String category) {
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
      builder: (BuildContext context) {
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
                              side: const BorderSide(color: Colors.white),
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
                        child: Stack(alignment: Alignment.topCenter, children: [
                          RangeSlider(
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
                            max: 100000,
                            values: RangeValues(startValue, endValue),
                            onChanged: (value) {
                              startValue = value.start;
                              endValue = value.end;
                              provider.updateWidget();
                            },
                          ),
                          Positioned(
                            height: 50,
                            width: 50,
                            left: 0,
                            top: 0,
                            child: Text(
                              '${startValue}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          ),
                          Positioned(
                            left: 40 + (endValue / 100) * 250,
                            top: 35,
                            child: Text(
                              '${endValue}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                          title: "Cancel", isWhiteColor: true, width: 100),
                      CustomButton(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            "filterResult",
                            arguments: {
                              "productDataList": widget.productDataList,
                              "selectedCategories": selectedCategories
                            },
                          );
                        },
                        title: "Apply Filter",
                        isWhiteColor: false,
                        width: 250,
                      )
                    ],
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
