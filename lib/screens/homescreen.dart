import 'package:dtouchdental/constants/constants.dart';
import 'package:dtouchdental/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dtouchdental/components/appbar.dart';
import 'package:dtouchdental/components/homebody.dart';
import 'package:dtouchdental/screens/editprofilescreen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  var toggle = 'A';
  var userCredential;
  @override
  void initState() {
    userCredential = FirebaseAuth.instance.currentUser;
    print(userCredential);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _index = 0;
                });
              },
              icon: const Icon(Constant.kHomeIcon)),
          IconButton(
              onPressed: () {
                setState(() {
                  _index = 1;
                });
              },
              icon: const Icon(Constant.kPersonIcon)),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.to(()=>const LoginScreen());
              },
              icon: const Icon(Constant.kLogoutIcon)),
        ],
        backgroundColor: Constant.kAppBarColor,
        leading: const Image(
          image: Constant.kLogoOnly,
        ),
      ),
      body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: (_index == 0) ? const HomeBody() : const EditProfileScreen()),
    );
  }
}
