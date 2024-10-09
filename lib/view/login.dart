import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:kip_shooping/widgets/custom_button.dart';
import 'package:kip_shooping/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool termsAndConditionCheck = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0XFFF0F0F2),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.bottomLeft,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: const BoxDecoration(
              color: Color(0XFFF0F0F2),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(
                  20.0,
                ),
                topStart: Radius.circular(
                  20.0,
                ),
              ),
            ),
            child: const ListTile(
              title: Text(
                "Log in",
                style: TextStyle(
                  height: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              subtitle: Text(""),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              // border: Border(top: BorderSide(color: Colors.black)),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(
                  20.0,
                ),
                topStart: Radius.circular(
                  20.0,
                ),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: emailController,
                    title: "Your Email",
                    isPassword: false,
                    showIcon: false,
                  ),
                  CustomTextField(
                    controller: passController,
                    title: "Password",
                    isPassword: true,
                    showIcon: true,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(color: grey),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  CustomButton(
                    isWhiteColor: false,
                    title: "Log in",
                    width: double.infinity,
                    onTap: () {
                      customDialogue();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(color: grey, fontSize: 15),
                          ),
                          WidgetSpan(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5.0),
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: blue, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      // Left divider
                      const Expanded(
                        child: Divider(
                          thickness: 1.5, // Thickness of the line
                        ),
                      ),
                      // Text in the middle
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Or login with',
                          style: TextStyle(color: grey),
                        ),
                      ),
                      // Right divider
                      const Expanded(
                        child: Divider(
                          thickness: 1.5, // Thickness of the line
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Image.asset(
                            "assets/images/google.png",
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Image.asset(
                            "assets/images/fb.png",
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void customDialogue() async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  "assets/svg/verified.svg",
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Success",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "Congratulations, you have\ncompleted your registration!",
                  style: TextStyle(color: grey),
                ),
                const CustomButton(
                    title: "Done", isWhiteColor: false, width: double.infinity)
              ],
            ),
          ),
        );
      },
    );
  }
}
