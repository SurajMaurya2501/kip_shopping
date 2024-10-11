import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kip_shooping/controller/shared_preferences.dart';
import 'package:kip_shooping/widgets/common_widgets.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final faceBookAuth = FacebookAuth.instance;
  final sharedPref = SharedPref();

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      customLoading(context, "");

      final AuthCredential credential =
          GoogleAuthProvider.credential(accessToken: googleAuth.accessToken);

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        userCredential.user!.updateDisplayName(googleUser.displayName);
        sharedPref.storeData("email", userCredential.user!.email!);
        Navigator.pushNamed(context, "home");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Login Failed",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      return userCredential.user;
    } catch (e) {
      print("Error Occured While Google Login:$e");
      return null;
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      // Trigger the Facebook sign-in process
      final LoginResult result = await faceBookAuth.login();

      // Check if login is successful
      if (result.status == LoginStatus.success) {
        // Obtain the Facebook Auth Credential
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        // Sign in to Firebase with the credential
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        if (userCredential.user != null) {
          userCredential.user!
              .updateDisplayName(userCredential.user!.displayName);
          // sharedPref.storeData("email", userCredential.user!.email!);
          print(userCredential.user!.email!);
          Navigator.pushNamed(context, "home");
        }
      } else {
        print('Facebook login failed: ${result.status}');
        return null;
      }
    } catch (e) {
      print('Error during Facebook login: $e');
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print("User signed out");
  }

  Future<void> signOutFacebook() async {
    await faceBookAuth.logOut();
    await _auth.signOut();
    print("User signed out");
  }
}
