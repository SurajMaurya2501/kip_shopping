import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kip_shooping/controller/login_controller.dart';
import 'package:kip_shooping/controller/sign_up_controller.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:kip_shooping/widgets/custom_button.dart';
import 'package:kip_shooping/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final signUpController = SignUpController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final loginController = LoginController();
  bool termsAndConditionCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  validator: () {
                    String pattern =
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                    RegExp regex = RegExp(pattern);
                    if (emailController.text.trim() == null ||
                        emailController.text.trim().isEmpty) {
                      return "Email is Required";
                    } else if (!regex.hasMatch(emailController.text.trim())) {
                      return 'Enter a valid email';
                    }

                    return "";
                  },
                  controller: emailController,
                  title: "Your Email",
                  isPassword: false,
                  showIcon: false,
                ),
                CustomTextField(
                  validator: () {
                    if (passController.text.trim() == null ||
                        passController.text.trim().isEmpty) {
                      return "Password is Required";
                    }
                    return "";
                  },
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
                    signUpController.loginWithEmail(emailController.text.trim(),
                        passController.text.trim(), context);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                  ),
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
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, "signup");
                              },
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
                      GestureDetector(
                        onTap: () {
                          loginController.signInWithGoogle(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Image.asset(
                            "assets/images/google.png",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          loginController.signInWithFacebook(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Image.asset(
                            "assets/images/fb.png",
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
