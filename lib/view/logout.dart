import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kip_shooping/controller/login_controller.dart';
import 'package:kip_shooping/controller/shared_preferences.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: 40,
        width: 100,
        child: ElevatedButton(
          onPressed: () async {
            customAlert("Logout");
          },
          child: Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      )),
    );
  }

  void customAlert(String title) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            ElevatedButton(
              onPressed: () {
                final loginController = LoginController();
                customLoading(context, "Logging out");

                Timer(
                  Duration(
                    seconds: 2,
                  ),
                  () {
                    final sharedPref = SharedPref();
                    sharedPref.deleteData("email");
                    sharedPref.deleteData("userName");
                    loginController.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "first",
                      (route) => false,
                    );
                  },
                );
              },
              child: const Text(
                "Yes",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
              ),
            ),
          ],
        );
      },
    );
  }
}
