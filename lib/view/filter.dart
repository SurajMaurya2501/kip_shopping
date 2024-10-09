import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:kip_shooping/widgets/custom_button.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> categories = [
    'Design',
    'Painting',
    'Coding',
    'Music',
    'Visual Identity',
    'Mathematics'
  ];
  List<String> selectedCategories = ['Design', 'Coding'];

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
                    child: Wrap(
                      spacing: 10.0, // Space between chips
                      runSpacing: 10.0, // Space between lines when wrapped
                      children: categories.map((category) {
                        bool isSelected = selectedCategories.contains(category);

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
                            setState(() {
                              if (selected) {
                                selectedCategories.add(category);
                              } else {
                                selectedCategories.remove(category);
                              }
                            });
                          },
                        );
                      }).toList(),
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
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: RangeSlider(
                      activeColor: blue,
                      labels: const RangeLabels("1000", "10000"),
                      min: 0,
                      max: 100000,
                      values: const RangeValues(1000, 10000),
                      onChanged: (value) {},
                    ),
                  ),
                  const Spacer(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                          title: "Cancel", isWhiteColor: true, width: 100),
                      CustomButton(
                          title: "Apply Filter",
                          isWhiteColor: false,
                          width: 250)
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
