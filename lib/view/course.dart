import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kip_shooping/view/filter.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<String> titles = ["All", "Popular", "New"];
  final _controller = TextEditingController();

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
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(
                    0xFFF4F3FD,
                  ),
                  hintText: "Find Course",
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FilterPage()));
                    },
                    icon: const Icon(
                      Icons.filter,
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
                "Choice your course",
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
              margin: const EdgeInsets.only(top: 20.0),
              height: MediaQuery.of(context).size.height * 0.44,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Design v1.0",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Robertson Connie",
                              ),
                              Text("\$180")
                            ],
                          ),
                        )
                      ],
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
