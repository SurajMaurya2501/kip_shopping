import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kip_shooping/view/course.dart';
import 'package:kip_shooping/view/home.dart';
import 'package:kip_shooping/view/logout.dart';
import 'package:kip_shooping/view/under_development.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  // List of screens for navigation (add your screens here)
  final List<Widget> _pages = [
    HomePageScreen(),
    CourseScreen(),
    UnderDevelopment(),
    LogoutScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: BottomAppBar(
              color: Colors.white,
              padding: EdgeInsets.all(0.0),
              shape: CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavBarItem(
                    Icons.home,
                    "Home",
                    0,
                  ),
                  buildNavBarItem(Icons.book, "Course", 1),
                  SizedBox(width: 20),
                  buildNavBarItem(Icons.message_rounded, "Message", 2),
                  buildNavBarItem(Icons.person, "Account", 3),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: MediaQuery.of(context).size.width * 0.4,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, "filterResult");
                },
                backgroundColor: Color(0XFFF4F3FD),
                child: SvgPicture.asset("assets/svg/search.svg"),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 3,
              color: _currentIndex == index ? blue : Colors.transparent,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: _currentIndex == index ? blue : Color(0xFFF4F3FD),
            ),
            Text(
              label,
              style: TextStyle(
                color: _currentIndex == index ? blue : Colors.grey,
                fontSize: 11,
              ),
            )
          ],
        ),
      ),
    );
  }
}
