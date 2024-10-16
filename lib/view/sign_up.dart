import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kip_shooping/controller/sign_up_controller.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';
import 'package:kip_shooping/widgets/custom_button.dart';
import 'package:kip_shooping/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = SignUpController();
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
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
                    validator: () {
                      if (usernameController.text.trim() == null ||
                          usernameController.text.trim().isEmpty) {
                        return "Username is Required";
                      }
                      return null;
                    },
                    controller: usernameController,
                    title: "Username",
                    isPassword: false,
                    showIcon: false,
                  ),
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

                      return null;
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
                      return null;
                    },
                    controller: passController,
                    title: "Password",
                    isPassword: true,
                    showIcon: true,
                  ),
                  CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (termsAndConditionCheck) {
                          signUpController.signupWithEmail(
                            emailController.text.trim(),
                            passController.text.trim(),
                            context,
                            usernameController.text.trim(),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Accept Terms & Conditions to Continue",
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      }
                    },
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
                            onTap: () {
                              Navigator.pushReplacementNamed(context, "login");
                            },
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
