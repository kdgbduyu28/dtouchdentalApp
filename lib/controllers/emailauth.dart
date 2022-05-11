import 'dart:convert';
import 'package:dtouchdental/constants/constants.dart';
import 'package:dtouchdental/screens/homescreen.dart';
import 'package:dtouchdental/screens/registerdetailsscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:progress_indicators/progress_indicators.dart';


void handleLogin(dynamic credentials) async {
  String email = credentials['email'];
  String password = credentials['password'];
  Get.back();
  try {
    Get.defaultDialog(
        title: 'Signing in',
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              JumpingDotsProgressIndicator(
                fontSize: 30,
              )
            ],
          ),
        )
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    Get.back();

    Get.to(()=>const HomeScreen());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Get.back();
      Get.snackbar(
        "Error",
        "Account does not exists",
        icon: const Icon(Constant.kErrorIcon),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Constant.kErrorColor,
          duration: const Duration(seconds: 1)
      );
    } else if (e.code == 'wrong-password') {
      Get.back();
      Get.snackbar(
        "Error",
        "Incorrect Password",
        icon: const Icon(Constant.kErrorIcon),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Constant.kErrorColor,
          duration: const Duration(seconds: 1)
      );
    }
  }

}

void handleRegister(dynamic credentials) async {

  String email = credentials['email'];
  String password = credentials['password2'];

  try {
    Get.defaultDialog(
      title: 'Signing up',
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              JumpingDotsProgressIndicator(
                fontSize: 30,
              )
          ],
        ),
      )
    );
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password);
    Get.back();
    Get.snackbar(
      "Success",
      "Successful Registration",
      icon: const Icon(Constant.kErrorIcon),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Constant.kErrorColor,
        duration: const Duration(seconds: 1)
    );
    Get.back();
    Get.to(()=>const RegisterDetailsScreen());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Get.back();
      Get.snackbar(
        "Error",
        "Password is too weak",
        icon: const Icon(Constant.kErrorIcon),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Constant.kErrorColor,
          duration: const Duration(seconds: 1)
      );
    } else if (e.code == 'email-already-in-use') {
      Get.back();
      Get.snackbar(
          "Error",
          "Email is already in use",
          icon: const Icon(Constant.kErrorIcon),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Constant.kErrorColor,
          duration: const Duration(seconds: 1)
      );
    }
  }
  catch (e) {
    Get.back();
    print(e);
  }



}

void handlePWReset(dynamic credentials) async {
  print(credentials);
  String email = credentials['email'];
  Get.defaultDialog(
    title: "Password Reset",
    content: const Text("Password has been sent to your email"),
    actions: [
      TextButton(onPressed: () {
        Get.back();
      }, child: const Text('Close'))
    ]
  );
}
