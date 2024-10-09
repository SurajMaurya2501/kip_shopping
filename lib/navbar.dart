import 'package:flutter/material.dart';
import 'package:kip_shooping/view/course.dart';
import 'package:kip_shooping/view/screen5.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: const [
          HomePageScreen(),
          CourseScreen(),
          CourseScreen(),
          CourseScreen(),
          CourseScreen(),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Home",
          ),
          PersistentBottomNavBarItem(
              icon: const Icon(
                Icons.book,
                color: Color(0xFFF4F3FD),
              ),
              title: "Course"),
          PersistentBottomNavBarItem(icon: Container(), title: "Search"),
          PersistentBottomNavBarItem(
              icon: const Icon(
                Icons.message,
                color: Color(0xFFF4F3FD),
              ),
              title: "Message"),
          PersistentBottomNavBarItem(
              icon: const Icon(
                Icons.account_balance,
                color: Color(0xFFF4F3FD),
              ),
              title: "Account")
        ],
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: false,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
        navBarStyle: NavBarStyle.style3,
        hideOnScrollSettings: const HideOnScrollSettings(
          hideNavBarOnScroll: true,
          // scrollControllers: _scrollControllers,
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: CircleAvatar(
          radius: 42,
          backgroundColor: Colors.white,
          child: Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFF4F3FD),
                  radius: 31,
                  child: Icon(
                    Icons.search,
                    color: blue,
                    size: 35,
                  ),
                ),
                const Text(
                  "Search",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
