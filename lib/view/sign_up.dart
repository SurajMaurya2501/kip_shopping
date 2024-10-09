import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:kip_shooping/widgets/custom_button.dart';
import 'package:kip_shooping/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                "Sign Up",
                style: TextStyle(
                  height: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              subtitle: Text(
                " Enter your details below & free sign up",
              ),
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
                    controller: usernameController,
                    title: "Username",
                    isPassword: false,
                    showIcon: false,
                  ),
                  CustomTextField(
                    controller: emailController,
                    title: "Your Email",
                    isPassword: false,
                    showIcon: false,
                  ),
                  CustomTextField(
                    controller: passController,
                    title: "Password",
                    isPassword: false,
                    showIcon: true,
                  ),
                  const CustomButton(
                    isWhiteColor: false,
                    title: "Create account",
                    width: double.infinity,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Checkbox(
                        side: BorderSide(color: grey),
                        activeColor: const Color(
                          0xFF3D5CFF,
                        ),
                        value: termsAndConditionCheck,
                        onChanged: (value) {
                          termsAndConditionCheck = !termsAndConditionCheck;
                          setState(() {});
                        },
                      ),
                      Text(
                        "By creating an account you have to agree\nwith out terms and conditions",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: grey),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(color: grey, fontSize: 15),
                      ),
                      WidgetSpan(
                        child: Container(
                          margin: const EdgeInsets.only(left: 5.0),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                  color: blue,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ])),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
