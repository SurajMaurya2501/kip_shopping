import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kip_shooping/widgets/custom_button.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 100.0),
            child: SvgPicture.asset(
              "assets/svg/laptop_user.svg",
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            "Create your own\nstudy plan",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            "Study according to the\nstudy plan,make study\nmore motivated",
            style: TextStyle(
              fontSize: 18,
              color: Color(
                0xFF858597,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, "signup");
                },
                isWhiteColor: false,
                title: "Sign up",
                width: 150,
              ),
              SizedBox(
                width: 20.0,
              ),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, "login");
                },
                isWhiteColor: true,
                title: "Log in",
                width: 150,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
