import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kip_shooping/controller/shared_preferences.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';

class SignUpController {
  final _auth = FirebaseAuth.instance;
  final sharedPref = SharedPref();

  Future<void> signupWithEmail(String email, String password,
      BuildContext context, String userName) async {
    try {
      customLoading(context, "Signing up..");
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();
      Navigator.pop(context);
      if (userCredential.user != null) {
        userCredential.user!.updateDisplayName(userName);
        sharedPref.storeNewUser(true);
        Navigator.pushNamed(context, 'home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.toString() ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Email Already in Use",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      print("Error Occured While Sign up With Email:$e");
    }
  }

  Future<void> loginWithEmail(
      String email, String password, BuildContext context) async {
    try {
      customLoading(context, "Verifying");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pop(context);
      if (userCredential.user != null) {
        sharedPref.storeNewUser(false);
        sharedPref.storeData("email", email);
        sharedPref.storeData("userName", userCredential.user!.displayName!);
        Navigator.pushNamed(context, 'nav');
        print("Login Successfully!");
      }
    } catch (e) {
      if (e.toString() ==
          '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Email or Password is Incorrect",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      Navigator.pop(context);

      print("Error Occured while login with email:$e");
    }
  }
}
