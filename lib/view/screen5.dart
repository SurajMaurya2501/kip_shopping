import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kip_shooping/controller/shared_preferences.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _auth = FirebaseAuth.instance;
  final sharefPref = SharedPref();
  bool isNewUser = false;

  @override
  void initState() {
    getNewUserBool().whenComplete(
      () {
        if (isNewUser) {
          successDialogue(context);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width,
            top: 0,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.22,
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 10.0,
                  right: 10.0,
                ),
                color: blue,
                child: ListTile(
                  trailing: SvgPicture.asset("assets/svg/user.svg"),
                  title: Text(
                    "Hi, ${_auth.currentUser?.displayName ?? "Kristin"}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "Let's start learning",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height * 0.78,
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              margin: const EdgeInsets.only(left: 15.0),
              padding: const EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * 0.78,
              child: Column(
                children: [
                  Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                          child: Card(
                            color: const Color(0xFFCEECFE),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: SvgPicture.asset(
                                      "assets/svg/card1.svg",
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  top: 20,
                                  left: 20,
                                  child: Text(
                                    "What do you want to\nlearn today?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(
                                        5.0,
                                      ),
                                    ),
                                    child: const Text(
                                      "Get Started",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Card(
                            color: const Color(0xFFCEECFE),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 20,
                                  top: 0,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: SvgPicture.asset(
                                      "assets/svg/card2.svg",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Learning Plan",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: GridView(
                      padding: const EdgeInsets.only(top: 10.0),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 2.5,
                              mainAxisSpacing: 10.0),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          child: Card(
                            elevation: 10.0,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  margin: const EdgeInsets.only(
                                                      right: 15.0),
                                                  child:
                                                      const CircularProgressIndicator()),
                                            ),
                                            const TextSpan(
                                                text: "Packaging Design",
                                                style: TextStyle(
                                                    color: Colors.black))
                                          ]),
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text: "40",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                                text: "/48",
                                                style: TextStyle(color: grey))
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(children: [
                                          WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Container(
                                                height: 20,
                                                width: 20,
                                                margin: const EdgeInsets.only(
                                                    right: 15.0),
                                                child:
                                                    const CircularProgressIndicator()),
                                          ),
                                          const TextSpan(
                                              text: "Product Design",
                                              style: TextStyle(
                                                  color: Colors.black))
                                        ]),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: "6",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "/24",
                                            style: TextStyle(
                                              color: grey,
                                            ),
                                          )
                                        ]),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          child: Card(
                              color: const Color(0xFFEFE0FF),
                              elevation: 10.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20.0, left: 10.0),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Meetup",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Color(
                                              0xFF440687,
                                            ),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Off-line exchange of learning\nexperience",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(
                                              0xFF440687,
                                            ),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: CircleAvatar(
                                      backgroundColor: const Color(0xFFF5ECFF),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor:
                                            const Color(0xFFF8F2FF),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              height: 50,
                                              width: 50,
                                              top: 8,
                                              right: 15,
                                              child: SvgPicture.asset(
                                                "assets/svg/meetup_user2.svg",
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                            Positioned(
                                              height: 45,
                                              width: 45,
                                              right: -5,
                                              bottom: 5,
                                              child: SvgPicture.asset(
                                                "assets/svg/meetup_user1.svg",
                                                height: 45,
                                                width: 45,
                                              ),
                                            ),
                                            Positioned(
                                              height: 45,
                                              width: 45,
                                              left: -5,
                                              bottom: 5,
                                              child: SvgPicture.asset(
                                                "assets/svg/meetup_user3.svg",
                                                height: 45,
                                                width: 45,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
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
                          style: TextStyle(color: blue),
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
                      margin: const EdgeInsets.only(
                        top: 10.0,
                      ),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      //   floatingActionButton: Container(
      //     padding: const EdgeInsets.only(top: 20.0),
      //     child: CircleAvatar(
      //       radius: 42,
      //       backgroundColor: Colors.white,
      //       child: Container(
      //         margin: const EdgeInsets.only(top: 5.0),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             CircleAvatar(
      //               radius: 31,
      //               child: Icon(
      //                 Icons.search,
      //                 color: blue,
      //                 size: 35,
      //               ),
      //             ),
      //             const Text(
      //               "Search",
      //               textAlign: TextAlign.center,
      //               style: TextStyle(fontSize: 11),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
    );
  }

  Future<void> getNewUserBool() async {
    isNewUser = await sharefPref.getNewUser();
  }
}
