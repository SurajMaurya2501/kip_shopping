import 'package:flutter/material.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            color: Colors.blue,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 120,
            child: Card(
              elevation: 10.0,
              child: Container(
                margin:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Learned today",
                          style: TextStyle(color: grey),
                        ),
                        Text(
                          "My Course",
                          style: TextStyle(color: grey),
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "46min",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: " / 60min",
                            style: TextStyle(
                              color: grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 6,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.white, Colors.deepOrange],
                          stops: [0.0, 0.9],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
