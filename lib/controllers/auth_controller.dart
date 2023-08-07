import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/views/home_screen.dart';
import 'package:flutter_auth/views/login_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';
import '../widgets/indicator.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  RxBool isObsecure = true.obs;
  RxBool isObsecure2 = true.obs;
  void isLoggedIn() {
    if (_auth.currentUser != null) {
      print('user found');
      Get.to(() => HomeScreen());
    } else {
      print('user notq');
      Get.toNamed('/login-screen');
    }
  }

  @override
  void onReady() {
    super.onReady();
    print('reasdy');
    isLoggedIn();
  }

  toggleObsecure() {
    isObsecure.value = !isObsecure.value;
  }

  toggleObsecure2() {
    isObsecure2.value = !isObsecure2.value;
  }

  signInWithEmailandPassword() async {
    try {
      Indicator.showLoading();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Indicator.closeLoading();
      email.text = "";
      password.text = "";
      Get.to(() => HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user not found');
        Indicator.closeLoading();
        print('show ');
        return Get.snackbar(
          'Error',
          'user not found',
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        Indicator.closeLoading();
        return Get.snackbar(
          'Error',
          'Wrong password',
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  createUser() async {
    try {
      Indicator.showLoading();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text,
        password: confirmpassword.text,
      )
          .whenComplete(() {
        Indicator.closeLoading();
        Get.toNamed('/home');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Indicator.closeLoading();
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Indicator.closeLoading();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    Indicator.showLoading();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .whenComplete(() {
      Indicator.closeLoading();
      Get.toNamed('/home');
    });
  }

  void logout() async {
    Indicator.showLoading();
    await FirebaseAuth.instance.signOut().whenComplete(() {
      Indicator.closeLoading();
      Get.off(() => LoginScreen());
    });
    await GoogleSignIn().signOut();
  }
}
